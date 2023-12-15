package com.codingame.game;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.codingame.gameengine.core.AbstractMultiplayerPlayer;

public class Player extends AbstractMultiplayerPlayer {

    String message;
    List<Drone> drones;
    Set<Scan> scans;
    Set<Fish> visibleFishes;

    List<Integer> countFishSaved;
    int points = 0;

    public Player() {
        drones = new ArrayList<>();
        visibleFishes = new LinkedHashSet<>();
        scans = new LinkedHashSet<>();
        countFishSaved = new ArrayList<Integer>();
    }

    @Override
    public int getExpectedOutputLines() {
        return drones.size();
    }

    public String getMessage() {
        return message;
    }

    public void reset() {
        message = null;
        drones.forEach(d -> {
            d.move = null;
            d.fishesScannedThisTurn.clear();
            d.didReport = false;
            d.message = "";
        });
    }

}
