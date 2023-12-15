package com.codingame.view;

import com.codingame.game.Game;
import com.codingame.game.Serializer;
import com.codingame.gameengine.core.AbstractPlayer;
import com.codingame.gameengine.core.GameManager;
import com.codingame.gameengine.core.Module;
import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class ViewModule implements Module {

    private GameManager<AbstractPlayer> gameManager;
//    private GameDataProvider gameDataProvider;
    private Game game;

    @Inject
    ViewModule(GameManager<AbstractPlayer> gameManager, Game game) {
        this.gameManager = gameManager;
        this.game = game;
        gameManager.registerModule(this);
    }

    @Override
    public final void onGameInit() {
        sendGlobalData();
        sendFrameData();
    }

    private void sendFrameData() {
        gameManager.setViewData("graphics", Serializer.serializeFrameData(game));
    }

    private void sendGlobalData() {
        gameManager.setViewGlobalData("graphics", Serializer.serializeGlobalData(game));

    }

    @Override
    public final void onAfterGameTurn() {
        sendFrameData();
    }

    @Override
    public final void onAfterOnEnd() {
    }

}
