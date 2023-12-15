package com.codingame.game;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.codingame.endscreen.EndScreenModule;
import com.codingame.event.Animation;
import com.codingame.event.EventData;
import com.codingame.gameengine.core.MultiplayerGameManager;
import com.codingame.view.ViewModule;
import com.google.common.base.Objects;
import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class Game {
    @Inject private MultiplayerGameManager<Player> gameManager;
    @Inject private EndScreenModule endScreenModule;
    @Inject private Animation animation;
    @Inject private GameSummaryManager gameSummaryManager;
    @Inject private ViewModule view;

    private Random random;

    List<Player> players;
    List<Fish> fishes;
    List<Ugly> uglies;

    Map<Scan, Integer> firstToScan = new HashMap<>();
    Map<Scan, Integer> firstToScanTemp = new HashMap<>();

    Map<Integer, Integer> firstToScanAllFishOfColor = new HashMap<>();
    Map<Integer, Integer> firstToScanAllFishOfColorTemp = new HashMap<>();

    Map<FishType, Integer> firstToScanAllFishOfType = new HashMap<>();
    Map<FishType, Integer> firstToScanAllFishOfTypeTemp = new HashMap<>();

    private List<EventData> viewerEvents;

    public static String COLORS[] = { "pink", "yellow", "green", "blue" };

    private int gameTurn;
    public static final int WIDTH = 10000;
    public static final int HEIGHT = 10000;

    public static int DRONES_PER_PLAYER = 2;

    public static final int UGLY_UPPER_Y_LIMIT = 2500;
    public static final int DRONE_UPPER_Y_LIMIT = 0;
    public static final int DRONE_START_Y = 500;

    public static int COLORS_PER_FISH = 4;
    public static final int DRONE_MAX_BATTERY = 30;
    public static final int LIGHT_BATTERY_COST = 5;
    public static final int DRONE_BATTERY_REGEN = 1;
    public static final int DRONE_MAX_SCANS = Integer.MAX_VALUE;

    public static int DARK_SCAN_RANGE = 800;
    public static int LIGHT_SCAN_RANGE = 2000;
    public static final int UGLY_EAT_RANGE = 300;
    public static final int DRONE_HIT_RANGE = 200;
    public static final int FISH_HEARING_RANGE = (DARK_SCAN_RANGE + LIGHT_SCAN_RANGE) / 2;

    public static final int DRONE_MOVE_SPEED = 600;
    public static final int DRONE_SINK_SPEED = 300;
    public static final int DRONE_EMERGENCY_SPEED = 300;
    public static final double DRONE_MOVE_SPEED_LOSS_PER_SCAN = 0;

    public static final int FISH_SWIM_SPEED = 200;
    public static final int FISH_AVOID_RANGE = 600;
    public static final int FISH_FLEE_SPEED = 400;
    public static final int UGLY_ATTACK_SPEED = (int) (DRONE_MOVE_SPEED * 0.9);
    public static final int UGLY_SEARCH_SPEED = (int) (UGLY_ATTACK_SPEED / 2);

    public static final int FISH_X_SPAWN_LIMIT = 1000;
    public static final int FISH_SPAWN_MIN_SEP = 1000;
    public static final boolean ALLOW_EMOJI = true;

    public static final Vector CENTER = new Vector((WIDTH - 1) / 2.0, (HEIGHT - 1) / 2.0);
    public static final int MAX_TURNS = 201;
    public static boolean ENABLE_UGLIES = true;
    public static boolean FISH_WILL_FLEE = true;
    public static boolean FISH_WILL_MOVE = true;
    public static boolean SIMPLE_SCANS = false;

    private static int[] chasedFishCount;
    private static int[] timesAggroed;
    private static int[] maxTurnsSpentWithScan;
    private static int[] maxY;
    private static int[][] turnSavedFish;

    private static int dronesEaten;
    private static int fishScanned;

    static int ENTITY_COUNT = 0;

    public void init() {
        ENTITY_COUNT = 0;
        players = gameManager.getPlayers();
        random = gameManager.getRandom();
        viewerEvents = new ArrayList<>();
        gameTurn = 1;
        initPlayers();
        initFish();
        initUglies();

        chasedFishCount = new int[] { 0, 0 };
        maxTurnsSpentWithScan = new int[] { 0, 0 };
        maxY = new int[] { 0, 0 };
        turnSavedFish = new int[][] { { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }, { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 } };
        timesAggroed = new int[] { 0, 0 };
        dronesEaten = 0;
        fishScanned = 0;

        for (Player player : players) {
            if (SIMPLE_SCANS) {
                player.visibleFishes.addAll(fishes);
            }
        }
    }

    Supplier<Stream<Entity>> allEntities = () -> {
        return Stream
            .of(
                players.stream().flatMap(s -> s.drones.stream()),
                fishes.stream(),
                uglies.stream()
            )
            .flatMap(Function.identity());
    };

    private void initUglies() {
        uglies = new ArrayList<>();

        int uglyCount = ENABLE_UGLIES ? 1 + random.nextInt(3) : 0;

        for (int i = 0; i < uglyCount; ++i) {
            int x = random.nextInt(WIDTH / 2);

            int y = HEIGHT / 2 + random.nextInt(HEIGHT / 2);
            for (int k = 0; k < 2; ++k) {
                Ugly ugly = new Ugly(x, y, ENTITY_COUNT++);
                if (k == 1) {
                    ugly.pos = ugly.pos.hsymmetric(CENTER.getX());
                }

                uglies.add(ugly);
            }

        }
    }

    private void initFish() {
        fishes = new ArrayList<>();

        for (int col = 0; col < COLORS_PER_FISH; col += 2) {
            for (int typeIdx = 0; typeIdx < FishType.values().length; ++typeIdx) {
                boolean positionFound = false;
                int iterations = 0;
                int x = 0;
                int y = 0;

                int lowY = HEIGHT / 4;
                int highY = HEIGHT;

                while (!positionFound) {
                    x = random.nextInt(WIDTH - FISH_X_SPAWN_LIMIT * 2) + FISH_X_SPAWN_LIMIT;
                    if (typeIdx == 0) {
                        y = 1 * HEIGHT / 4 + FISH_SPAWN_MIN_SEP;
                        lowY = 1 * HEIGHT / 4;
                        highY = 2 * HEIGHT / 4;
                    } else if (typeIdx == 1) {
                        y = 2 * HEIGHT / 4 + FISH_SPAWN_MIN_SEP;
                        lowY = 2 * HEIGHT / 4;
                        highY = 3 * HEIGHT / 4;
                    } else {
                        y = 3 * HEIGHT / 4 + FISH_SPAWN_MIN_SEP;
                        lowY = 3 * HEIGHT / 4;
                        highY = 4 * HEIGHT / 4;
                    }
                    y += random.nextInt(HEIGHT / 4 - FISH_SPAWN_MIN_SEP * 2);

                    final int finalX = x;
                    final int finalY = y;
                    boolean tooClose = fishes.stream().anyMatch(other -> other.getPos().inRange(new Vector(finalX, finalY), FISH_SPAWN_MIN_SEP));
                    boolean tooCloseToCenter = Math.abs(CENTER.getX() - x) <= FISH_SPAWN_MIN_SEP;
                    if (!tooClose && !tooCloseToCenter || iterations > 100) {
                        positionFound = true;
                    }
                    iterations++;
                }
                Fish f = new Fish(x, y, FishType.values()[typeIdx], col, ENTITY_COUNT++, lowY, highY);

                double snapped = (random.nextInt() * 7) * Math.PI / 4;
                Vector direction = new Vector(
                    Math.cos(snapped),
                    Math.sin(snapped)
                );

                if (Game.FISH_WILL_MOVE) {
                    f.speed = direction.mult(FISH_SWIM_SPEED).round();
                }

                fishes.add(f);

                Vector otherPos = f.pos.hsymmetric(CENTER.getX());
                Fish o = new Fish(otherPos.getX(), otherPos.getY(), FishType.values()[typeIdx], col + 1, ENTITY_COUNT++, f.lowY, f.highY);
                o.speed = f.speed.hsymmetric();
                fishes.add(o);

            }
        }
    }

    private void initPlayers() {
        int[] idxs = new int[] { 0, 2, 1, 3 };
        int idxIdx = 0;
        for (int i = 0; i < DRONES_PER_PLAYER; ++i) {
            double x = WIDTH / (DRONES_PER_PLAYER * 2 + 1) * (idxs[idxIdx] + 1);
            idxIdx++;
            for (Player player : gameManager.getActivePlayers()) {
                Drone d = new Drone(x, DRONE_START_Y, ENTITY_COUNT++, player);

                if (player.getIndex() == 1) {
                    d.pos = d.pos.hsymmetric(CENTER.getX());
                }

                player.drones.add(d);

            }
        }
    }

    public void resetGameTurnData() {
        viewerEvents.clear();
        animation.reset();
        players.stream().forEach(Player::reset);
    }

    boolean updateUglyTarget(Ugly ugly) {
        List<Drone> targetableDrones = players.stream()
            .flatMap(p -> p.drones.stream())
            .filter(drone -> drone.pos.inRange(ugly.pos, drone.isLightOn() ? LIGHT_SCAN_RANGE : DARK_SCAN_RANGE))
            .filter(drone -> !drone.isDeadOrDying())
            .collect(Collectors.toList());

        if (!targetableDrones.isEmpty()) {
            Closest<Drone> closestTargets = getClosestTo(ugly.pos, targetableDrones.stream());
            ugly.target = closestTargets.getMeanPos();
            for (Drone d : closestTargets.list) {
                timesAggroed[d.owner.getIndex()]++;
            }

            return true;
        }

        ugly.target = null;
        return false;
    }

    void moveEntities() {
        for (Player p : players) {
            for (Drone drone : p.drones) {
                if (drone.dead) {
                    continue;
                }
                //NOTE: the collision code does not take into account the snap to map borders
                for (Ugly ugly : uglies) {
                    Collision col = getCollision(drone, ugly);
                    if (col.happened()) {
                        drone.dying = true;
                        drone.scans.clear();
                        drone.dieAt = col.t;

                        gameSummaryManager.addPlayerSummary(
                            p.getNicknameToken(),
                            String.format(
                                "%s's drone %d is hit by monster %d!",
                                p.getNicknameToken(),
                                drone.id,
                                ugly.id
                            )
                        );

                        dronesEaten++;
                        // If two uglies hit the drone, let's just keep the first collision, it matters not.
                        break;
                    }
                }
            }
        }

        for (Player p : players) {
            for (Drone drone : p.drones) {
                Vector speed = drone.getSpeed();
                drone.pos = drone.pos.add(speed);
                snapToDroneZone(drone);
            }
        }

        for (Fish f : fishes) {
            f.pos = f.pos.add(f.getSpeed());
            snapToFishZone(f);
        }
        List<Fish> fishToRemove = fishes.stream().filter(
            fish -> fish.getPos().getX() > WIDTH - 1 || fish.getPos().getX() < 0
        ).collect(Collectors.toList());
        for (Fish fish : fishToRemove) {
            if (fish.fleeingFromPlayer != null && fish.fleeingFromPlayer != -1) {
                chasedFishCount[fish.fleeingFromPlayer] += 1;
            }
        }
        fishes.removeAll(fishToRemove);
        for (Fish f : fishes) {
            f.fleeingFromPlayer = null;
        }

        for (Ugly ugly : uglies) {
            ugly.pos = ugly.pos.add(ugly.speed);
            snapToUglyZone(ugly);
        }
    }

    private void snapToUglyZone(Ugly ugly) {
        if (ugly.pos.getY() > HEIGHT - 1) {
            ugly.pos = new Vector(ugly.pos.getX(), HEIGHT - 1);
        } else if (ugly.pos.getY() < UGLY_UPPER_Y_LIMIT) {
            ugly.pos = new Vector(ugly.pos.getX(), UGLY_UPPER_Y_LIMIT);
        }
    }

    void updateUglySpeeds() {
        for (Ugly ugly : uglies) {
            Vector target = ugly.target;
            if (target != null) {
                Vector attackVec = new Vector(ugly.pos, target);
                if (attackVec.length() > UGLY_ATTACK_SPEED) {
                    attackVec = attackVec.normalize().mult(UGLY_ATTACK_SPEED);
                }
                ugly.speed = attackVec.round();
            } else {
                if (ugly.speed.length() > UGLY_SEARCH_SPEED) {
                    ugly.speed = ugly.speed.normalize().mult(UGLY_SEARCH_SPEED).round();
                }

                if (!ugly.speed.isZero()) {
                    Closest<Ugly> closestUglies = getClosestTo(
                        ugly.pos,
                        uglies.stream().filter(u -> u != ugly)
                    );
                    if (!closestUglies.list.isEmpty() && closestUglies.distance <= FISH_AVOID_RANGE) {
                        Vector avoid = closestUglies.getMeanPos();
                        Vector avoidDir = new Vector(avoid, ugly.pos).normalize();
                        if (!avoidDir.isZero()) {
                            ugly.speed = avoidDir.mult(FISH_SWIM_SPEED).round();
                        }
                    }
                }
                Vector nextPos = ugly.pos.add(ugly.speed);

                if (
                    nextPos.getX() < 0 && nextPos.getX() < ugly.pos.getX() ||
                        nextPos.getX() > WIDTH - 1 && nextPos.getX() > ugly.pos.getX()
                ) {
                    ugly.speed = ugly.speed.hsymmetric();
                }

                if (
                    nextPos.getY() < UGLY_UPPER_Y_LIMIT && nextPos.getY() < ugly.pos.getY() ||
                        nextPos.getY() > HEIGHT - 1 && nextPos.getY() > ugly.pos.getY()
                ) {
                    ugly.speed = ugly.speed.vsymmetric();
                }
            }
        }
    }

    void updateUglyTargets() {
        for (Ugly ugly : uglies) {
            boolean foundTarget = updateUglyTarget(ugly);
            ugly.foundTarget = foundTarget;
        }
    }

    void updateFish() {
        for (Fish fish : fishes) {
            fish.isFleeing = false;

            Vector fleeFrom = null;
            if (FISH_WILL_FLEE) {
                Closest<Drone> closestDrones = getClosestTo(
                    fish.pos,
                    players.stream()
                        .flatMap(p -> p.drones.stream())
                        .filter(d -> d.isEngineOn() && !d.dead)
                );

                if (!closestDrones.list.isEmpty() && closestDrones.distance <= FISH_HEARING_RANGE) {
                    fleeFrom = closestDrones.getMeanPos();
                    Integer fleeingFromPlayer = null;
                    for (Drone d : closestDrones.list) {
                        int idx = d.owner.getIndex();
                        if (fleeingFromPlayer == null || fleeingFromPlayer.equals(idx)) {
                            fleeingFromPlayer = idx;
                        } else {
                            fleeingFromPlayer = -1;
                        }
                    }
                    fish.fleeingFromPlayer = fleeingFromPlayer;
                }
            }
            if (fleeFrom != null) {
                Vector fleeDir = new Vector(fleeFrom, fish.pos).normalize();
                Vector fleeVec = fleeDir.mult(FISH_FLEE_SPEED);
                fish.speed = fleeVec.round();
                fish.isFleeing = true;
            } else {
                Closest<Fish> closestFishes = getClosestTo(
                    fish.pos,
                    fishes.stream().filter(f -> f != fish)
                );

                Vector swimVec = fish.speed.normalize().mult(FISH_SWIM_SPEED);
                if (!closestFishes.list.isEmpty() && closestFishes.distance <= FISH_AVOID_RANGE) {
                    Vector avoid = closestFishes.getMeanPos();
                    Vector avoidDir = new Vector(avoid, fish.pos).normalize();
                    swimVec = avoidDir.mult(FISH_SWIM_SPEED);
                }

                Vector nextPos = fish.pos.add(swimVec);

                if (
                    nextPos.getX() < 0 && nextPos.getX() < fish.pos.getX() ||
                        nextPos.getX() > WIDTH - 1 && nextPos.getX() > fish.pos.getX()
                ) {
                    swimVec = swimVec.hsymmetric();
                }

                double yHighest = Math.min(HEIGHT - 1, fish.highY);

                if (
                    nextPos.getY() < fish.lowY && nextPos.getY() < fish.pos.getY() ||
                        nextPos.getY() > yHighest && nextPos.getY() > fish.pos.getY()
                ) {
                    swimVec = swimVec.vsymmetric();
                }
                fish.speed = swimVec.epsilonRound().round();
            }
        }
    }

    private void snapToFishZone(Fish fish) {
        if (fish.pos.getY() > HEIGHT - 1) {
            fish.pos = new Vector(fish.pos.getX(), HEIGHT - 1);
        } else if (fish.pos.getY() > fish.highY) {
            fish.pos = new Vector(fish.pos.getX(), fish.highY);
        } else if (fish.pos.getY() < fish.lowY) {
            fish.pos = new Vector(fish.pos.getX(), fish.lowY);
        }

    }

    void updateDrones() {
        for (Player p : players) {
            for (Drone drone : p.drones) {
                int moveSpeed = (int) (DRONE_MOVE_SPEED - DRONE_MOVE_SPEED * DRONE_MOVE_SPEED_LOSS_PER_SCAN * drone.scans.size());
                if (drone.dead) {
                    Vector floatVec = new Vector(0, -1).mult(DRONE_EMERGENCY_SPEED);
                    drone.speed = floatVec;
                } else if (drone.move != null) {
                    Vector moveVec = new Vector(drone.pos, drone.move);
                    if (moveVec.length() > moveSpeed) {
                        moveVec = moveVec.normalize().mult(moveSpeed);
                    }
                    drone.speed = moveVec.round();
                } else if (drone.pos.getY() < HEIGHT - 1) {
                    Vector sinkVec = new Vector(0, 1).mult(DRONE_SINK_SPEED);
                    drone.speed = sinkVec;
                }
            }
        }

    }

    private void snapToDroneZone(Drone drone) {
        if (drone.pos.getY() > HEIGHT - 1) {
            drone.pos = new Vector(drone.pos.getX(), HEIGHT - 1);
        } else if (drone.pos.getY() < DRONE_UPPER_Y_LIMIT) {
            drone.pos = new Vector(drone.pos.getX(), DRONE_UPPER_Y_LIMIT);
        }
        if (drone.pos.getX() < 0) {
            drone.pos = new Vector(0, drone.pos.getY());
        } else if (drone.pos.getX() >= WIDTH) {
            drone.pos = new Vector(WIDTH - 1, drone.pos.getY());
        }
    }

    private <T extends Entity> Closest<T> getClosestTo(Vector from, Stream<T> targetStream) {
        List<T> targets = targetStream.collect(Collectors.toList());

        ArrayList<T> closests = new ArrayList<>();
        double minDist = 0;

        for (T t : targets) {
            double dist = t.getPos().sqrEuclideanTo(from);
            if (closests.isEmpty() || dist < minDist) {
                closests.clear();
                closests.add(t);
                minDist = dist;
            } else if (dist == minDist) {
                closests.add(t);
            }
        }
        return new Closest<T>(closests, Math.sqrt(minDist));
    }

    public void performGameUpdate(int frameIdx) {
        clearPlayerInfo();
        doBatteries();

        // Update speeds
        updateDrones();

        // Move
        moveEntities();

        // Target
        updateUglyTargets();

        // Scans
        doScan();
        doReport();

        // Upkeep
        upkeepDrones();

        // Update speeds        
        updateFish();
        updateUglySpeeds();

        if (isGameOver()) {
            computeScoreOnEnd();
            gameManager.endGame();
        }
        gameTurn++;

        gameManager.addToGameSummary(gameSummaryManager.toString());
        gameSummaryManager.clear();

        int frameTime = animation.computeEvents();
        gameManager.setFrameDuration(frameTime);
    }

    private void clearPlayerInfo() {
        players.stream().forEach(p -> p.visibleFishes.clear());

    }

    private void upkeepDrones() {
        for (Player p : players) {
            for (Drone d : p.drones) {
                if (d.dying) {
                    d.dead = true;
                    d.dying = false;
                } else if (d.dead && d.getY() == DRONE_UPPER_Y_LIMIT) {
                    d.dead = false;
                }

                /* stats */
                if (d.scans.isEmpty()) {
                    d.turnsSpentWithScan = 0;
                } else {
                    d.turnsSpentWithScan++;
                    if (d.turnsSpentWithScan > d.maxTurnsSpentWithScan) {
                        d.maxTurnsSpentWithScan = d.turnsSpentWithScan;
                    }
                }
                if (d.pos.getY() > d.maxY) {
                    d.maxY = (int) d.pos.getY();
                }
            }
        }

    }

    private void doBatteries() {
        for (Player player : players) {
            for (Drone drone : player.drones) {

                if (drone.dead) {
                    drone.lightOn = false;
                    continue;
                }

                if (drone.lightSwitch && drone.battery >= Game.LIGHT_BATTERY_COST && !drone.dead) {
                    drone.lightOn = true;
                } else {
                    if (drone.lightSwitch && !drone.dead) {
                        gameSummaryManager.addPlayerSummary(
                            player.getNicknameToken(),
                            player.getNicknameToken() + "'s drone " + drone.id + " does not have enough battery to activate light"
                        );
                    }
                    drone.lightOn = false;
                }

                if (drone.isLightOn()) {
                    drone.drainBattery();
                } else {
                    drone.rechargeBattery();
                }
            }
        }

    }

    private void doScan() {
        for (Player player : players) {
            for (Drone drone : player.drones) {
                if (drone.isDeadOrDying()) {
                    continue;
                }

                List<Fish> scannableFish = fishes.stream()
                    .filter(fish -> fish.pos.inRange(drone.pos, drone.isLightOn() ? LIGHT_SCAN_RANGE : DARK_SCAN_RANGE))
                    .collect(Collectors.toList());

                scannableFish.forEach(fish -> {
                    player.visibleFishes.add(fish);

                    if (drone.scans.size() < DRONE_MAX_SCANS) {
                        Scan scan = new Scan(fish);
                        if (!player.scans.contains(scan)) {
                            if (!drone.scans.contains(scan)) {
                                drone.scans.add(scan);
                                drone.fishesScannedThisTurn.add(fish.id);
                            }
                        }
                    }
                });

                if (SIMPLE_SCANS) {
                    player.visibleFishes.addAll(fishes);
                }

                if (drone.fishesScannedThisTurn.size() > 0) {
                    String summaryScan = drone.fishesScannedThisTurn.stream().map(fishScan -> {
                        return Integer.toString(fishScan);
                    }).collect((Collectors.joining(",")));
                    if (drone.fishesScannedThisTurn.size() == 1) {
                        gameSummaryManager.addPlayerSummary(
                            player.getNicknameToken(),
                            String.format(
                                "%s's drone %d scans fish %d", player.getNicknameToken(), drone.id, drone.fishesScannedThisTurn.get(0)
                            )
                        );
                    } else {
                        gameSummaryManager.addPlayerSummary(
                            player.getNicknameToken(),
                            String.format(
                                "%s's drone %d scans %d fish: %s", player.getNicknameToken(), drone.id, drone.fishesScannedThisTurn.size(),
                                summaryScan
                            )
                        );
                    }
                }
            }
        }

    }

    private boolean applyScansForReport(Player player, Drone drone) {
        boolean pointsScored = false;
        for (Scan scan : drone.scans) {
            if (!firstToScan.containsKey(scan)) {
                if (firstToScanTemp.containsKey(scan)) {
                    // Opponent also completed this report this turn, nobody gets the bonus
                    firstToScanTemp.remove(scan);
                } else {
                    firstToScanTemp.put(scan, player.getIndex());
                }
            }
            int fishIndex = scan.color * 3 + scan.type.ordinal();
            turnSavedFish[player.getIndex()][fishIndex] = gameTurn;
            fishScanned++;
        }
        if (drone.scans.size() > 0) {
            player.countFishSaved.add(drone.scans.size());
        }
        pointsScored |= player.scans.addAll(drone.scans);
        for (Drone other : player.drones) {
            if (drone != other) {
                other.scans.removeAll(drone.scans);
            }
        }

        drone.scans.clear();
        return pointsScored;
    }

    private void detectFirstToComboBonuses(Player player) {
        for (FishType type : FishType.values()) {
            if (!firstToScanAllFishOfType.containsKey(type)) {
                if (playerScannedAllFishOfType(player, type)) {
                    if (firstToScanAllFishOfTypeTemp.containsKey(type)) {
                        // Opponent also completed this report this turn, nobody gets the bonus
                        firstToScanAllFishOfTypeTemp.remove(type);
                    } else {
                        firstToScanAllFishOfTypeTemp.put(type, player.getIndex());
                    }
                }
            }
        }

        for (int color = 0; color < COLORS_PER_FISH; ++color) {
            if (!firstToScanAllFishOfColor.containsKey(color)) {
                if (playerScannedAllFishOfColor(player, color)) {
                    if (firstToScanAllFishOfColorTemp.containsKey(color)) {
                        // Opponent also completed this report this turn, nobody gets the bonus
                        firstToScanAllFishOfColorTemp.remove(color);
                    } else {
                        firstToScanAllFishOfColorTemp.put(color, player.getIndex());
                    }

                }
            }
        }
    }

    private void doReport() {
        for (Player player : players) {
            boolean pointsScored = false;
            for (Drone drone : player.drones) {
                if (drone.isDeadOrDying()) {
                    continue;
                }
                if (SIMPLE_SCANS || !drone.scans.isEmpty() && drone.pos.getY() <= DRONE_START_Y) {
                    boolean droneScored = applyScansForReport(player, drone);
                    pointsScored |= droneScored;
                    if (droneScored) {
                        drone.didReport = true;
                    }
                }
            }
            if (pointsScored) {
                gameManager.addTooltip(player, player.getNicknameToken() + " reports their findings.");
            }

            detectFirstToComboBonuses(player);

        }

        persistFirstToScanBonuses();
        for (Player p : players) {
            p.points = computePlayerScore(p);
        }
    }

    private void persistFirstToScanBonuses() {
        Map<String, List<Scan>> playerScansMap = new HashMap<String, List<Scan>>();

        firstToScanTemp.forEach((k, v) -> {
            firstToScan.putIfAbsent(k, v);

            String playerName = players.get(v).getNicknameToken();
            playerScansMap.putIfAbsent(playerName, new ArrayList<Scan>());
            playerScansMap.get(playerName).add(k);
        });
        playerScansMap.entrySet().forEach(playerScans -> {
            String summaryString = playerScans.getValue().stream().map(scan -> String.valueOf(scan.fishId))
                .collect(Collectors.joining(", "));
            if (playerScans.getValue().size() == 1) {
                gameSummaryManager.addPlayerSummary(
                    playerScans.getKey(),
                    String.format(
                        "%s was the first to save the scan of creature %s", playerScans.getKey(), summaryString
                    )
                );
            } else {
                gameSummaryManager.addPlayerSummary(
                    playerScans.getKey(),
                    String.format(
                        "%s was the first to save the scans of %d creatures: %s", playerScans.getKey(), playerScans.getValue().size(), summaryString
                    )
                );
            }
        });
        firstToScanAllFishOfTypeTemp.forEach((k, v) -> {
            firstToScanAllFishOfType.putIfAbsent(k, v);

            String playerName = players.get(v).getNicknameToken();
            String fishSpecies = k.ordinal() + " (" + k.toString().toLowerCase() + ")";
            gameSummaryManager
                .addPlayerSummary(
                    playerName,
                    String.format("%s saved the scans of every color of %s first", playerName, fishSpecies)
                );
        });
        firstToScanAllFishOfColorTemp.forEach((k, v) -> {
            firstToScanAllFishOfColor.putIfAbsent(k, v);

            String playerName = players.get(v).getNicknameToken();
            gameSummaryManager
                .addPlayerSummary(
                    playerName,
                    String.format("%s has saved the scans of every %d colored (%s) creature first", playerName, k, COLORS[k])
                );
        });

        firstToScanTemp.clear();
        firstToScanAllFishOfColorTemp.clear();
        firstToScanAllFishOfTypeTemp.clear();
    }

    private boolean playerScanned(Player player, Fish fish) {
        return playerScanned(player, new Scan(fish));
    }

    boolean playerScanned(Player player, Scan scan) {
        return player.scans.contains(scan);
    }

    private boolean hasScannedAllRemainingFish(Player player) {
        for (Fish fish : fishes) {
            if (!playerScanned(player, fish)) {
                return false;
            }
        }
        return true;
    }

    private boolean hasFishEscaped(Scan scan) {
        return !fishes.stream().filter(fish -> fish.color == scan.color && fish.type == scan.type).findFirst().isPresent();
    }

    private boolean isFishScannedByPlayerDrone(Scan scan, Player player) {
        boolean buffered = player.drones.stream()
            .flatMap(d -> d.scans.stream())
            .anyMatch(scanned -> scanned.equals(scan));
        return buffered;
    }

    private boolean isTypeComboStillPossible(Player p, FishType type) {
        if (playerScannedAllFishOfType(p, type)) {
            return false;
        }
        for (int color = 0; color < COLORS_PER_FISH; color++) {
            Scan scan = new Scan(type, color);
            if (hasFishEscaped(scan) && !isFishScannedByPlayerDrone(scan, p) && !playerScanned(p, scan)) {
                return false;
            }
        }
        return true;
    }

    private boolean isColorComboStillPossible(Player p, int color) {
        if (playerScannedAllFishOfColor(p, color)) {
            return false;
        }
        for (FishType type : FishType.values()) {
            Scan scan = new Scan(type, color);
            if (hasFishEscaped(scan) && !isFishScannedByPlayerDrone(scan, p) && !playerScanned(p, scan)) {
                return false;
            }
        }
        return true;
    }

    private int computeMaxPlayerScore(Player p) {
        int total = computePlayerScore(p);
        Player p2 = players.get(1 - p.getIndex());

        for (int color = 0; color < COLORS_PER_FISH; color++) {
            for (FishType type : FishType.values()) {
                Scan scan = new Scan(type, color);
                if (!playerScanned(p, scan)) {
                    if (isFishScannedByPlayerDrone(scan, p) || !hasFishEscaped(scan)) {
                        total += type.ordinal() + 1;
                        if (firstToScan.getOrDefault(scan, -1).equals(-1)) {
                            total += type.ordinal() + 1;
                        }
                    }
                }
            }
        }

        for (FishType type : FishType.values()) {
            if (isTypeComboStillPossible(p, type)) {
                total += COLORS_PER_FISH;
                if (!Objects.equal(firstToScanAllFishOfType.get(type), p2.getIndex())) {
                    total += COLORS_PER_FISH;
                }
            }
        }

        for (int color = 0; color < COLORS_PER_FISH; color++) {
            if (isColorComboStillPossible(p, color)) {
                total += FishType.values().length;
                if (!Objects.equal(firstToScanAllFishOfColor.get(color), p2.getIndex())) {
                    total += FishType.values().length;
                }
            }
        }

        return total;
    }

    private boolean isGameOver() {
        if (bothPlayersHaveScannedAllRemainingFish()) {
            return true;
        }
        return this.gameTurn >= 200 || computeMaxPlayerScore(players.get(0)) < players.get(1).points
            || computeMaxPlayerScore(players.get(1)) < players.get(0).points;
    }

    private boolean bothPlayersHaveScannedAllRemainingFish() {
        for (Player player : players) {
            if (!hasScannedAllRemainingFish(player)) {
                return false;
            }
        }
        return true;
    }

    private boolean playerScannedAllFishOfColor(Player player, int color) {
        for (FishType type : FishType.values()) {
            if (!playerScanned(player, new Scan(type, color))) {
                return false;
            }
        }
        return true;
    }

    private int computePlayerScore(Player p) {
        int total = 0;
        for (Scan scan : p.scans) {
            total += scan.type.ordinal() + 1;
            if (Objects.equal(firstToScan.get(scan), p.getIndex())) {
                total += scan.type.ordinal() + 1;
            }
        }

        for (FishType type : FishType.values()) {
            if (playerScannedAllFishOfType(p, type)) {
                total += COLORS_PER_FISH;
            }
            if (Objects.equal(firstToScanAllFishOfType.get(type), p.getIndex())) {
                total += COLORS_PER_FISH;
            }
        }

        for (int color = 0; color < COLORS_PER_FISH; ++color) {
            if (playerScannedAllFishOfColor(p, color)) {
                total += FishType.values().length;
            }
            if (Objects.equal(firstToScanAllFishOfColor.get(color), p.getIndex())) {
                total += FishType.values().length;
            }
        }
        return total;
    }

    private boolean playerScannedAllFishOfType(Player player, FishType type) {
        for (int color = 0; color < COLORS_PER_FISH; ++color) {
            if (!playerScanned(player, new Scan(type, color))) {
                return false;
            }
        }
        return true;
    }

    private void computeScoreOnEnd() {
        for (Player player : players) {
            for (Drone drone : player.drones) {
                applyScansForReport(player, drone);
            }
            detectFirstToComboBonuses(player);
        }

        persistFirstToScanBonuses();

        players.stream().forEach(p -> {
            if (p.isActive()) {
                int score = computePlayerScore(p);
                p.setScore(score);
                p.points = score;
            } else {
                p.setScore(-1);
            }
        });
    }

    public void onEnd() {
        players.stream().forEach(p -> {
            if (p.isActive()) {
                int score = computePlayerScore(p);
                p.setScore(score);
                p.points = score;
            } else {
                p.setScore(-1);
            }
        });
        endScreenModule.setScores(
            players.stream()
                .mapToInt(p -> p.getScore())
                .toArray()
        );

        for (Player p : players) {
            for (Drone d : p.drones) {
                maxTurnsSpentWithScan[p.getIndex()] = Math.max(maxTurnsSpentWithScan[p.getIndex()], d.maxTurnsSpentWithScan);
                maxY[p.getIndex()] = Math.max(maxY[p.getIndex()], d.maxY);
            }

            int idx = 0;
            for (Integer saveCount : p.countFishSaved) {
                gameManager.putMetadata("fishSavedPerSave_" + p.getIndex() + "_" + idx, String.valueOf(saveCount));
                idx++;
            }
            idx = 0;
            for (Integer turn : turnSavedFish[p.getIndex()]) {
                gameManager.putMetadata("turnFishWasSaved_" + p.getIndex() + "_" + idx, String.valueOf(turn));
                idx++;
            }
        }
        gameManager.putMetadata("fishScanned", String.valueOf(fishScanned));
        gameManager.putMetadata("dronesEaten", String.valueOf(dronesEaten));
        gameManager.putMetadata("timesAggroed_0", String.valueOf(timesAggroed[0]));
        gameManager.putMetadata("timesAggroed_1", String.valueOf(timesAggroed[1]));
        gameManager.putMetadata("chasedFishCount_0", String.valueOf(chasedFishCount[0]));
        gameManager.putMetadata("chasedFishCount_1", String.valueOf(chasedFishCount[1]));
        gameManager.putMetadata("maxTurnsSpentWithScan_0", String.valueOf(maxTurnsSpentWithScan[0]));
        gameManager.putMetadata("maxTurnsSpentWithScan_1", String.valueOf(maxTurnsSpentWithScan[1]));
        gameManager.putMetadata("maxY_0", String.valueOf(maxY[0]));
        gameManager.putMetadata("maxY_1", String.valueOf(maxY[1]));

        gameManager.putMetadata("gameLength", String.valueOf(gameTurn - 1));
    }

    public List<EventData> getViewerEvents() {
        return viewerEvents;
    }

    public static String getExpected(String playerOutput) {
        String attempt = playerOutput.toUpperCase();
        if (attempt.startsWith("MOVE")) {
            return "MOVE <x> <y> <light (1|0)>";
        }
        if (attempt.startsWith("WAIT")) {
            return "WAIT <light (1|0)>";
        }
        return "MOVE |"
            + " WAIT";
    }

    /**
     * Credit for this collision code goes to the creators of <a href="https://www.codingame.com/contests/mean-max">Mean Max</a>
     */
    Collision getCollision(Drone drone, Ugly ugly) {
        // Check instant collision
        if (ugly.getPos().inRange(drone.getPos(), DRONE_HIT_RANGE + UGLY_EAT_RANGE)) {
            return new Collision(0.0, ugly, drone);
        }

        // Both units are motionless
        if (drone.getSpeed().isZero() && ugly.getSpeed().isZero()) {
            return Collision.NONE;
        }

        // Change referencial
        double x = ugly.getPos().getX();
        double y = ugly.getPos().getY();
        double ux = drone.getPos().getX();
        double uy = drone.getPos().getY();

        double x2 = x - ux;
        double y2 = y - uy;
        double r2 = UGLY_EAT_RANGE + DRONE_HIT_RANGE;
        double vx2 = ugly.getSpeed().getX() - drone.getSpeed().getX();
        double vy2 = ugly.getSpeed().getY() - drone.getSpeed().getY();

        // Resolving: sqrt((x + t*vx)^2 + (y + t*vy)^2) = radius <=> t^2*(vx^2 + vy^2) + t*2*(x*vx + y*vy) + x^2 + y^2 - radius^2 = 0
        // at^2 + bt + c = 0;
        // a = vx^2 + vy^2
        // b = 2*(x*vx + y*vy)
        // c = x^2 + y^2 - radius^2 

        double a = vx2 * vx2 + vy2 * vy2;

        if (a <= 0.0) {
            return Collision.NONE;
        }

        double b = 2.0 * (x2 * vx2 + y2 * vy2);
        double c = x2 * x2 + y2 * y2 - r2 * r2;
        double delta = b * b - 4.0 * a * c;

        if (delta < 0.0) {
            return Collision.NONE;
        }

        double t = (-b - Math.sqrt(delta)) / (2.0 * a);

        if (t <= 0.0) {
            return Collision.NONE;
        }

        if (t > 1.0) {
            return Collision.NONE;
        }
        return new Collision(t, ugly, drone);
    }

    public boolean hasFirstToScanBonus(Player player, Scan scan) {
        return firstToScan.getOrDefault(scan, -1).equals(player.getIndex());
    }

    public boolean hasFirstToScanAllFishOfType(Player player, FishType type) {
        return firstToScanAllFishOfType.getOrDefault(type, -1).equals(player.getIndex());
    }

    public boolean hasFirstToScanAllFishOfColor(Player player, int col) {
        return firstToScanAllFishOfColor.getOrDefault(col, -1).equals(player.getIndex());
    }

}
