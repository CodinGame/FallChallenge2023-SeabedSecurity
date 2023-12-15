interface Vector {
  x: number
  y: number
}

interface FishDetail {
  color: number
  type: number
}

interface Fish {
  fishId: number
  pos: Vector
  speed: Vector
  detail: FishDetail
}

interface Drone {
  droneId: number
  pos: Vector
  dead: number
  battery: number
  scans: number[]
}

interface RadarBlip {
  fishId: number
  dir: string
}


const fishDetails = new Map<number, FishDetail>()

const fishCount = parseInt(readline())
for (let i = 0; i < fishCount; i++) {
  const [fishId, color, type] = readline().split(' ').map(Number)
  fishDetails.set(fishId, { color, type })
}

// game loop
while (true) {
  const myScans: number[] = []
  const foeScans: number[] = []
  const droneById = new Map<number, Drone>()
  const myDrones: Drone[] = []
  const foeDrones: Drone[] = []
  const visibleFish: Fish[] = []
  const myRadarBlips = new Map<number, RadarBlip[]>()

  const myScore = parseInt(readline())
  const foeScore = parseInt(readline())

  const myScanCount = parseInt(readline())
  for (let i = 0; i < myScanCount; i++) {
    const fishId = parseInt(readline())
    myScans.push(fishId)
  }

  const foeScanCount = parseInt(readline())
  for (let i = 0; i < foeScanCount; i++) {
    const fishId = parseInt(readline())
    foeScans.push(fishId)
  }

  const myDroneCount = parseInt(readline())
  for (let i = 0; i < myDroneCount; i++) {
    const [droneId, droneX, droneY, dead, battery] = readline().split(' ').map(Number)
    const pos = { x: droneX, y: droneY }
    const drone = { droneId, pos, dead, battery, scans: [] }
    droneById.set(droneId, drone)
    myDrones.push(drone)
    myRadarBlips.set(droneId, [])
  }

  const foeDroneCount = parseInt(readline())
  for (let i = 0; i < foeDroneCount; i++) {
    const [droneId, droneX, droneY, dead, battery] = readline().split(' ').map(Number)
    const pos = { x: droneX, y: droneY }
    const drone = { droneId, pos, dead, battery, scans: [] }
    droneById.set(droneId, drone)
    foeDrones.push(drone)
  }


  const droneScanCount = parseInt(readline())
  for (let i = 0; i < droneScanCount; i++) {
    const [droneId, fishId] = readline().split(' ').map(Number)
    droneById.get(droneId)!.scans.push(fishId)
  }

  const visibleFishCount = parseInt(readline())
  for (let i = 0; i < visibleFishCount; i++) {
    const [fishId, fishX, fishY, fishVx, fishVy] = readline().split(' ').map(Number)
    const pos = { x: fishX, y: fishY }
    const speed = { x: fishVx, y: fishVy }
    visibleFish.push({fishId, pos, speed, detail: fishDetails.get(fishId)! })
  }

  const myRadarBlipCount = parseInt(readline())
  for (let i = 0; i < myRadarBlipCount; i++) {
    const [_droneId, _fishId, dir] = readline().split(' ')
    const droneId = parseInt(_droneId)
    const fishId = parseInt(_fishId)
    myRadarBlips.get(droneId)!.push({ fishId, dir })
  }

  for (const drone of myDrones) {
    const x = drone.pos.x
    const y = drone.pos.y
    // TODO: Implement logic on where to move here
    const targetX = 5000
    const targetY = 5000
    const light = 1

    console.log(`MOVE ${targetX} ${targetY} ${light}`)
  }
}
