import { HEIGHT } from '../core/constants.js';
import { SCAN_CODE_LOST, SCAN_CODE_SAVED, SCAN_CODE_UNSCANNED } from './gameConstants.js';
const MAIN_SEPARATOR = ';';
function splitLine(str) {
    return str.length === 0 ? [] : str.split(' ');
}
export function parseData(unsplit, globalData) {
    const raw = unsplit.split(MAIN_SEPARATOR);
    let idx = 0;
    const fishCount = +raw[idx++];
    const fishes = [];
    const fishMap = {};
    for (let i = 0; i < fishCount; ++i) {
        const rawFish = splitLine(raw[idx++]);
        const fish = {
            id: +rawFish[0],
            x: +rawFish[1],
            y: +rawFish[2],
            vx: +rawFish[3],
            vy: +rawFish[4],
            isFleeing: rawFish[5] === '1'
        };
        fishes.push(fish);
        fishMap[fish.id] = fish;
    }
    const uglies = [];
    const uglyMap = {};
    for (let i = 0; i < globalData.uglies.length; ++i) {
        const rawFish = splitLine(raw[idx++]);
        const fish = {
            id: +rawFish[0],
            x: +rawFish[1],
            y: +rawFish[2],
            vx: +rawFish[3],
            vy: +rawFish[4],
            foundTarget: rawFish[5] === '1'
        };
        uglies.push(fish);
        uglyMap[fish.id] = fish;
    }
    const scans = [];
    const scores = [];
    const drones = [[], []];
    for (let i = 0; i < globalData.playerCount; ++i) {
        scores.push(+raw[idx++]);
        for (let k = 0; k < globalData.dronesPerPlayer; ++k) {
            const rawDrone = splitLine(raw[idx++]);
            const drone = {
                id: +rawDrone[0],
                x: +rawDrone[1],
                y: +rawDrone[2],
                targetX: rawDrone[3] === 'x' ? null : +rawDrone[3],
                targetY: rawDrone[4] === 'x' ? null : +rawDrone[4],
                battery: +rawDrone[5],
                light: rawDrone[6] === '1',
                dead: rawDrone[7] === '1',
                dieAt: (+rawDrone[8]) / 100,
                scans: [],
                fishesScannedThisTurn: [],
                didReport: rawDrone[9] === '1',
                message: rawDrone.slice(10).join(' ')
            };
            const fishesScannedThisTurnCount = +raw[idx++];
            for (let j = 0; j < fishesScannedThisTurnCount; ++j) {
                drone.fishesScannedThisTurn.push(+raw[idx++]);
            }
            const scanCount = +raw[idx++];
            for (let j = 0; j < scanCount; ++j) {
                const rawScan = raw[idx++].split(' ');
                const scan = {
                    color: +rawScan[0],
                    type: +rawScan[1]
                };
                drone.scans.push(scan);
            }
            drones[i].push(drone);
        }
        let scanIdx = 0;
        const rawScans = splitLine(raw[idx++]);
        const playerScans = [];
        for (let row = 0; row < 4; ++row) {
            const line = [];
            for (let col = 0; col < 3; ++col) {
                const code = +rawScans[scanIdx++];
                const hasBonus = rawScans[scanIdx++] === '@';
                line.push({ code, hasBonus });
            }
            line.push({
                code: getComboCode(line.map(({ code }) => code)),
                hasBonus: rawScans[scanIdx++] === '@'
            });
            playerScans.push(line);
        }
        const lastLine = [];
        for (let col = 0; col < 3; ++col) {
            const column = playerScans.map(line => line[col].code);
            lastLine.push({
                code: getComboCode(column),
                hasBonus: rawScans[scanIdx++] === '@'
            });
        }
        playerScans.push(lastLine);
        scans.push(playerScans);
    }
    return {
        scans,
        fishes,
        fishMap,
        uglies,
        uglyMap,
        scores,
        drones
    };
    // const events: EventDto[] = []
    // const eventCount = +raw[idx++]
    // for (let i = 0; i < eventCount; ++i) {
    //   const playerIndex = +raw[idx++]
    //   const amount = +raw[idx++]
    //   const rawCoord = splitLine(raw[idx++])
    //   const coord = {
    //     x: +rawCoord[0],
    //     y: +rawCoord[1]
    //   }
    //   const rawTarget = splitLine(raw[idx++])
    //   const target = {
    //     x: +rawTarget[0],
    //     y: +rawTarget[1]
    //   }
    //   const type = +raw[idx++]
    //   const start = +raw[idx++]
    //   const end = +raw[idx++]
    //   const animData = { start, end }
    //   events.push({
    //     playerIndex,
    //     amount,
    //     coord,
    //     target,
    //     type,
    //     animData
    //   })
    // }
}
function getComboCode(line) {
    if (line.every(n => n === SCAN_CODE_SAVED)) {
        return SCAN_CODE_SAVED;
    }
    if (line.some(n => n === SCAN_CODE_LOST)) {
        return SCAN_CODE_LOST;
    }
    return SCAN_CODE_UNSCANNED;
}
export function parseGlobalData(unsplit) {
    const raw = unsplit.split(MAIN_SEPARATOR);
    let idx = 0;
    const rawIsDemo = raw[idx];
    let isDemo = false;
    if (rawIsDemo === 'X') {
        isDemo = true;
        ++idx;
    }
    const fishWillFlee = raw[idx++] === '1';
    const width = +raw[idx++];
    const height = +raw[idx++];
    const dronesPerPlayer = +raw[idx++];
    const fishCount = +raw[idx++];
    const fishes = [];
    const fishMap = {};
    for (let i = 0; i < fishCount; ++i) {
        const rawFish = splitLine(raw[idx++]);
        const fish = {
            id: +rawFish[0],
            color: +rawFish[1],
            type: +rawFish[2]
        };
        fishes.push(fish);
        fishMap[fish.id] = fish;
    }
    const uglyCount = +raw[idx++];
    const uglies = [];
    for (let i = 0; i < uglyCount; ++i) {
        uglies.push(+raw[idx++]);
    }
    const simpleScans = raw[idx++] === '1';
    return {
        width,
        height,
        dronesPerPlayer,
        fishes,
        fishMap,
        uglies,
        ratio: HEIGHT / 10800,
        fishWillFlee,
        isDemo,
        simpleScans
    };
}
