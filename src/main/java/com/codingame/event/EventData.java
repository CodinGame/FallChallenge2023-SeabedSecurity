package com.codingame.event;

import java.util.ArrayList;
import java.util.List;

import com.codingame.game.Vector;

public class EventData {
    public static final int BUILD = 0;
    public static final int MOVE = 1;

    public int type;
    public List<AnimationData> animData;
    
    public EventData() {
        animData = new ArrayList<>();
    }

}
