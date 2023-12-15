package com.codingame.game;

import com.codingame.gameengine.core.AbstractPlayer.TimeoutException;
import com.codingame.gameengine.core.AbstractReferee;
import com.codingame.gameengine.core.MultiplayerGameManager;
import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class Referee extends AbstractReferee {

    @Inject private MultiplayerGameManager<Player> gameManager;
    @Inject private CommandManager commandManager;
    @Inject private Game game;

    @Override
    public void init() {
        try {

            int leagueLevel = gameManager.getLeagueLevel();
            if (leagueLevel == 1) {
                Game.ENABLE_UGLIES = false;
                Game.FISH_WILL_FLEE = false;
                Game.DRONES_PER_PLAYER = 1;
                Game.SIMPLE_SCANS = true;
                Game.FISH_WILL_MOVE = true;
            } else if (leagueLevel == 2) {
                Game.ENABLE_UGLIES = false;
                Game.FISH_WILL_FLEE = false;
                Game.DRONES_PER_PLAYER = 1;
            } else if (leagueLevel == 3) {
                Game.ENABLE_UGLIES = false;
            } else {

            }

            game.init();
            sendGlobalInfo();

            gameManager.setFrameDuration(500);
            gameManager.setMaxTurns(Game.MAX_TURNS);
            gameManager.setTurnMaxTime(50);
            gameManager.setFirstTurnMaxTime(1000);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Referee failed to initialize");
            abort();
        }
    }

    private void abort() {
        gameManager.endGame();

    }

    private void sendGlobalInfo() {
        // Give input to players
        for (Player player : gameManager.getActivePlayers()) {
            for (String line : Serializer.serializeGlobalInfoFor(player, game)) {
                player.sendInputLine(line);
            }
        }
    }

    @Override
    public void gameTurn(int turn) {
        game.resetGameTurnData();

        // Give input to players
        for (Player player : gameManager.getActivePlayers()) {
            for (String line : Serializer.serializeFrameInfoFor(player, game)) {
                player.sendInputLine(line);
            }
            player.execute();
        }
        // Get output from players
        handlePlayerCommands();

        game.performGameUpdate(turn);

        if (gameManager.getActivePlayers().size() < 2) {
            abort();
        }
    }

    private void handlePlayerCommands() {

        for (Player player : gameManager.getActivePlayers()) {
            try {
                commandManager.parseCommands(player, player.getOutputs());
            } catch (TimeoutException e) {
                player.deactivate("Timeout!");
                gameManager.addToGameSummary(player.getNicknameToken() + " has not provided " + player.getExpectedOutputLines() + " lines in time");
            }
        }

    }

    @Override
    public void onEnd() {
        game.onEnd();
    }
}
