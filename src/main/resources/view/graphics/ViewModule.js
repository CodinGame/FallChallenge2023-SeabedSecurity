import { HEIGHT, WIDTH } from '../core/constants.js';
import { getRenderer } from '../core/rendering.js';
import { bell, easeIn, easeOut } from '../core/transitions.js';
import { fitAspectRatio, lerp, lerpAngle, lerpPosition, unlerp, lerpColor } from '../core/utils.js';
import { parseData, parseGlobalData } from './Deserializer.js';
import { initMessages, renderMessageContainer } from './MessageBoxes.js';
import { TooltipManager } from './TooltipManager.js';
import { BEAM_FRAMES, BEAM_LENGTH, DRONE_SCAN_FRAMES, FEEDBACK_SCAN_FRAMES, FISH_FRAMES, FISH_HABITAT_SIZE, GAME_ZONE_OFFSET_Y, REPORTING_FRAMES, UGLY_FRAMES } from './assetConstants.js';
import { DISC_RADIUS, initDarkness } from './darkness.js';
import { DARK_SCAN_RANGE, DRONE_HIT_RANGE, EAT_RADIUS, FISH_HEARING_RANGE, LIGHT_SCAN_RANGE, SCAN_CODE_BUFFERED, SCAN_CODE_LOST, SCAN_CODE_SAVED, SCAN_CODE_UNSCANNED } from './gameConstants.js';
import { angleDiff, fit, generateText, getFishPng, last, pad, setAnimationProgress } from './utils.js';
const api = {
    options: {
        debugMode: false,
        showFishHabitat: false,
        showOthersMessages: true,
        showMyMessages: true,
        meInGame: false,
        darkness: false,
        enableDarkness: true
    },
    setDebug: () => { }
};
export { api };
export class ViewModule {
    constructor() {
        this.states = [];
        this.pool = {};
        this.tooltipManager = new TooltipManager();
        this.time = 0;
        this.canvasMode = getRenderer().type === PIXI.RENDERER_TYPE.CANVAS;
        window.debug = this;
        this.api = api;
        if (this.canvasMode) {
            this.api.options.darkness = false;
            this.api.options.enableDarkness = false;
        }
    }
    static get moduleName() {
        return 'graphics';
    }
    // Effects
    getFromPool(type) {
        if (!this.pool[type]) {
            this.pool[type] = [];
        }
        for (const e of this.pool[type]) {
            if (!e.busy) {
                e.busy = true;
                e.display.visible = true;
                return e;
            }
        }
        const e = this.createEffect(type);
        this.pool[type].push(e);
        e.busy = true;
        return e;
    }
    createEffect(type) {
        let display = null;
        if (type === 'placeholder') {
            display = new PIXI.Container();
            const spawn = new PIXI.Sprite(PIXI.Texture.WHITE);
            display.addChild(spawn);
            this.fxLayer.addChild(display);
        }
        else if (type === 'beam') {
            display = PIXI.AnimatedSprite.fromFrames(BEAM_FRAMES);
            display.anchor.set(0, 0.5);
            this.fxLayer.addChild(display);
        }
        return { busy: false, display };
    }
    updateHud() {
        for (let i = 0; i < this.globalData.playerCount; ++i) {
            const cur = this.currentData;
            const prev = this.previousData;
            const source = this.progress < 1 ? prev : cur;
            this.scoreTexts[i].text = pad(source.scores[i], 2);
            for (let row = 0; row < 5; ++row) {
                for (let col = 0; col < 4; ++col) {
                    if (row === 4 && col === 3) {
                        continue;
                    }
                    const cell = this.squidGrids[i].array[row][col];
                    const prevHasBonus = prev.scans[i][row][col].hasBonus;
                    const curHasBonus = cur.scans[i][row][col].hasBonus;
                    const scanSummary = source.scans[i][row][col];
                    const scanState = scanSummary.code;
                    let tint = 0xFFFFFF;
                    let alpha = 1;
                    const bonusVisible = scanSummary.hasBonus;
                    cell.lostIcon.visible = false;
                    cell.feedbackScanAnimation.visible = false;
                    if (scanState === SCAN_CODE_UNSCANNED) {
                        tint = 0x0;
                        alpha = 0.6;
                    }
                    else if (scanState === SCAN_CODE_BUFFERED) {
                        alpha = 0.5;
                    }
                    else if (scanState === SCAN_CODE_SAVED) {
                    }
                    else if (scanState === SCAN_CODE_LOST) {
                        cell.lostIcon.visible = true;
                    }
                    const curScan = cur.scans[i][row][col];
                    const prevScan = prev.scans[i][row][col];
                    if (curScan.code === SCAN_CODE_SAVED) {
                        if (prevScan.code !== SCAN_CODE_SAVED) {
                            if (row === 4 || col === 3) {
                                const startP = 0.4;
                                const endP = 0.6;
                                tint = lerpColor(0x0, 0xFFFFFF, unlerp(startP, endP, this.progress));
                                alpha = lerp(0.6, 1, unlerp(startP, endP, this.progress));
                            }
                            else {
                                const fadeChangeP = unlerp(0.6, 1, this.progress);
                                alpha = lerp(0.6, 1, fadeChangeP);
                                cell.feedbackScanAnimation.visible = this.progress < 1;
                                setAnimationProgress(cell.feedbackScanAnimation, this.progress);
                            }
                        }
                    }
                    cell.sprite.tint = tint;
                    cell.sprite.alpha = alpha;
                    cell.bonusIcon.visible = bonusVisible;
                    cell.bonusIcon.scale.set(1);
                    if (!prevHasBonus && curHasBonus) {
                        cell.bonusIcon.visible = true;
                        cell.bonusIcon.scale.set(this.easeOutElastic(unlerp(0.5, 1, this.progress)));
                    }
                }
            }
        }
    }
    updateScene(previousData, currentData, progress, playerSpeed) {
        const frameChange = (this.currentData !== currentData);
        const fullProgressChange = ((this.progress === 1) !== (progress === 1));
        this.previousData = previousData;
        this.currentData = currentData;
        this.progress = progress;
        this.playerSpeed = playerSpeed || 0;
        this.resetEffects();
        this.updateFishes();
        this.updateUglies();
        this.updateDrones();
        this.updateHud();
        if (frameChange || (fullProgressChange && playerSpeed === 0)) {
            this.tooltipManager.updateGlobalText();
        }
    }
    convertPos({ x, y }) {
        return {
            x: x * this.globalData.ratio,
            y: y * this.globalData.ratio
        };
    }
    updateEntity(prev, cur, entity) {
        const fromPos = this.convertPos(prev);
        const toPos = this.convertPos(cur);
        const viewPos = lerpPosition(fromPos, toPos, this.progress);
        entity.container.position.copyFrom(viewPos);
        const speedSource = this.progress < 1 ? prev : cur;
        if (speedSource.vx < 0) {
            entity.targetScaleX = 1;
        }
        else if (speedSource.vx > 0) {
            entity.targetScaleX = -1;
        }
        else if (speedSource.vy === 0) {
            entity.targetScaleX = 1;
        }
    }
    updateScanLights(fishesScannedThisTurn, drone, startP, endP) {
        fishesScannedThisTurn.forEach((fishId) => {
            const fish = this.fishes.find((f) => f.id === fishId);
            if (fish) {
                const fishPos = fish.container.position;
                const dronePos = drone.container.position;
                const dx = fishPos.x - dronePos.x;
                const dy = fishPos.y - dronePos.y;
                const angle = Math.atan2(dy, dx);
                const distance = Math.sqrt(dx * dx + dy * dy);
                const fx = this.getFromPool('beam').display;
                fx.position.copyFrom(dronePos);
                fx.rotation = angle;
                setAnimationProgress(fx, lerp(startP, endP, this.progress));
                fx.scale.set(distance / BEAM_LENGTH, 1);
            }
        });
    }
    setScanAnimationProgress(drone, progress) {
        const frameNumber = setAnimationProgress(drone.scanAnimation, progress) + 1;
        let scale = {
            x: 1,
            y: 1
        };
        if (frameNumber >= 44 && frameNumber < 53) {
            const startScale = {
                x: 1.26,
                y: 1.2
            };
            const endScale = {
                x: 0.88,
                y: 0.93
            };
            scale = lerpPosition(startScale, endScale, unlerp(44, 53, frameNumber));
        }
        else if (frameNumber >= 53 && frameNumber < 60) {
            const startScale = {
                x: 0.88,
                y: 0.93
            };
            const endScale = {
                x: 0.97,
                y: 1
            };
            scale = lerpPosition(startScale, endScale, unlerp(53, 60, frameNumber));
        }
        else if (frameNumber >= 60 && frameNumber <= 66) {
            const startScale = {
                x: 0.97,
                y: 1
            };
            const endScale = {
                x: 1,
                y: 1
            };
            scale = lerpPosition(startScale, endScale, unlerp(60, 66, frameNumber));
        }
        drone.scaler.scale.copyFrom(scale);
    }
    updateDrones() {
        for (const player of this.globalData.players) {
            for (let i = 0; i < this.globalData.dronesPerPlayer; ++i) {
                const prev = this.previousData.drones[player.index][i];
                const cur = this.currentData.drones[player.index][i];
                const drone = this.drones[player.index][i];
                this.updateEntity(prev, cur, drone);
                const prevLightOn = prev.light;
                const curLightOn = cur.light;
                drone.lightRadius.clear();
                drone.lightRadius.lineStyle(2, player.color, 1);
                let scanRange;
                if (prevLightOn && curLightOn) {
                    scanRange = LIGHT_SCAN_RANGE;
                }
                else if (!prevLightOn && !curLightOn) {
                    scanRange = DARK_SCAN_RANGE;
                }
                else if (!prevLightOn && curLightOn) {
                    scanRange = lerp(DARK_SCAN_RANGE, LIGHT_SCAN_RANGE, easeIn(this.progress));
                }
                else {
                    scanRange = lerp(LIGHT_SCAN_RANGE, DARK_SCAN_RANGE, easeOut(this.progress));
                }
                drone.lightRadius.drawCircle(0, 0, scanRange * this.globalData.ratio);
                const prevEngineOn = !prev.dead && prev.targetX != null;
                const curEngineOn = !cur.dead && cur.targetX != null;
                if (prevEngineOn && curEngineOn) {
                    drone.engineRadius.scale.set(1);
                }
                else if (!prevEngineOn && !curEngineOn) {
                    drone.engineRadius.scale.set(0);
                }
                else if (!prevEngineOn && curEngineOn) {
                    drone.engineRadius.scale.set(easeOut(this.progress));
                }
                else {
                    drone.engineRadius.scale.set(easeIn(1 - this.progress));
                }
                drone.reportAnimation.visible = false;
                if (!this.globalData.simpleScans) {
                    if (cur.didReport) {
                        drone.reportAnimation.visible = true;
                        setAnimationProgress(drone.reportAnimation, lerp(0, 45 / 87, this.progress));
                    }
                    else if (prev.didReport) {
                        drone.reportAnimation.visible = true;
                        setAnimationProgress(drone.reportAnimation, lerp(45 / 87, 1, this.progress));
                    }
                }
                drone.radius.alpha = prev.dead ? 0 : 1;
                const isDeadNow = (cur.dead && prev.dead) || (cur.dead && !prev.dead && cur.dieAt <= this.progress);
                if (isDeadNow) {
                    drone.sprite.texture = PIXI.Texture.from(`Drone_${player.index === 0 ? 'Orange' : 'Violet'}_Damaged`);
                }
                else {
                    drone.sprite.texture = PIXI.Texture.from(`Drone_${player.index === 0 ? 'Orange' : 'Violet'}_Normal`);
                }
                drone.scanAnimation.visible = false;
                if ((prev.fishesScannedThisTurn.length !== 0)) {
                    this.setScanAnimationProgress(drone, lerp(0.5, 1, this.progress));
                    drone.scanAnimation.visible = true;
                    this.updateScanLights(prev.fishesScannedThisTurn, drone, 0.5, 1);
                }
                if ((cur.fishesScannedThisTurn.length !== 0)) {
                    if (drone.scanAnimation.visible) {
                        // Hold frame
                        this.setScanAnimationProgress(drone, 0.5);
                    }
                    else {
                        this.setScanAnimationProgress(drone, lerp(0, 0.5, this.progress));
                    }
                    drone.scanAnimation.visible = true;
                    this.updateScanLights(cur.fishesScannedThisTurn, drone, 0, 0.5);
                }
                drone.isDeadNow = isDeadNow;
                // Update message
                const message = this.messages[player.index][i];
                const text = cur.message;
                message.updateText(text, drone.container.position.x, drone.container.position.y);
                // Update darkness
                if (!this.canvasMode) { // Prevent crash when Canvas Mode is on
                    const disc = this.discs[player.index][i];
                    disc.scale.set((scanRange * this.globalData.ratio) / DISC_RADIUS);
                    disc.position.copyFrom(drone.container);
                }
            }
        }
    }
    updateUglies() {
        for (const ugly of this.uglies) {
            const prev = this.previousData.uglyMap[ugly.id];
            const cur = this.currentData.uglyMap[ugly.id];
            this.updateEntity(prev, cur, ugly);
            ugly.container.alpha = 1;
            const targetParent = (cur.vx === 0 && cur.vy === 0) ? this.hidingUglyLayer : this.movingUglyLayer;
            if (ugly.container.parent !== targetParent) {
                ugly.container.parent.removeChild(ugly.container);
                targetParent.addChild(ugly.container);
            }
            const foundTarget = (cur.foundTarget && this.progress > 0.5) || (prev.foundTarget && this.progress <= 0.5);
            const animationSprite = foundTarget ? ugly.aggroSprite : ugly.sprite;
            if (cur.vx === 0 && cur.vy === 0) {
                setAnimationProgress(animationSprite, ((this.currentData.frameInfo.number + this.progress + ugly.id) % 1.8) / 1.8);
            }
            else {
                setAnimationProgress(animationSprite, (this.progress + ugly.id / 20) % 1);
            }
            ugly.sprite.visible = !foundTarget;
            ugly.aggroSprite.visible = foundTarget;
        }
    }
    updateFishes() {
        for (const fish of this.fishes) {
            const prev = this.previousData.fishMap[fish.id];
            const cur = this.currentData.fishMap[fish.id];
            fish.container.scale.set(0.8);
            if (cur && prev) {
                this.updateEntity(prev, cur, fish);
                fish.sprite.alpha = 1;
                const spriteAnimation = fish.sprite;
                setAnimationProgress(spriteAnimation, this.progress);
            }
            else if (!cur && prev) {
                fish.sprite.alpha = 1 - this.progress;
                const dx = (prev.x < this.globalData.width / 2) ? -1 : 1;
                fish.container.position.copyFrom(this.convertPos({
                    x: lerp(prev.x, prev.x + 1000 * dx, this.progress),
                    y: prev.y
                }));
            }
            else {
                fish.sprite.alpha = 0;
            }
        }
    }
    shake(entity, progress) {
        const shakeForceMax = 1.4;
        const omega = 100000 * (Math.random() * 0.5 + 0.5);
        const shakeForce = shakeForceMax * unlerp(0, 0.5, bell(progress));
        const shakeX = shakeForce * Math.cos(2 * progress * omega);
        const shakeY = shakeForce * Math.sin(progress * omega);
        entity.pivot.x = shakeX;
        entity.pivot.y = shakeY;
    }
    shakeFish(entity) {
        const shakeForce = 1.4;
        const shakeX = shakeForce * (Math.random() * 2 - 1);
        const shakeY = shakeForce * (Math.random() * 2 - 1);
        entity.pivot.x = shakeX;
        entity.pivot.y = shakeY;
    }
    toGlobal(element) {
        return this.container.toLocal(new PIXI.Point(0, 0), element);
    }
    getAnimProgress({ start, end }, progress) {
        return unlerp(start, end, progress);
    }
    upThenDown(t) {
        return Math.min(1, bell(t) * 10);
    }
    resetEffects() {
        for (const type in this.pool) {
            for (const effect of this.pool[type]) {
                effect.display.visible = false;
                effect.busy = false;
            }
        }
    }
    animateRotation(sprite, rotation) {
        if (sprite.rotation !== rotation) {
            const eps = 0.02;
            let r = lerpAngle(sprite.rotation, rotation, 0.133);
            if (angleDiff(r, rotation) < eps) {
                r = rotation;
            }
            sprite.rotation = r;
        }
    }
    animateScan(progress) {
    }
    animateScene(delta) {
        var _a, _b, _c, _d;
        const firstAnim = this.time === 0;
        this.time += delta;
        // Entity direction
        for (const e of this.sideViewEntities) {
            if (e.targetScaleX !== e.scaler.scale.x) {
                e.scaler.scale.x = firstAnim ? e.targetScaleX : lerp(e.scaler.scale.x, e.targetScaleX, 0.15);
            }
        }
        for (const fish of this.fishes) {
            const curFleeing = (_b = (_a = this.currentData.fishMap[fish.id]) === null || _a === void 0 ? void 0 : _a.isFleeing) !== null && _b !== void 0 ? _b : false;
            const prevFleeing = (_d = (_c = this.previousData.fishMap[fish.id]) === null || _c === void 0 ? void 0 : _c.isFleeing) !== null && _d !== void 0 ? _d : false;
            const showFleeing = (curFleeing && this.progress === 1) || (prevFleeing && this.progress < 1);
            if (showFleeing) {
                this.shakeFish(fish.container);
                const animationSprite = fish.sprite;
                setAnimationProgress(animationSprite, this.progress * 2 % 1);
            }
            else {
                fish.container.pivot.set(0);
            }
        }
        for (const player of this.globalData.players) {
            for (let i = 0; i < this.globalData.dronesPerPlayer; ++i) {
                const drone = this.drones[player.index][i];
                if (drone.isDeadNow) {
                    this.shake(drone.container, (this.time % 1000) / 1000);
                }
                else {
                    drone.container.pivot.set(0);
                }
                const message = this.messages[player.index][i];
                renderMessageContainer.bind(this)(message, player.index, delta);
            }
        }
        if (!this.canvasMode) { // Hack : Prevent Crash when Canvas Mode is On
            this.api.renderFog();
        }
    }
    asLayer(func) {
        const layer = new PIXI.Container();
        func.bind(this)(layer);
        return layer;
    }
    initHud(layer) {
        this.scoreTexts = [];
        this.squidGrids = [];
        const hudOverlayLeft = PIXI.Sprite.from('Background-devant-G.png');
        const hudOverlayRight = PIXI.Sprite.from('Background-devant-D.png');
        hudOverlayRight.anchor.x = 1;
        hudOverlayRight.x = WIDTH;
        layer.addChild(hudOverlayLeft);
        layer.addChild(hudOverlayRight);
        for (const player of this.globalData.players) {
            const place = (x) => player.index === 0 ? x : WIDTH - x;
            const AVATAR_RECT = {
                x: 132,
                y: 25,
                w: 104,
                h: 104
            };
            const avatar = new PIXI.Sprite(player.avatar);
            avatar.position.set(place(AVATAR_RECT.x), AVATAR_RECT.y);
            avatar.width = AVATAR_RECT.w;
            avatar.height = AVATAR_RECT.h;
            avatar.anchor.x = player.index === 0 ? 0 : 1;
            const NICKNAME_RECT = {
                x: 30,
                y: 128,
                w: 305,
                h: 101
            };
            const nickname = generateText(player.name, 0xFFFFFF, 45, 0);
            fitTextWithin(nickname, NICKNAME_RECT, place);
            const SCORE_RECT = {
                x: 30,
                y: 250,
                w: 305,
                h: 101
            };
            const score = generateText('000', 0xFFFFFF, 64, 0);
            fitTextWithin(score, SCORE_RECT, place);
            this.scoreTexts.push(score);
            const squidGrid = this.initSquidGrid(player);
            const playerHud = new PIXI.Container();
            playerHud.addChild(avatar);
            playerHud.addChild(nickname);
            playerHud.addChild(score);
            playerHud.addChild(squidGrid.container);
            this.squidGrids.push(squidGrid);
            layer.addChild(playerHud);
        }
    }
    initSquidGrid(player) {
        const layer = new PIXI.Container();
        const GRID_RECT = {
            x: player.number === 0 ? 58.5 : 1617.5,
            y: 467.5
        };
        const fishX = player.number === 0 ? [0, 84, 164, 245] : [0, 81, 161, 245];
        const fishY = [0, 77, 154, 231, 316];
        const { x, y } = GRID_RECT;
        const array = [];
        for (let colorIdx = 0; colorIdx < 5; ++colorIdx) {
            const line = [];
            for (let typeIdx = 0; typeIdx < 4; ++typeIdx) {
                if (typeIdx === 3 && colorIdx === 4) {
                    continue;
                }
                const container = new PIXI.Container();
                let sprite;
                if (typeIdx === 3) {
                    const colorOfFish = ['Rose', 'Jaune', 'Vert', 'Bleu'];
                    sprite = PIXI.Sprite.from('Trophee_' + colorOfFish[colorIdx]);
                    sprite.scale.set(0.9);
                }
                else if (colorIdx === 4) {
                    const typeOfFish = ['Poulpe', 'Poissons', 'Crabe'];
                    sprite = PIXI.Sprite.from('Medaille-' + typeOfFish[typeIdx]);
                }
                else {
                    sprite = PIXI.Sprite.from(getFishPng(colorIdx, typeIdx));
                }
                sprite.anchor.set(0.5);
                sprite.tint = 0x0;
                if (player.number === 0) {
                    if (typeIdx === 3) {
                        container.x = fishX[0];
                    }
                    else {
                        container.x = fishX[typeIdx + 1];
                    }
                }
                else {
                    container.x = fishX[typeIdx];
                }
                container.y = fishY[colorIdx];
                const icon = PIXI.Sprite.from('Star');
                icon.anchor.set(0.5);
                icon.x += 15 + icon.width / 2;
                icon.y += -40 + icon.height / 2;
                const lost = PIXI.Sprite.from('PERDU');
                lost.anchor.set(0.5);
                const feedbackScanAnimation = PIXI.AnimatedSprite.fromFrames(FEEDBACK_SCAN_FRAMES);
                feedbackScanAnimation.anchor.set(0.5);
                feedbackScanAnimation.visible = false;
                feedbackScanAnimation.x = 1.5;
                feedbackScanAnimation.y = 1;
                container.addChild(sprite);
                container.addChild(icon);
                container.addChild(lost);
                container.addChild(feedbackScanAnimation);
                line.push({ sprite, bonusIcon: icon, lostIcon: lost, feedbackScanAnimation });
                layer.addChild(container);
            }
            array.push(line);
        }
        layer.x = x;
        layer.y = y;
        return {
            container: layer,
            array
        };
    }
    initBackground(layer) {
        const b = PIXI.Sprite.from('Background-derriere.jpg');
        fit(b, WIDTH, Infinity);
        b.anchor.x = 0.5;
        b.anchor.y = 0.5;
        b.x = WIDTH / 2;
        b.y = HEIGHT / 2;
        layer.addChild(b);
    }
    initDrones(layer) {
        this.drones = [[], []];
        for (const player of this.globalData.players) {
            for (let i = 0; i < this.globalData.dronesPerPlayer; ++i) {
                const engineRadius = new PIXI.Graphics();
                engineRadius.lineStyle(2, 0x0F4F0F, 1);
                engineRadius.drawCircle(0, 0, FISH_HEARING_RANGE * this.globalData.ratio);
                const lightRadius = new PIXI.Graphics();
                lightRadius.lineStyle(2, player.color, 1);
                lightRadius.drawCircle(0, 0, DARK_SCAN_RANGE * this.globalData.ratio);
                const sprite = PIXI.Sprite.from(`Drone_${player.index === 0 ? 'Orange' : 'Violet'}_Normal`);
                sprite.anchor.set(0.5, 38 / 108);
                sprite.scale.set(0.75);
                const radius = new PIXI.Graphics();
                radius.lineStyle(2, 0xFFFFFF, 1);
                radius.drawCircle(0, 0, DRONE_HIT_RANGE * this.globalData.ratio);
                const report = PIXI.AnimatedSprite.fromFrames(REPORTING_FRAMES);
                report.anchor.set(0.5);
                report.y = -100;
                report.scale.set(0.75);
                const scanAnimation = PIXI.AnimatedSprite.fromFrames(DRONE_SCAN_FRAMES);
                scanAnimation.anchor.set(93 / 190, 67 / 157);
                scanAnimation.scale.set(0.75);
                const scaler = new PIXI.Container();
                const container = new PIXI.Container();
                scaler.addChild(sprite);
                container.addChild(report);
                container.addChild(scaler);
                container.addChild(engineRadius);
                container.addChild(lightRadius);
                container.addChild(scanAnimation);
                container.addChild(radius);
                Object.defineProperty(radius, 'visible', { get: () => this.api.options.debugMode !== false && !this.globalData.isDemo });
                Object.defineProperty(engineRadius, 'visible', { get: () => this.api.options.debugMode !== false && this.globalData.fishWillFlee && !this.globalData.isDemo });
                lightRadius.visible = this.canvasMode;
                this.drones[player.index].push({
                    id: ([[0, 2], [1, 3]])[player.index][i],
                    sprite,
                    container,
                    lightRadius,
                    engineRadius,
                    radius,
                    targetScaleX: 1,
                    isDeadNow: false,
                    scaler,
                    reportAnimation: report,
                    scanAnimation
                });
                layer.addChild(container);
                container.hitArea = new PIXI.Circle(0, 0, DRONE_HIT_RANGE * this.globalData.ratio);
                this.registerTooltip(container, () => {
                    const source = this.progress < 1 ? this.previousData : this.currentData;
                    const drone = source.drones[player.index][i];
                    const text = `id: ${drone.id}` +
                        `\n${player.name}` +
                        `\npos: (${drone.x}, ${drone.y})` +
                        `\nbattery: ${drone.battery}`;
                    return text;
                }, () => {
                    const source = this.progress < 1 ? this.previousData : this.currentData;
                    const drone = source.drones[player.index][i];
                    return drone.scans;
                });
            }
        }
    }
    initFishes(layer) {
        this.fishes = [];
        for (const fishGlobal of this.globalData.fishes) {
            let textureIdx = fishGlobal.color * 3;
            textureIdx += fishGlobal.type;
            const container = new PIXI.Container();
            const scaler = new PIXI.Container();
            const sprite = PIXI.AnimatedSprite.fromFrames(FISH_FRAMES[fishGlobal.type][fishGlobal.color]);
            sprite.anchor.set(0.5);
            this.fishes.push({
                id: fishGlobal.id,
                sprite,
                container,
                targetScaleX: 1,
                scaler
            });
            if (fishGlobal.type === 1 && fishGlobal.color === 2) {
                sprite.scale.set(0.85);
            }
            scaler.addChild(sprite);
            container.addChild(scaler);
            layer.addChild(container);
            container.hitArea = new PIXI.Circle(0, 0, 30);
            this.registerTooltip(container, () => {
                const source = this.progress < 1 ? this.previousData : this.currentData;
                const fish = source.fishMap[fishGlobal.id];
                if (!fish) {
                    return '';
                }
                const text = `id: ${fish.id}` +
                    `\ncolor: ${fishGlobal.color}, type: ${fishGlobal.type}` +
                    `\npos: (${fish.x}, ${fish.y})` +
                    `\nspeed: (${fish.vx}, ${fish.vy})`;
                return text;
            });
        }
    }
    initUglies(layer) {
        this.uglies = [];
        const uglyScale = 0.8;
        for (const uglyId of this.globalData.uglies) {
            const sprite = PIXI.AnimatedSprite.fromFrames(UGLY_FRAMES[0]);
            sprite.anchor.set(141 / 280, 147 / 232);
            sprite.scale.set(uglyScale);
            const aggroSprite = PIXI.AnimatedSprite.fromFrames(UGLY_FRAMES[1]);
            aggroSprite.anchor.set(158 / 296, 163 / 272);
            aggroSprite.scale.set(uglyScale);
            aggroSprite.visible = false;
            const radius = new PIXI.Graphics();
            radius.lineStyle(2, 0xFFFFFF, 1);
            radius.drawCircle(0, 0, EAT_RADIUS * this.globalData.ratio);
            const scaler = new PIXI.Container();
            const container = new PIXI.Container();
            scaler.addChild(sprite);
            scaler.addChild(aggroSprite);
            container.addChild(scaler);
            container.addChild(radius);
            Object.defineProperty(radius, 'visible', { get: () => this.api.options.debugMode !== false && !this.globalData.isDemo });
            this.uglies.push({
                id: uglyId,
                container,
                sprite,
                targetScaleX: 1,
                scaler,
                aggroSprite
            });
            layer.addChild(container);
            container.hitArea = new PIXI.Circle(0, 0, EAT_RADIUS * this.globalData.ratio);
            this.registerTooltip(container, () => {
                const source = this.progress < 1 ? this.previousData : this.currentData;
                const fish = source.uglyMap[uglyId];
                const text = `id: ${fish.id}` +
                    '\nMonster' +
                    `\npos: (${fish.x}, ${fish.y})` +
                    `\nspeed: (${fish.vx}, ${fish.vy})`;
                return text;
            });
        }
    }
    initWalls(layer) {
        const walls = PIXI.Sprite.from('Background-plantes.png');
        layer.addChild(walls);
        const onePixel = 1920 / (this.canvasData.width / this.canvasData.oversampling);
        const debugWalls = new PIXI.Graphics();
        debugWalls.lineStyle(onePixel, 0xFFFFFF, 1);
        debugWalls.drawRect(0, 0, this.globalData.width * this.globalData.ratio, this.globalData.height * this.globalData.ratio);
        debugWalls.x = WIDTH / 2 - this.globalData.width / 2 * this.globalData.ratio;
        debugWalls.y = GAME_ZONE_OFFSET_Y * this.globalData.ratio;
        debugWalls.endFill();
        debugWalls.alpha = 1;
        Object.defineProperty(debugWalls, 'visible', { get: () => this.api.options.debugMode !== false && !this.globalData.isDemo });
        layer.addChild(debugWalls);
        const color = [0x00FA9A, 0xFFFF8F, 0xFF5733];
        for (let i = 0; i < 3; ++i) {
            const fishLimits = new PIXI.Graphics();
            fishLimits.lineStyle(onePixel, color[i], 1);
            fishLimits.lineTo(this.globalData.width * this.globalData.ratio, 0);
            fishLimits.x = WIDTH / 2 - this.globalData.width / 2 * this.globalData.ratio;
            fishLimits.y = ((i + 1) * FISH_HABITAT_SIZE + GAME_ZONE_OFFSET_Y) * this.globalData.ratio;
            fishLimits.endFill();
            fishLimits.alpha = 1;
            Object.defineProperty(fishLimits, 'visible', { get: () => this.api.options.showFishHabitat !== false && !this.globalData.isDemo });
            layer.addChild(fishLimits);
        }
    }
    initFilter(container, background) {
        const flowmap = PIXI.TilingSprite.from('flowmap.png', { width: WIDTH, height: HEIGHT });
        const filter = new PIXI.filters.DisplacementFilter(flowmap, 25);
        flowmap.width = WIDTH;
        flowmap.height = HEIGHT;
        container.addChild(flowmap);
        background.filters = [filter];
    }
    reinitScene(container, canvasData) {
        this.time = 0;
        this.oversampling = canvasData.oversampling;
        this.container = container;
        this.pool = {};
        this.canvasData = canvasData;
        const tooltipLayer = this.tooltipManager.reinit();
        const gameZone = new PIXI.Container();
        this.fxLayer = new PIXI.Container();
        const background = this.asLayer(this.initBackground);
        const walls = this.asLayer(this.initWalls);
        const hudLayer = this.asLayer(this.initHud);
        const messageLayer = this.asLayer(initMessages);
        const darknessLayer = this.asLayer(initDarkness);
        const fishLayer = this.asLayer(this.initFishes);
        this.hidingUglyLayer = this.asLayer(this.initUglies);
        this.movingUglyLayer = new PIXI.Container();
        const droneLayer = this.asLayer(this.initDrones);
        this.sideViewEntities = [
            ...this.fishes,
            ...this.uglies
        ];
        gameZone.addChild(fishLayer);
        gameZone.addChild(droneLayer);
        gameZone.addChild(this.fxLayer);
        container.addChild(background);
        container.addChild(this.hidingUglyLayer);
        container.addChild(darknessLayer);
        container.addChild(this.movingUglyLayer);
        container.addChild(gameZone);
        container.addChild(hudLayer);
        container.addChild(walls);
        container.addChild(messageLayer);
        container.addChild(tooltipLayer);
        gameZone.x = WIDTH / 2 - this.globalData.width / 2 * this.globalData.ratio;
        gameZone.y = 300 * this.globalData.ratio;
        messageLayer.x = WIDTH / 2 - this.globalData.width / 2 * this.globalData.ratio;
        messageLayer.y = 300 * this.globalData.ratio;
        this.hidingUglyLayer.position.copyFrom(gameZone);
        this.movingUglyLayer.position.copyFrom(gameZone);
        container.interactive = true;
        container.interactiveChildren = false;
        messageLayer.interactiveChildren = false;
        tooltipLayer.interactiveChildren = false;
        container.on('mousemove', (event) => {
            this.tooltipManager.moveTooltip(event);
        });
        this.tooltipManager.registerGlobal((data) => {
            const localPos = data.getLocalPosition(gameZone);
            let tileX = Math.floor(localPos.x / this.globalData.ratio);
            let tileY = Math.floor(localPos.y / this.globalData.ratio);
            if (tileX < 0) {
                if (tileX < -1000) {
                    return null;
                }
                tileX = 0;
            }
            if (tileY < 0) {
                tileY = 0;
            }
            if (tileX >= this.globalData.width) {
                if (tileX > this.globalData.width + 1000) {
                    return null;
                }
                tileX = this.globalData.width - 1;
            }
            if (tileY >= this.globalData.height) {
                tileY = this.globalData.height - 1;
            }
            return `(${tileX}, ${tileY})`;
        });
    }
    registerTooltip(container, getString, getScans) {
        container.interactive = true;
        this.tooltipManager.register(container, getString, getScans);
    }
    drawDebugFrameAroundObject(o, col = 0xFF00FF, ancX, ancY) {
        var _a, _b, _c, _d;
        const frame = new PIXI.Graphics();
        const x = -o.width * ((_b = (_a = o.anchor) === null || _a === void 0 ? void 0 : _a.x) !== null && _b !== void 0 ? _b : ancX);
        const y = -o.height * ((_d = (_c = o.anchor) === null || _c === void 0 ? void 0 : _c.y) !== null && _d !== void 0 ? _d : ancY);
        frame.beginFill(col, 1);
        frame.drawRect(x, y, o.width, o.height);
        frame.position.copyFrom(o);
        return frame;
    }
    easeOutElastic(x) {
        const c4 = (2 * Math.PI) / 3;
        return x === 0
            ? 0
            : x === 1
                ? 1
                : Math.pow(2, -10 * x) * Math.sin((x * 10 - 0.75) * c4) + 1;
    }
    handleGlobalData(players, raw) {
        const globalData = parseGlobalData(raw);
        api.options.meInGame = !!players.find(p => p.isMe);
        this.globalData = Object.assign(Object.assign({}, globalData), { players: players, playerCount: players.length });
    }
    handleFrameData(frameInfo, raw) {
        var _a;
        const dto = parseData(raw, this.globalData);
        const frameData = Object.assign(Object.assign({}, dto), { previous: null, frameInfo });
        frameData.previous = (_a = last(this.states)) !== null && _a !== void 0 ? _a : frameData;
        for (let i = 0; i < this.globalData.playerCount; ++i) {
            for (let k = 0; k < this.globalData.dronesPerPlayer; ++k) {
                const prev = frameData.previous.drones[i][k];
                const cur = frameData.drones[i][k];
                const vx = cur.x - prev.x;
                const vy = cur.y - prev.y;
                prev.vx = vx;
                prev.vy = vy;
            }
        }
        this.states.push(frameData);
        return frameData;
    }
}
// const FONT_ANCHOR_OFFSET_Y = 0.24
function fitTextWithin(text, RECT, place) {
    text.anchor.set(0.5);
    const x = RECT.x + RECT.w / 2;
    const y = RECT.y + RECT.h / 2;
    text.position.set(place(x), y);
    if (text.width > RECT.w || text.height > RECT.h) {
        const coeff = fitAspectRatio(text.width, text.height, RECT.w, RECT.h);
        text.scale.set(coeff);
    }
}
