using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;

// Define the data structures as records
record Vector(int x, int y) { }

record FishDetail(int color, int type) { }

record Fish(int fishId, Vector pos, Vector speed, FishDetail detail) { }

record Drone(int droneId, Vector pos, bool dead, int battery, List<int> scans) { }

record RadarBlip(int fishId, String dir) { }

/**
 * Score points by scanning valuable fish faster than your opponent.
 **/
class Player
{
    static void Main(string[] args)
    {
        string[] inputs;

        Dictionary<int, FishDetail> fishDetails = new Dictionary<int, FishDetail>();

        int fishCount = int.Parse(Console.ReadLine());
        for (int i = 0; i < fishCount; i++)
        {
            inputs = Console.ReadLine().Split(' ');
            int fishId = int.Parse(inputs[0]);
            int color = int.Parse(inputs[1]);
            int type = int.Parse(inputs[2]);
            fishDetails.Add(fishId, new FishDetail(color, type));
        }

        // game loop
        while (true)
        {
            List<int> myScans = new List<int>();
            List<int> foeScans = new List<int>();
            Dictionary<int, Drone> droneById = new Dictionary<int, Drone>();
            List<Drone> myDrones = new List<Drone>();
            List<Drone> foeDrones = new List<Drone>();
            List<Fish> visibleFishes = new List<Fish>();
            Dictionary<int, List<RadarBlip>> myRadarBlips = new Dictionary<int, List<RadarBlip>>();

            int myScore = int.Parse(Console.ReadLine());
            int foeScore = int.Parse(Console.ReadLine());
            int myScanCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < myScanCount; i++)
            {
                int fishId = int.Parse(Console.ReadLine());
                myScans.Add(fishId);
            }
            int foeScanCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < foeScanCount; i++)
            {
                int fishId = int.Parse(Console.ReadLine());
                foeScans.Add(fishId);
            }
            int myDroneCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < myDroneCount; i++)
            {
                inputs = Console.ReadLine().Split(' ');
                int droneId = int.Parse(inputs[0]);
                int droneX = int.Parse(inputs[1]);
                int droneY = int.Parse(inputs[2]);
                bool dead = int.Parse(inputs[3]) == 1;
                int battery = int.Parse(inputs[4]);
                Vector pos = new Vector(droneX, droneY);
                Drone drone = new Drone(droneId, pos, dead, battery, new List<int>());
                droneById.Add(droneId, drone);
                myDrones.Add(drone);
                myRadarBlips.Add(droneId, new List<RadarBlip>());
            }
            int foeDroneCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < foeDroneCount; i++)
            {
                inputs = Console.ReadLine().Split(' ');
                int droneId = int.Parse(inputs[0]);
                int droneX = int.Parse(inputs[1]);
                int droneY = int.Parse(inputs[2]);
                bool dead = int.Parse(inputs[3])==1;
                int battery = int.Parse(inputs[4]);
                Vector pos = new Vector(droneX, droneY);
                Drone drone = new Drone(droneId, pos, dead, battery, new List<int>());
                droneById.Add(droneId, drone);
                foeDrones.Add(drone);
            }
            int droneScanCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < droneScanCount; i++)
            {
                inputs = Console.ReadLine().Split(' ');
                int droneId = int.Parse(inputs[0]);
                int fishId = int.Parse(inputs[1]);
                droneById[droneId].scans.Add(fishId);
            }
            int visibleCreatureCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < visibleCreatureCount; i++)
            {
                inputs = Console.ReadLine().Split(' ');
                int fishId = int.Parse(inputs[0]);
                int fishX = int.Parse(inputs[1]);
                int fishY = int.Parse(inputs[2]);
                int fishVx = int.Parse(inputs[3]);
                int fishVy = int.Parse(inputs[4]);
                Vector pos = new Vector(fishX, fishY);
                Vector speed = new Vector(fishVx, fishVy);
                FishDetail detail = fishDetails[fishId];
                visibleFishes.Add(new Fish(fishId, pos, speed, detail));
            }
            int radarBlipCount = int.Parse(Console.ReadLine());
            for (int i = 0; i < radarBlipCount; i++)
            {
                inputs = Console.ReadLine().Split(' ');
                int droneId = int.Parse(inputs[0]);
                int fishId = int.Parse(inputs[1]);
                string radar = inputs[2];
                myRadarBlips[droneId].Add(new RadarBlip(fishId, radar));
            }
            foreach (Drone drone in myDrones)
            {
                int x = drone.pos.x;
                int y = drone.pos.y;
                // TODO: Implement logic on where to move here
                int targetX = 5000;
                int targetY = 5000;
                int light = 1;

                Console.WriteLine(String.Format("MOVE {0} {1} {2}", targetX, targetY, light));
            }
        }
    }
}