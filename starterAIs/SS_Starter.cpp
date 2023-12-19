#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

struct Vector {
    int x, y;
}; typedef Vector Point;

struct FishDetails {
    int color, type;
};

struct Fish {
    int id;
    Point position;
    Vector velocity;
    FishDetails details;
};

struct Drone {
    int id, battery;
    Point position;
    bool dead;
    vector<int> scans;
};

struct RadarBlip {
    int fishId;
    string direction;
};

int main() {
    unordered_map<int, FishDetails> fishDetails;

    // Fish details
    int creatureCount;
    cin >> creatureCount; cin.ignore();
    for (int i = 0; i < creatureCount; i++) {
        int creatureId;
        cin >> creatureId >> fishDetails[creatureId].color >> fishDetails[creatureId].type; cin.ignore();
    }

    // game loop
    while (1) {
        vector<int> myScans, foeScans, radarBlips;
        vector<Drone> myDrones, foeDrones;
        vector<Fish> visibleFishes;
        unordered_map<int, Drone *> droneById;
        unordered_map<int, vector<RadarBlip>> myRadarBlips;

        // Scores
        int myScore, foeScore;
        cin >> myScore >> foeScore; cin.ignore();

        // My fish scans
        int myScanCount;
        cin >> myScanCount; cin.ignore();
        for (int i = 0; i < myScanCount; i++) {
            int creatureId;
            cin >> creatureId; cin.ignore();
            myScans.emplace_back(creatureId);
        }

        // Foe fish scans
        int foeScanCount;
        cin >> foeScanCount; cin.ignore();
        for (int i = 0; i < foeScanCount; i++) {
            int creatureId;
            cin >> creatureId; cin.ignore();
            foeScans.emplace_back(creatureId);
        }

        // My drones
        int myDroneCount;
        cin >> myDroneCount; cin.ignore();
        for (int i = 0; i < myDroneCount; i++) {
            int droneId, droneX, droneY, droneDead, droneBattery;
            cin >> droneId >> droneX >> droneY >> droneDead >> droneBattery; cin.ignore();
            myDrones.push_back({droneId, droneBattery, Point{droneX, droneY}, (bool) droneDead, vector<int>()});
            droneById[droneId] = &myDrones.back();
        }

        // Foe drones
        int foeDroneCount;
        cin >> foeDroneCount; cin.ignore();
        for (int i = 0; i < foeDroneCount; i++) {
            int droneId, droneX, droneY, droneDead, droneBattery;
            cin >> droneId >> droneX >> droneY >> droneDead >> droneBattery; cin.ignore();
            foeDrones.push_back({droneId, droneBattery, Point{droneX, droneY}, (bool) droneDead, vector<int>()});
            droneById[droneId] = &foeDrones.back();
        }

        // Scanned fishes for each drone
        int droneScanCount;
        cin >> droneScanCount; cin.ignore();
        for (int i = 0; i < droneScanCount; i++) {
            int droneId, fishId;
            cin >> droneId >> fishId; cin.ignore();
            droneById[droneId]->scans.emplace_back(fishId);
        }

        // Visible fishes
        int visibleFishesCount;
        cin >> visibleFishesCount; cin.ignore();
        for (int i = 0; i < visibleFishesCount; i++) {
            int fishId, fishX, fishY, fishVx, fishVy;
            cin >> fishId >> fishX >> fishY >> fishVx >> fishVy; cin.ignore();
            visibleFishes.push_back({fishId, Point{fishX, fishY}, Vector{fishVx, fishVy}, fishDetails[fishId]});
        }

        // Radar blips for each drone
        int radarBlipCount;
        cin >> radarBlipCount; cin.ignore();
        for (int i = 0; i < radarBlipCount; i++) {
            int droneId, fishId;
            string direction;
            cin >> droneId >> fishId >> direction; cin.ignore();
            myRadarBlips[droneId].push_back({fishId, direction});
        }

        for (int i = 0; i < myDrones.size(); i++) {
            // Write an action using cout. DON'T FORGET THE "<< endl"
            // To debug: cerr << "Debug messages..." << endl;

            // TODO: Implement your own strategy to scan the fishes
            int x = foeDrones[i].position.x, y = foeDrones[i].position.y, light = 1; // Example follows the enemy drones

            cout << "MOVE " << x << " " << y << " " << light << endl; // MOVE <x> <y> <light (1|0)>
            // cout << "WAIT 0" << endl; // WAIT <light (1|0)>
        }
    }
}