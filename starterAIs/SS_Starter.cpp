#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

// Define the data structures as structs
struct Vector {
    int x, y;
};

struct FishDetail {
    int color, type;
};

struct Fish {
    int fish_id;
    Vector pos, speed;
    FishDetail detail;
};

struct Drone {
    int drone_id, dead, battery;
    Vector pos;
    vector<int> scans;
};

struct RadarBlip {
    int fish_id;
    string dir;
};

/**
 * Score points by scanning valuable fish faster than your opponent.
 **/

int main()
{
    map<int, FishDetail> fish_details;

    int fish_count;
    cin >> fish_count; cin.ignore();
    for (int i = 0; i < fish_count; i++) {
        int fish_id;
        int color;
        int type;
        cin >> fish_id >> color >> type; cin.ignore();
        fish_details.insert({fish_id, {color, type}});
    }

    // game loop
    while (1) {
        vector<int> my_scans, foe_scans;
        map<int, Drone> drone_by_id;
        vector<Drone> my_drones, foe_drones;
        vector<Fish> visible_fishes;
        map<int, vector<RadarBlip>> my_radar_blips;
        
        int my_score;
        cin >> my_score; cin.ignore();
        int foe_score;
        cin >> foe_score; cin.ignore();
        int my_scan_count;
        cin >> my_scan_count; cin.ignore();
        for (int i = 0; i < my_scan_count; i++) {
            int fish_id;
            cin >> fish_id; cin.ignore();
            my_scans.push_back(fish_id);
        }
        int foe_scan_count;
        cin >> foe_scan_count; cin.ignore();
        for (int i = 0; i < foe_scan_count; i++) {
            int fish_id;
            cin >> fish_id; cin.ignore();
            foe_scans.push_back(fish_id);
        }
        int my_drone_count;
        cin >> my_drone_count; cin.ignore();
        for (int i = 0; i < my_drone_count; i++) {
            int drone_id;
            int drone_x;
            int drone_y;
            int dead;
            int battery;
            cin >> drone_id >> drone_x >> drone_y >> dead >> battery; cin.ignore();
            Vector pos {drone_x, drone_y};
            Drone drone {drone_id, dead, battery, pos, {}};
            drone_by_id.insert({drone_id, drone});
            my_drones.push_back(drone);
            my_radar_blips.insert({drone_id, {}});
        }
        int foe_drone_count;
        cin >> foe_drone_count; cin.ignore();
        for (int i = 0; i < foe_drone_count; i++) {
            int drone_id;
            int drone_x;
            int drone_y;
            int dead;
            int battery;
            cin >> drone_id >> drone_x >> drone_y >> dead >> battery; cin.ignore();
            Vector pos {drone_x, drone_y};
            Drone drone {drone_id, dead, battery, pos, {}};
            drone_by_id.insert({drone_id, drone});
            foe_drones.push_back(drone);
        }
        int drone_scan_count;
        cin >> drone_scan_count; cin.ignore();
        for (int i = 0; i < drone_scan_count; i++) {
            int drone_id;
            int fish_id;
            cin >> drone_id >> fish_id; cin.ignore();
            drone_by_id[drone_id].scans.push_back(fish_id);
        }
        int visible_creature_count;
        cin >> visible_creature_count; cin.ignore();
        for (int i = 0; i < visible_creature_count; i++) {
            int fish_id;
            int fish_x;
            int fish_y;
            int fish_vx;
            int fish_vy;
            cin >> fish_id >> fish_x >> fish_y >> fish_vx >> fish_vy; cin.ignore();
            Vector pos {fish_x, fish_y};
            Vector speed {fish_vx, fish_vy};
            visible_fishes.push_back({fish_id, pos, speed, fish_details[fish_id]});
        }
        int radar_blip_count;
        cin >> radar_blip_count; cin.ignore();
        for (int i = 0; i < radar_blip_count; i++) {
            int drone_id;
            int fish_id;
            string radar;
            cin >> drone_id >> fish_id >> radar; cin.ignore();
            my_radar_blips[drone_id].push_back({fish_id, radar});
        }
        for (int i = 0; i < my_drone_count; i++) {

            // Write an action using cout. DON'T FORGET THE "<< endl"
            // To debug: cerr << "Debug messages..." << endl;

            int x = my_drones[i].pos.x;
            int y = my_drones[i].pos.y;
            // TODO: Implement logic on where to move here
            int target_x = 5000;
            int target_y = 5000;
            int light = 1;

            cout << "MOVE " << target_x << ' ' << target_y << ' ' << light << endl; // MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
        }
    }
}