export type ContainerConsumer = (layer: PIXI.Container) => void

/**
 * Given by the SDK
 */
export interface FrameInfo {
  number: number
  frameDuration: number
  date: number
}
/**
 * Given by the SDK
 */
export interface CanvasInfo {
  width: number
  height: number
  oversampling: number
}
/**
 * Given by the SDK
 */
export interface PlayerInfo {
  name: string
  avatar: PIXI.Texture
  color: number
  index: number
  isMe: boolean
  number: number
  type?: string
}

export interface EventDto {
  type: number
  animData: AnimData
}

export interface PlayerDto {
  message: string
}

export interface FrameDataDTO {
  scans: ScanSummaryDto[][][]
  fishes: FishDto[]
  uglies: UglyDto[]
  scores: number[]
  drones: DroneDto[][]
  fishMap: Record<number, FishDto>
  uglyMap: Record<number, UglyDto>
}

export interface FrameData extends FrameDataDTO {
  previous: FrameData
  frameInfo: FrameInfo
}

export interface CoordDto {
  x: number
  y: number
}

export interface GlobalDataDTO {
  width: number
  height: number
  fishes: FishGlobalDto[]
  fishMap: Record<number, FishGlobalDto>
  uglies: number[]
  ratio: number
  dronesPerPlayer: number
  fishWillFlee: boolean
  isDemo: boolean
  simpleScans: boolean
}
export interface GlobalData extends GlobalDataDTO {
  players: PlayerInfo[]
  playerCount: number
}

export interface AnimData {
  start: number
  end: number
}

export interface Effect {
  busy: boolean
  display: PIXI.DisplayObject
}

/* View entities */
export interface FishGlobalDto {
  id: number
  color: number
  type: number
}

export interface EntityDto {
  id: number
  x: number
  y: number
  vx?: number
  vy?: number
}
export interface FishDto extends EntityDto {
  isFleeing: boolean
}

export interface UglyDto extends EntityDto {
  foundTarget: boolean
}
export interface ScanDto {
  color: number
  type: number
}
export interface DroneDto extends EntityDto {
  targetX: number
  targetY: number
  battery: number
  light: boolean
  dead: boolean
  dieAt: number
  message: string
  scans: ScanDto[]
  didReport: boolean
  fishesScannedThisTurn: number[]
}

export interface ScanSummaryDto {
  code: number
  hasBonus: boolean
}

/* View entities */
export interface Entity {
  container: PIXI.Container
  sprite: PIXI.Sprite
  id: number
  targetScaleX: number
  scaler: PIXI.Container
}

export interface Fish extends Entity {
}

export interface Drone extends Entity {
  container: PIXI.Container
  lightRadius: PIXI.Graphics
  radius: PIXI.Graphics
  engineRadius: PIXI.Graphics
  reportAnimation: PIXI.AnimatedSprite
  isDeadNow: boolean
  scanAnimation: PIXI.AnimatedSprite
}

export interface Ugly extends Entity {
  container: PIXI.Container
  aggroSprite: PIXI.AnimatedSprite
}

export interface SquidGrid {
  array: SquidGridCell[][]
  container: PIXI.Container
}

export interface SquidGridCell {
  sprite: PIXI.Sprite
  bonusIcon: PIXI.DisplayObject
  lostIcon: PIXI.DisplayObject
  feedbackScanAnimation: PIXI.AnimatedSprite
}
