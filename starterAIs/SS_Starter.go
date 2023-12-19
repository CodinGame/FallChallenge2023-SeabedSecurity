package main

import (
	"fmt"
)

type Vector struct {
	X int
	Y int
}

type FishDetail struct {
	Color int
	Type  int
}

type Fish struct {
	FishID int
	Pos    Vector
	Speed  Vector
	Detail FishDetail
}

type RadarBlip struct {
	FishID int
	Dir    string
}

type Drone struct {
	DroneID int
	Pos     Vector
	Dead    bool
	Battery int
	Scans   []int
}

func main() {
	fishDetails := make(map[int]FishDetail)

	var fishCount int
	fmt.Scan(&fishCount)

	for i := 0; i < fishCount; i++ {
		var fishID, color, _type int
		fmt.Scan(&fishID, &color, &_type)
		fishDetails[fishID] = FishDetail{Color: color, Type: _type}
	}

	// Game loop
	for {
		var myScans, foeScans []int
		droneByID := make(map[int]Drone)
		var myDrones, foeDrones []Drone
		var visibleFish []Fish
		myRadarBlips := make(map[int][]RadarBlip)

		var myScore, foeScore int
		fmt.Scan(&myScore, &foeScore)

		var myScanCount int
		fmt.Scan(&myScanCount)
		for i := 0; i < myScanCount; i++ {
			var fishID int
			fmt.Scan(&fishID)
			myScans = append(myScans, fishID)
		}

		var foeScanCount int
		fmt.Scan(&foeScanCount)
		for i := 0; i < foeScanCount; i++ {
			var fishID int
			fmt.Scan(&fishID)
			foeScans = append(foeScans, fishID)
		}

		var myDroneCount int
		fmt.Scan(&myDroneCount)
		for i := 0; i < myDroneCount; i++ {
			var droneID, droneX, droneY, dead, battery int
			fmt.Scan(&droneID, &droneX, &droneY, &dead, &battery)
			pos := Vector{X: droneX, Y: droneY}
			drone := Drone{DroneID: droneID, Pos: pos, Dead: dead == 1, Battery: battery, Scans: []int{}}
			droneByID[droneID] = drone
			myDrones = append(myDrones, drone)
			myRadarBlips[droneID] = []RadarBlip{}
		}

		var foeDroneCount int
		fmt.Scan(&foeDroneCount)
		for i := 0; i < foeDroneCount; i++ {
			var droneID, droneX, droneY, dead, battery int
			fmt.Scan(&droneID, &droneX, &droneY, &dead, &battery)
			pos := Vector{X: droneX, Y: droneY}
			drone := Drone{DroneID: droneID, Pos: pos, Dead: dead == 1, Battery: battery, Scans: []int{}}
			droneByID[droneID] = drone
			foeDrones = append(foeDrones, drone)
		}

		var droneScanCount int
		fmt.Scan(&droneScanCount)
		for i := 0; i < droneScanCount; i++ {
			var droneID, fishID int
			fmt.Scan(&droneID, &fishID)
			drone := droneByID[droneID]
			drone.Scans = append(drone.Scans, fishID)
			droneByID[droneID] = drone
		}

		var visibleFishCount int
		fmt.Scan(&visibleFishCount)
		for i := 0; i < visibleFishCount; i++ {
			var fishID, fishX, fishY, fishVX, fishVY int
			fmt.Scan(&fishID, &fishX, &fishY, &fishVX, &fishVY)
			pos := Vector{X: fishX, Y: fishY}
			speed := Vector{X: fishVX, Y: fishVY}
			visibleFish = append(visibleFish, Fish{FishID: fishID, Pos: pos, Speed: speed, Detail: fishDetails[fishID]})
		}

		var myRadarBlipCount int
		fmt.Scan(&myRadarBlipCount)
		for i := 0; i < myRadarBlipCount; i++ {
			var droneID, fishID int
			var dir string
			fmt.Scan(&droneID, &fishID, &dir)
			myRadarBlips[droneID] = append(myRadarBlips[droneID], RadarBlip{FishID: fishID, Dir: dir})
		}

		for _, drone := range myDrones {
			x := drone.Pos.X
			y := drone.Pos.Y
			// TODO: Implement logic on where to move here
			targetX := 5000 + x - x
			targetY := 5000 + y - y
			light := 1

			fmt.Printf("MOVE %d %d %d\n", targetX, targetY, light)
		}
	}
}
