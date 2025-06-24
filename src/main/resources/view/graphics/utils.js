import * as utils from '../core/utils.js';
export function setAnimationProgress(fx, progress) {
    let idx = Math.floor(progress * fx.totalFrames);
    idx = Math.min(fx.totalFrames - 1, idx);
    fx.gotoAndStop(idx);
    return idx;
}
export function distance(a, b) {
    return Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}
export function fit(entity, maxWidth, maxHeight) {
    entity.scale.set(utils.fitAspectRatio(entity.width, entity.height, maxWidth, maxHeight));
}
export function setSize(sprite, size) {
    sprite.width = size;
    sprite.height = size;
}
export function bounce(t) {
    return 1 + (Math.sin(t * 10) * 0.5 * Math.cos(t * 3.14 / 2)) * (1 - t) * (1 - t);
}
export function generateText(text, color, size, strokeThickness = 4) {
    const drawnText = new PIXI.Text(typeof text === 'number' ? '' + text : text, {
        fontSize: Math.round(size) + 'px',
        fontFamily: 'Arial',
        fontWeight: 'bold',
        fill: color,
        stroke: 0x0,
        strokeThickness,
        lineHeight: Math.round(size)
    });
    drawnText.anchor.x = 0.5;
    drawnText.anchor.y = 0.5;
    return drawnText;
}
export function last(arr) {
    return arr[arr.length - 1];
}
export function keyOf(x, y) {
    return `${x},${y}`;
}
export function angleDiff(a, b) {
    return Math.abs(utils.lerpAngle(a, b, 0) - utils.lerpAngle(a, b, 1));
}
export function pad(text, n, char = '0') {
    let out = text.toString();
    while (out.length < n) {
        out = char + out;
    }
    return out;
}
export function randomChoice(rand, coeffs) {
    const total = coeffs.reduce((a, b) => a + b, 0);
    const b = 1 / total;
    const weights = coeffs.map(v => v * b);
    let cur = 0;
    for (let i = 0; i < weights.length; ++i) {
        cur += weights[i];
        if (cur >= rand) {
            return i;
        }
    }
    return 0;
}
export function sum(arr) {
    return arr.reduce((a, b) => a + b, 0);
}
const TYPE_NAMES = ['Pieuvre', 'Fish', 'Crabe'];
export function getFishPng(colorIdx, typeIdx) {
    const typeName = TYPE_NAMES[typeIdx];
    return `${typeName}_${colorIdx + 1}`;
}
