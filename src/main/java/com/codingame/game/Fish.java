package com.codingame.game;

public class Fish implements Entity {
    FishType type;
    Vector pos;
    int color;
    double startY;
    Vector speed;
    int id;
    int lowY, highY;
    boolean isFleeing;
    /* stats */
    Integer fleeingFromPlayer;

    public Fish(double x, double y, FishType type, int color, int id, int lowY, int highY) {
        this.id = id;
        this.pos = new Vector(x, y);
        this.type = type;
        this.color = color;
        this.lowY = lowY;
        this.highY = highY;
        this.speed = Vector.ZERO;
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
