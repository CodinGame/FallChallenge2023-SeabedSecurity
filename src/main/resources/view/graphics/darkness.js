import { getRenderer } from '../core/rendering.js';
import { HEIGHT, WIDTH } from '../core/constants.js';
import { LIGHT_SCAN_RANGE } from './gameConstants.js';
export const DISC_RADIUS = 218;
const FOG_SCALE = 0.4;
export function initDarkness(layer) {
    if (this.canvasMode) {
        return;
    }
    const darkness = new PIXI.Sprite(PIXI.Texture.WHITE);
    darkness.width = WIDTH;
    darkness.height = HEIGHT;
    darkness.tint = 0x0;
    darkness.alpha = 0.33;
    // darkness.alpha = 1
    const buffer = new PIXI.Container();
    const backdrop = new PIXI.Sprite(PIXI.Texture.WHITE);
    backdrop.width = WIDTH;
    backdrop.height = HEIGHT;
    const discLayer = new PIXI.Container();
    const discs = [[], []];
    const texture = PIXI.RenderTexture.create({ width: WIDTH * FOG_SCALE, height: HEIGHT * FOG_SCALE });
    // TODO: flag texture for destruction using flagForDestructionOnReinit(backdrop)
    const mask = new PIXI.Sprite(texture);
    buffer.scale.set(FOG_SCALE);
    const options = this.api.options;
    for (let i = 0; i < this.globalData.playerCount; ++i) {
        for (let k = 0; k < this.globalData.dronesPerPlayer; ++k) {
            const disc = this.asLayer(initDisc(LIGHT_SCAN_RANGE));
            discs[i][k] = disc;
            discLayer.addChild(disc);
            Object.defineProperty(disc, 'visible', { get: () => options.darkness === true || options.darkness === i });
        }
    }
    Object.defineProperty(darkness, 'visible', { get: () => options.darkness !== false && !this.canvasMode });
    buffer.addChild(backdrop);
    buffer.addChild(discLayer);
    mask.scale.set(1 / FOG_SCALE);
    const renderFog = () => {
        if (!texture._destroyed) {
            getRenderer().render(buffer, texture);
        }
    };
    this.api.renderFog = renderFog;
    this.discs = discs;
    layer.addChild(darkness);
    layer.addChild(mask);
    darkness.mask = mask;
    const xOffset = WIDTH / 2 - this.globalData.width / 2 * this.globalData.ratio;
    discLayer.x = xOffset;
    discLayer.y = 300 * this.globalData.ratio;
}
function initDisc(radius) {
    return (layer) => {
        const normal = PIXI.Sprite.from('disc_black.png');
        layer.addChild(normal);
        normal.anchor.set(0.5);
    };
}
