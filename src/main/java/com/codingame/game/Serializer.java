package com.codingame.game;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Serializer {
    public static final String MAIN_SEPARATOR = ";";

    static public <T> String serialize(List<T> list) {
        return list.stream().map(String::valueOf).collect(Collectors.joining(" "));
    }

    static public String serialize(Vector coord) {
        return coord.getX() + " " + coord.getY();
    }

    static public String join(Object... args) {
        return Stream.of(args)
            .map(String::valueOf)
            .collect(Collectors.joining(" "));
    }

    public static String serializeGlobalData(Game game) {
        List<Object> lines = new ArrayList<>();
        lines.add(Game.FISH_WILL_FLEE ? 1 : 0);
        lines.add(Game.WIDTH);
        lines.add(Game.HEIGHT);
        lines.add(Game.DRONES_PER_PLAYER);
        lines.add(game.fishes.size());

        for (Fish fish : game.fishes) {
            lines.add(join(fish.id, fish.color, fish.type.ordinal()));
        }
        lines.add(game.uglies.size());
        for (Ugly ugly : game.uglies) {
            lines.add(join(ugly.id));
        }
        lines.add(Game.SIMPLE_SCANS ? 1 : 0);

        return lines.stream()
            .map(String::valueOf)
            .collect(Collectors.joining(MAIN_SEPARATOR));
    }

    public static String serializeFrameData(Game game) {
        List<Object> lines = new ArrayList<>();
        lines.add(game.fishes.size());
        for (Fish fish : game.fishes) {
            lines.add(join(fish.id, fish.getPos().toIntString(), fish.getSpeed().toIntString(), fish.isFleeing ? 1 : 0));
        }

        for (Ugly ugly : game.uglies) {
            lines.add(join(ugly.id, ugly.getPos().toIntString(), ugly.getSpeed().toIntString(), ugly.foundTarget ? 1 : 0));
        }
        for (Player player : game.players) {
            lines.add(player.points);
            for (Drone drone : player.drones) {
                lines.add(
                    join(
                        drone.id,
                        drone.pos.toIntString(),
                        drone.move == null ? "x x" : drone.move.toIntString(),
                        drone.battery,
                        drone.isLightOn() ? 1 : 0,
                        drone.dead ? 1 : 0,
                        (int) (drone.dieAt * 100),
                        drone.didReport ? 1 : 0,
                        drone.message
                    )
                );
                lines.add(drone.fishesScannedThisTurn.size());
                for (int id : drone.fishesScannedThisTurn) {
                    lines.add(id);
                }

                lines.add(drone.scans.size());
                for (Scan scan : drone.scans) {
                    lines.add(
                        join(
                            scan.color, scan.type.ordinal()
                        )
                    );
                }
            }
            lines.add(getScanSummary(player, game));
        }
        return lines.stream()
            .map(String::valueOf)
            .collect(Collectors.joining(MAIN_SEPARATOR));
    }

    private static final int SCAN_CODE_UNSCANNED = 0;
    private static final int SCAN_CODE_BUFFERED = 1;
    private static final int SCAN_CODE_SAVED = 2;
    private static final int SCAN_CODE_LOST = 3;

    public static String getScanSummary(Player player, Game game) {
        List<Object> summary = new ArrayList<>(19);
        for (int col = 0; col < Game.COLORS_PER_FISH; col++) {
            for (FishType type : FishType.values()) {
                Scan scan = new Scan(type, col);
                summary.add(getScanSummaryCode(player, scan, game));
                summary.add(game.hasFirstToScanBonus(player, scan) ? "@" : "_");
            }
            summary.add(game.hasFirstToScanAllFishOfColor(player, col) ? "@" : "_");
        }

        for (FishType type : FishType.values()) {
            summary.add(game.hasFirstToScanAllFishOfType(player, type) ? "@" : "_");
        }

        return summary.stream()
            .map(String::valueOf)
            .collect(Collectors.joining(" "));
    }

    private static int getScanSummaryCode(Player player, Scan scan, Game game) {
        boolean saved = game.playerScanned(player, scan);
        if (saved) {
            return SCAN_CODE_SAVED;
        }

        boolean buffered = player.drones.stream()
            .flatMap(d -> d.scans.stream())
            .anyMatch(scanned -> scanned.equals(scan));
        if (buffered) {
            return SCAN_CODE_BUFFERED;
        }

        Optional<Fish> optFish = game.fishes.stream().filter(fish -> new Scan(fish).equals(scan)).findFirst();
        if (!optFish.isPresent()) {
            return SCAN_CODE_LOST;
        }

        return SCAN_CODE_UNSCANNED;
    }

    public static List<String> serializeGlobalInfoFor(Player player, Game game) {
        List<Object> lines = new ArrayList<>();

        // Preliminary scan (all possible fish)
        lines.add(game.fishes.size() + game.uglies.size());
        game.fishes
            .forEach(fish -> {
                lines.add(
                    Serializer.join(fish.id, fish.color, fish.type.ordinal())
                );
            });
        game.uglies.forEach(ugly -> {
            lines.add(
                Serializer.join(ugly.id, -1, -1)
            );
        });

        return lines.stream()
            .map(String::valueOf)
            .collect(Collectors.toList());
    }

    public static List<String> serializeFrameInfoFor(Player player, Game game) {
        List<String> lines = new ArrayList<>();

        // Player scores

        List<Player> players = game.players;
        List<Ugly> uglies = game.uglies;
        List<Fish> fishes = game.fishes;

        Player other = players
            .stream()
            .filter(p -> p != player)
            .findFirst().get();

        lines.add(String.valueOf(player.points));
        lines.add(String.valueOf(other.points));

        Stream.of(player, other)
            .forEach(p -> {
                lines.add(String.valueOf(p.scans.size()));
                for (Scan scan : p.scans) {
                    lines.add(scan.toInputString());
                }
            });

        List<Drone> allDrones = Stream.of(player.drones.stream(), other.drones.stream())
            .flatMap(Function.identity())
            .collect(Collectors.toList());

        // Drone states
        lines.add(String.valueOf(player.drones.size()));
        player.drones.forEach(drone -> {
            lines.add(
                Serializer.join(
                    drone.id,
                    drone.getPos().toIntString(),
                    drone.dead ? 1 : 0,
                    drone.battery
                )
            );
        });
        lines.add(String.valueOf(other.drones.size()));
        other.drones.forEach(drone -> {
            lines.add(
                Serializer.join(
                    drone.id,
                    drone.getPos().toIntString(),
                    drone.dead ? 1 : 0,
                    drone.battery
                )
            );
        });

        // Drone scans
        lines.add(
            String.valueOf(allDrones.stream().mapToInt(drone -> drone.scans.size()).sum())
        );

        allDrones.forEach(drone -> {
            drone.scans.forEach(scan -> {
                lines.add(
                    Serializer.join(
                        drone.id,
                        scan.fishId
                    )
                );
            });
        });

        List<Ugly> visibleUglies = uglies.stream()
            .filter(
                ugly -> player.drones.stream()
                    .anyMatch(
                        drone -> ugly.pos.inRange(drone.pos, Game.UGLY_EAT_RANGE + (drone.isLightOn() ? Game.LIGHT_SCAN_RANGE : Game.DARK_SCAN_RANGE))
                    )
            )
            .collect(Collectors.toList());

        // Visible fish
        lines.add(String.valueOf(player.visibleFishes.size() + visibleUglies.size()));

        player.visibleFishes.stream()
            .forEach(fish -> {
                lines.add(
                    Serializer.join(fish.id, fish.getPos().toIntString(), fish.speed.toIntString())
                );
            });
        visibleUglies.forEach(ugly -> {
            lines.add(
                Serializer.join(ugly.id, ugly.getPos().toIntString(), ugly.speed.toIntString())
            );
        });

        // Radar blips
        lines.add(String.valueOf(Game.DRONES_PER_PLAYER * (fishes.size() + uglies.size())));

        for (Drone drone : player.drones) {
            fishes.stream()
                .forEach(fish -> {
                    String direction = "";
                    if (fish.getY() > drone.getY()) {
                        direction += "B";
                    } else {
                        direction += "T";
                    }
                    if (fish.getX() > drone.getX()) {
                        direction += "R";
                    } else {
                        direction += "L";
                    }

                    lines.add(Serializer.join(drone.id, fish.id, direction));
                });
            uglies.stream()
                .forEach(ugly -> {
                    String direction = "";
                    if (ugly.getY() > drone.getY()) {
                        direction += "B";
                    } else {
                        direction += "T";
                    }
                    if (ugly.getX() > drone.getX()) {
                        direction += "R";
                    } else {
                        direction += "L";
                    }

                    lines.add(Serializer.join(drone.id, ugly.id, direction));
                });
        }

        return lines.stream()
            .collect(Collectors.toList());
    }

}
