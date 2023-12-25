#include <iostream>
#include <cstring>
#include <sstream>
#include <cmath>
using namespace std;

#define LOGS_INPUT true
#define INF 1000000000

const int BOARD_WIDTH = 10000;
const int BOARD_HEIGHT = 10000;

class Point {
public:
  double x;
  double y;
  Point() {
    x = -1;
    y = -1;
  }
  Point(double x, double y) {
    this->x = x;
    this->y = y;
  }

  Point(const Point& other) {
    this->x = other.x;
    this->y = other.y;
  }

  Point operator = (const Point& other) {
    x = other.x;
    y = other.y;
    return *(this);
  }

  Point operator + (Point& other) {
    return Point(x + other.x, y + other.y);
  }

  void add(Point& other) {
    x = x + other.x;
    y = y + other.y;
  }

  Point operator - (Point& other) {
    return Point(x - other.x, y - other.y);
  }

  Point operator / (double d) {
    return Point(x / d, y / d);
  }

  Point operator * (double d) {
    return Point(x * d, y * d);
  }

  Point norm() {
    double m = magnitude();
    return Point(x / m, y / m);
  }

  bool operator == (Point& other) {
    return x == other.x && y == other.y;
  }

  bool operator != (Point& other) {
    return !(*this == other);
  }

  double manhattan(Point& other) {
    return abs(x - other.x) + abs(y - other.y);
  }

  double magnitude() {
    return sqrt(x * x + y * y);
  }

  long double dist2(Point& other) {
    return (x - other.x) * (x - other.x) + (y - other.y) * (y - other.y);
  }

  double dist(Point& other) {
    return sqrt(dist2(other));
  }

  bool isValid() {
    return x >= 0 && y >= 0 && x < BOARD_WIDTH && y < BOARD_HEIGHT;
  }
};


const int MAX_CREATURES = 50;
const int MAX_DRONES = 2;

class Creature {
  public:
  int id;
  int color;
  int type;
  Point pos;
  Point vel;
  bool isVisible;
  bool isSaved[2]; //0th index true if this creature is saved by me, 1st index true if saved by opponent
  bool isScanned[2]; //0th index true if this creature is scanned by me, 1st index true if scanned by opponent

  Creature() {
    id = color = type = -1;
    pos = Point();
    vel = Point();
    isVisible = false;
    for(int i=0;i<2;i++) {
      isScanned[i] = false;
      isSaved[i] = false;
    }
  }
};


class Drone {
public:
  int id;
  Point pos;
  int emergency;
  int battery;
  Drone(){}
};

class Player {
  public:
  int score;
  int drones_count;
  Drone drones[MAX_DRONES];
  Player(){}
};

enum MoveType {
  WAIT,
  MOVE
};

class Move {
public:
  MoveType moveType;
  Point pos;
  bool light;

  Move() {
    moveType = WAIT;
    pos = Point(-1, -1);
    light = false;
  }

  Move(MoveType m, Point pos, bool light) {
    this->moveType = m;
    this->pos = pos;
    this->light = light;
  }

  Move(MoveType m, bool light) {
    this->moveType = m;
    this->light = light;
  }
};

class Solution {
public:
  int drones_count;
  Move moves[MAX_DRONES];
  int score;

  Solution() {
    score = -INF;
  }
};

class GameState {
  public:
  int creatures_count;
  Creature creatures[MAX_CREATURES];
  Player players[2];
  GameState(){}

  void initialize();
  void startTurn();
  void getBestMove(Solution& solution);
  void endTurn(Solution& solution);
};

void GameState::initialize() {
  stringstream input;
  cin >> creatures_count;
  input << creatures_count << endl;
  for (int i = 0; i < creatures_count; i++) {
    cin >> creatures[i].id >> creatures[i].color >> creatures[i].type;
    input << creatures[i].id <<" "<< creatures[i].color <<" "<< creatures[i].type << endl;
  }

  if (LOGS_INPUT) {
    cerr << input.str();
  }
}

void GameState::startTurn() {
  for(int i=0;i<creatures_count;i++) {
    creatures[i].pos = Point();
    creatures[i].vel = Point();
    creatures[i].isVisible = false;
    creatures[i].isScanned[0] = false;
    creatures[i].isScanned[1] = false;
    creatures[i].isSaved[0] = false;
    creatures[i].isSaved[1] = false;
  }

  stringstream input;
  for(int i = 0; i < 2; i++) {
    cin >> players[i].score;
    input << players[i].score << endl;
  }

  //Saved = Fishes that are scanned and reported at the top
  for(int i = 0; i < 2; i++) {
    int savedCount;
    cin >> savedCount;
    input << savedCount << endl;
    for (int j = 0; j < savedCount; j++) {
      int creature_id;
      cin >> creature_id;
      input << creature_id << endl;

      for(int k=0;k<creatures_count;k++) {
        if(creatures[k].id == creature_id) {
          creatures[k].isSaved[i] = true;
        }
      }
    }
  }

  bool isMyDrone[4];
  memset(isMyDrone, false,sizeof(isMyDrone));

  for(int i = 0; i < 2; i++) {
    cin >> players[i].drones_count;
    input << players[i].drones_count << endl;
    for (int j = 0; j < players[i].drones_count; j++) {
      cin >> players[i].drones[j].id >> players[i].drones[j].pos.x >> players[i].drones[j].pos.y >> players[i].drones[j].emergency >> players[i].drones[j].battery;
      input << players[i].drones[j].id << " " << players[i].drones[j].pos.x << " " << players[i].drones[j].pos.y << " " << players[i].drones[j].emergency << " " << players[i].drones[j].battery <<endl;
      if(i==0){
      	isMyDrone[players[i].drones[j].id] = true;
      }
    }
  }


  //Fishes that are scanned
  int drone_scan_count;
  cin >> drone_scan_count;
  input << drone_scan_count << endl;
  for (int i = 0; i < drone_scan_count; i++) {
    int drone_id;
    int creature_id;
    cin >> drone_id >> creature_id;
    input << drone_id << " " << creature_id << endl;
    for(int k=0;k<creatures_count;k++) {
      if(creatures[k].id == creature_id) {
        creatures[k].isScanned[isMyDrone[drone_id]?0:1] = true;
      }
    }
  }

  int visible_creatures_count;
  cin >> visible_creatures_count;
  input << visible_creatures_count << endl;

  for (int i = 0; i < visible_creatures_count; i++) {
    int creature_id;
    int creature_x;
    int creature_y;
    int creature_vx;
    int creature_vy;
    cin >> creature_id >> creature_x >> creature_y >> creature_vx >> creature_vy;
    input << creature_id << " " << creature_x << " " << creature_y << " " << creature_vx << " " << creature_vy << endl;

    for(int j=0;j<creatures_count;j++) {
      if(creatures[j].id == creature_id) {
        creatures[j].isVisible = true;
        creatures[j].pos = Point(creature_x, creature_y);
        creatures[j].vel = Point(creature_vx, creature_vy);      
      }
    }
  }

  int radar_blip_count;
  cin >> radar_blip_count;
  input << radar_blip_count << endl;

  for (int i = 0; i < radar_blip_count; i++) {
    int drone_id;
    int creature_id;
    string radar;
    cin >> drone_id >> creature_id >> radar;
    input << drone_id << " " << creature_id << " " << radar << endl;
  }

  if (LOGS_INPUT) {
    cerr << input.str();
  }
}

void GameState::endTurn(Solution& solution) {
  for (int i = 0; i < solution.drones_count; i++) {
    if(solution.moves[i].moveType == WAIT) {
      cout << "WAIT "<< (int)solution.moves[i].light;
    }
    else {
      cout<<"MOVE "<<solution.moves[i].pos.x<<" "<<solution.moves[i].pos.y<<" "<<(int)solution.moves[i].light;
    }
    cout<<" battery:"<<players[0].drones[i].battery<<endl;
  }
}

void GameState::getBestMove(Solution& bestSolution) {
  bestSolution.moves[0] = Move(WAIT, false);
  bestSolution.drones_count = players[0].drones_count;
  for(int i=0;i<creatures_count;i++) {
    if(creatures[i].isVisible && !creatures[i].isSaved[0] && !creatures[i].isScanned[0]) {      
      bestSolution.moves[0] = Move(MOVE, creatures[i].pos, true);
      break;
    }
  }
}

static int turn = 0;
int main() {
  ios::sync_with_stdio(false);
  GameState state;
  state.initialize();
  Solution solution;

  while (1) {
    state.startTurn();
    state.getBestMove(solution);
    state.endTurn(solution);
    turn++;
  }
}
