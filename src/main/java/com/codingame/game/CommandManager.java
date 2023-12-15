package com.codingame.game;

import java.util.List;
import java.util.regex.Matcher;

import com.codingame.game.action.Action;
import com.codingame.game.action.ActionType;
import com.codingame.game.action.MoveAction;
import com.codingame.game.action.WaitAction;
import com.codingame.game.exception.InvalidInputException;
import com.codingame.gameengine.core.GameManager;
import com.codingame.gameengine.core.MultiplayerGameManager;
import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class CommandManager {

    @Inject private MultiplayerGameManager<Player> gameManager;

    public void parseCommands(Player player, List<String> lines) {

        try {
            Matcher match;
            int droneIdx = 0;
            for (String command : lines) {
                boolean found = false;
                try {
                    for (ActionType actionType : ActionType.values()) {
                        match = actionType.getPattern().matcher(command.trim());
                        if (match.matches()) {
                            Action action;
                            switch (actionType) {
                            case MOVE: {
                                int x = Integer.parseInt(match.group("x"));
                                int y = Integer.parseInt(match.group("y"));
                                int light = Integer.parseInt(match.group("light"));
                                action = new MoveAction(x, y, light);

                                Drone drone = player.drones.get(droneIdx);
                                drone.move = new Vector(x, y);
                                drone.lightSwitch = light == 1;
                                matchMessage(drone, match);
                                break;
                            }
                            case WAIT: {
                                int light = Integer.parseInt(match.group("light"));
                                action = new WaitAction(light);
                                Drone drone = player.drones.get(droneIdx);
                                drone.lightSwitch = light == 1;
                                matchMessage(drone, match);
                                break;
                            }
                            default:
                                // Impossibru
                                action = null;
                                break;
                            }
                            //                            player.addAction(action);

                            found = true;
                            break;
                        }
                    }
                } catch (Exception e) {
                    throw new InvalidInputException(Game.getExpected(command), e.toString());
                }

                if (!found) {
                    throw new InvalidInputException(Game.getExpected(command), command);
                }
                droneIdx++;
            }

        } catch (InvalidInputException e) {
            deactivatePlayer(player, e.getMessage());
            gameManager.addToGameSummary(e.getMessage());
            gameManager.addToGameSummary(GameManager.formatErrorMessage(player.getNicknameToken() + ": disqualified!"));
        }
    }

    public void deactivatePlayer(Player player, String message) {
        player.deactivate(escapeHTMLEntities(message));
        player.setScore(-1);
    }

    private void matchMessage(Drone drone, Matcher match) {
        String message = match.group("message");
        if (message != null) {
            if (Game.ALLOW_EMOJI) {
                drone.setMessage(message);
            } else {
                String characterFilter = "[^\\p{L}\\p{M}\\p{N}\\p{P}\\p{Z}\\p{Cf}\\p{Cs}\\s]";
                String messageWithoutEmojis = message.replaceAll(characterFilter, "");
                drone.setMessage(messageWithoutEmojis);
            }
        }
    }

    private String escapeHTMLEntities(String message) {
        return message
            .replace("&lt;", "<")
            .replace("&gt;", ">");
    }
}
