// Define the data structures as classes
class Vector {
    constructor(x, y) {
      this.x = x;
      this.y = y;
    }
  }
  
  class FishDetail {
    constructor(color, type) {
      this.color = color;
      this.type = type;
    }
  }
  
  class Fish {
    constructor(fishId, pos, speed, detail) {
      this.fishId = fishId;
      this.pos = pos;
      this.speed = speed;
      this.detail = detail;
    }
  }
  
  class Drone {
    constructor(dronedId, pos, dead, battery, scans) {
      this.dronedId = dronedId;
      this.pos = pos;
      this.dead = dead;
      this.battery = battery;
      this.scans = scans;
    }
  }
  
  class RadarBlip {
    constructor(fishId, dir) {
      this.fishId = fishId;
      this.dir = dir;
    }
  }
  
  const fishDetails = new Map();
  
  const fishCount = parseInt(readline());
  for (let i = 0; i < fishCount; i++) {
    const [fishId, color, type] = readline().split(' ').map(Number);
    fishDetails.set(fishId, new FishDetail(color, type));
  }
  
  // game loop
  while (true) {
    const myScans = [];
    const foeScans = [];
    const droneById = new Map();
    const myDrones = [];
    const foeDrones = [];
    const visibleFishes = [];
    const myRadarBlips = new Map();
  
    const myScore = parseInt(readline());
    const foeScore = parseInt(readline());
  
    const myScanCount = parseInt(readline());
    for (let i = 0; i < myScanCount; i++) {
      const fish_id = parseInt(readline());
      myScans.push(fish_id);
    }
  
    const foeScanCount = parseInt(readline());
    for (let i = 0; i < foeScanCount; i++) {
      const fish_id = parseInt(readline());
      foeScans.push(fish_id);
    }
  
    const myDroneCount = parseInt(readline());
    for (let i = 0; i < myDroneCount; i++) {
      const [droneId, droneX, droneY, dead, battery] = readline().split(' ').map(Number);
      const pos = new Vector(droneX, droneY);
      const drone = new Drone(droneId, pos, dead, battery, []);
      droneById.set(droneId, drone);
      myDrones.push(drone);
      myRadarBlips.set(droneId, []);
    }
  
    const foeDroneCount = parseInt(readline());
    for (let i = 0; i < foeDroneCount; i++) {
      const [droneId, droneX, droneY, dead, battery] = readline().split(' ').map(Number);
      const pos = new Vector(droneX, droneY);
      const drone = new Drone(droneId, pos, dead, battery, []);
      droneById.set(droneId, drone);
      foeDrones.push(drone);
    }
  
    const droneScanCount = parseInt(readline());
    for (let i = 0; i < droneScanCount; i++) {
      const [droneId, fish_id] = readline().split(' ').map(Number);
      droneById.get(droneId).scans.push(fish_id);
    }
  
  
    const visibleFishCount = parseInt(readline());
    for (let i = 0; i < visibleFishCount; i++) {
      const [fishId, fishX, fishY, fishVx, fishVy] = readline().split(' ').map(Number);
      const pos = new Vector(fishX, fishY);
      const speed = new Vector(fishVx, fishVy);
      visibleFishes.push(new Fish(fishId, pos, speed, fishDetails.get(fishId)));
    }
  
    const myRadarBlipCount = parseInt(readline());
    for (let i = 0; i < myRadarBlipCount; i++) {
      const [_droneId, _fishId, dir] = readline().split(' ');
      const droneId = parseInt(_droneId);
      const fishId = parseInt(_fishId);
      myRadarBlips.get(droneId).push(new RadarBlip(fishId, dir));
    }
  
    for (const drone of myDrones) {
      const x = drone.pos.x;
      const y = drone.pos.y;
      // TODO: Implement logic on where to move here
      const targetX = 5000;
      const targetY = 5000;
      const light = 1;
  
      console.log(`MOVE ${targetX} ${targetY} ${light}`);
    }
  }