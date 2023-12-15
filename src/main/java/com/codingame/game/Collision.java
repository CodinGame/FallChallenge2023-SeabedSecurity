package com.codingame.game;

public class Collision {
    final static Collision NONE = new Collision(-1);
    
    double t;
    Entity a;
    Entity b;

    Collision(double t) {
        this(t, null, null);
    }

    Collision(double t, Entity a) {
        this(t, a, null);
    }

    Collision(double t, Entity a, Entity b) {
        this.t = t;
        this.a = a;
        this.b = b;
    }

    public boolean happened() {
        return t >= 0;
    }

}
