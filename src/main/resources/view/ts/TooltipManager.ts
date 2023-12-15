import { HEIGHT } from '../core/constants.js'
import { ScanDto } from './types.js'
import { fit, getFishPng } from './utils.js'
import * as utils from '../core/utils.js'

/* global PIXI */
const MAX_FISH_HEIGHT = 61
const MAX_FISH_WIDTH = 72

const PADDING = 5
const CURSOR_WIDTH = 20
const LINE_HEIGHT = 36
const SCANS_RECT = {
  x: 0,
  y: 180,
  w: 232
}
const SCANS_SEP = 65
const SCANS_HEIGHT = MAX_FISH_HEIGHT

function generateText (text, size, color, align): PIXI.Text {
  var textEl = new PIXI.Text(text, {
    fontSize: Math.round(size / 1.2) + 'px',
    fontFamily: 'Lato',
    fontWeight: 'bold',
    fill: color,
    lineHeight: size
  })

  if (align === 'right') {
    textEl.anchor.x = 1
  } else if (align === 'center') {
    textEl.anchor.x = 0.5
  }

  return textEl
};

export class TooltipManager {
  tooltip: PIXI.Container
  tooltipContainer: PIXI.Container
  tooltipLabel: PIXI.Text
  tooltipBackground: PIXI.Graphics
  tooltipOffset: number
  scansContainer: PIXI.Container
  debug: PIXI.Graphics
  scans: PIXI.Sprite[]
  registry: {element: PIXI.DisplayObject, getText: () => string, getScans: () => ScanDto[]}[]
  inside: {[id: number]: boolean}
  getGlobalText: (data: PIXI.InteractionData) => string
  lastEvent: PIXI.InteractionEvent

  reinit () {
    const container = new PIXI.Container()
    const tooltip = new PIXI.Container()
    const background = new PIXI.Graphics()
    const label = generateText('DEFAULT', 36, 0xFFFFFF, 'left')

    label.position.x = PADDING
    label.position.y = PADDING

    tooltip.visible = false
    tooltip.addChild(background)
    tooltip.addChild(label)
    this.tooltipBackground = background
    this.tooltipLabel = label
    this.tooltipContainer = container
    this.tooltip = tooltip
    this.registry = []
    this.inside = {}
    this.tooltipOffset = 0
    this.getGlobalText = null

    this.scansContainer = new PIXI.Container()
    this.scans = []
    for (let i = 0; i < 12; ++i) {
      const scan = PIXI.Sprite.from('Pieuvre_1')
      scan.visible = false

      scan.anchor.set(0.5)
      scan.x = (i % 4) * SCANS_SEP
      scan.y = Math.floor(i / 4) * SCANS_HEIGHT
      scan.x += MAX_FISH_WIDTH / 2
      scan.y += MAX_FISH_HEIGHT / 2

      this.scansContainer.addChild(scan)
      this.scans.push(scan)
    }

    container.addChild(this.tooltip)
    container.addChild(this.scansContainer)
    // this.debug = new PIXI.Graphics()
    // container.addChild(this.debug)
    return container
  }

  clear () {
    this.inside = {}
  }

  registerGlobal (getText: (data: PIXI.InteractionData) => string) {
    this.getGlobalText = getText
  }

  register (element: PIXI.DisplayObject, getText: () => string, getScans: () => ScanDto[]) {
    this.registry.push({ element, getText, getScans })
  }

  showTooltip (text: string) {
    this.setTooltipText(this.tooltip, text)
  }

  setTooltipText (tooltip: PIXI.Container, text: string) {
    this.tooltipLabel.text = text

    const width = this.tooltipLabel.width + PADDING * 2
    const height = this.tooltipLabel.height + PADDING * 2

    this.tooltipOffset = -width

    this.tooltipBackground.clear()
    this.tooltipBackground.beginFill(0x0, 0.9)
    this.tooltipBackground.drawRect(0, 0, width, height)
    this.tooltipBackground.endFill()

    tooltip.visible = true
  }

  updateGlobalText () {
    if (this.lastEvent != null) {
      this.moveTooltip(this.lastEvent)
    }
  }

  // Iterate over all the elements in the registry and set true/false in the inside map
  updateHovers () {
    for (let i = 0; i < this.registry.length; ++i) {
      const { element } = this.registry[i]
      const mousePosition = this.lastEvent.data.getLocalPosition(element)
      let inside
      if (element.hitArea != null) {
        inside = element.hitArea.contains(mousePosition.x, mousePosition.y)
      } else {
        inside = pointWithinBound(mousePosition, element.getLocalBounds())
      }
      if (inside) {
        this.inside[i] = true
      } else {
        delete this.inside[i]
      }
    }
  }

  moveTooltip (event: PIXI.InteractionEvent) {
    this.lastEvent = event

    const newPosition = event.data.getLocalPosition(this.tooltipContainer)

    this.updateHovers()

    let xOffset = this.tooltipOffset - 20
    let yOffset = +40

    if (newPosition.x + xOffset < 0) {
      xOffset = CURSOR_WIDTH
    }

    if (newPosition.y + this.tooltip.height + yOffset > HEIGHT) {
      yOffset = HEIGHT - newPosition.y - this.tooltip.height
    }

    this.tooltip.position.x = newPosition.x + xOffset
    this.tooltip.position.y = newPosition.y + yOffset

    this.scansContainer.visible = false

    const textBlocks = []
    const insideKeys = Object.keys(this.inside)

    for (const key of insideKeys) {
      const registryIdx = parseInt(key)
      const { getText, getScans } = this.registry[registryIdx]

      let text = getText()

      const scansToShow = getScans?.() ?? []
      if (scansToShow.length > 0) {
        if (insideKeys.length === 1) {
          // The space where the icons will go
          text += '\nscans:\n                              '

          if (scansToShow.length > 4) {
            text += '\n'
          }
          if (scansToShow.length > 8) {
            text += '\n'
          }

          let showIdx = 0

          let scanRectH = LINE_HEIGHT
          if (scansToShow.length > 4) {
            scanRectH = LINE_HEIGHT * 2
          }
          if (scansToShow.length > 8) {
            scanRectH = LINE_HEIGHT * 3
          }
          // Space above the underscores
          scanRectH += 30

          for (const scan of this.scans) {
            scan.visible = false
            if (showIdx < scansToShow.length) {
              const { color, type } = scansToShow[showIdx]
              scan.texture = PIXI.Texture.from(getFishPng(color, type))
              scan.visible = true
            }
            ++showIdx

            this.scansContainer.position.set(
              this.tooltip.position.x + SCANS_RECT.x,
              this.tooltip.position.y + SCANS_RECT.y
            )
          }
          this.scansContainer.visible = true
          this.scansContainer.scale.set(1)

          const scanMaxWidth = Math.min(4, scansToShow.length) * SCANS_SEP
          const scale = Math.min(1, utils.fitAspectRatio(scanMaxWidth, this.scansContainer.height, SCANS_RECT.w, scanRectH))
          this.scansContainer.scale.set(scale)
        } else {
          text += '\nscans:\n'
          let idx = 0
          for (const scan of scansToShow) {
            text += `(${scan.color}, ${scan.type})`
            if (idx % 4 === 3) {
              text += '\n'
            } else {
              text += ' '
            }
            ++idx
          }
        }
      }

      if (text != null && text.length > 0) {
        textBlocks.push(text)
      }
    }

    if (this.getGlobalText != null) {
      const text = this.getGlobalText(event.data)
      if (text != null && text.length > 0) {
        textBlocks.push(text)
      }
    }
    if (textBlocks.length > 0) {
      this.showTooltip(textBlocks.join('\n________\n'))
    } else {
      this.hideTooltip()
    }
  }

  hideTooltip () {
    this.tooltip.visible = false
  }
}

function pointWithinBound (position: PIXI.IPoint, bounds: PIXI.Rectangle) {
  return position.x <= bounds.x + bounds.width &&
  position.y <= bounds.y + bounds.height &&
  position.x >= bounds.x &&
  position.y >= bounds.y
}
