package com.codingame.game;

import java.util.List;

public class Closest<T extends Entity> {

    List<T> list;
    double distance;

    public Closest(List<T> list, double distance) {
        this.list = list;
        this.distance = distance;
    }

    public T get() {
        if (hasOne()) {
            return list.get(0);
        }
        return null;

    }

    public boolean hasOne() {
        return list.size() == 1;
    }

    public Vector getPos() {
        if (!hasOne()) {
            return null;
        }

        return list.get(0).getPos();
    }

    public Vector getMeanPos() {
        if (hasOne()) {
            return getPos();
        }
        double x = 0;
        double y = 0;

        for (Entity entity : list) {
            x += entity.getPos().getX();
            y += entity.getPos().getY();
        }
        return new Vector(x / list.size(), y / list.size());
    }

}
