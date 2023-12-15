package com.codingame.game;

public class Ugly implements Entity {
    Vector pos;
    Vector speed;
    Vector target;
    int id;
    boolean foundTarget;

    public Ugly(double x, double y, int id) {
        this.id = id;
        this.pos = new Vector(x, y);
        this.speed = Vector.ZERO;
        this.target = null;
    }

    @Override
    public Vector getPos() {
        return pos;
    }

    @Override
    public Vector getSpeed() {
        return speed;
    }

    public double getX() {
        return pos.getX();
    }

    public double getY() {
        return pos.getY();
    }
}
