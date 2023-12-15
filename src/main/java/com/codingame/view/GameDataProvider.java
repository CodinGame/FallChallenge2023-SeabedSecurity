package com.codingame.view;

import java.util.stream.Collectors;

import com.codingame.game.Game;
import com.codingame.game.Player;
import com.codingame.gameengine.core.MultiplayerGameManager;
import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class GameDataProvider {
    @Inject private Game game;
    @Inject private MultiplayerGameManager<Player> gameManager;

    public GlobalViewData getGlobalData() {
        GlobalViewData data = new GlobalViewData();
        data.width = 16000;
        data.height = 900;

        return data;
    }

    public FrameViewData getCurrentFrameData() {
        FrameViewData data = new FrameViewData();

        data.players = gameManager.getPlayers().stream()
            .map(PlayerDto::new)
            .collect(Collectors.toList());

        data.events = game.getViewerEvents();

        return data;
    }

}
