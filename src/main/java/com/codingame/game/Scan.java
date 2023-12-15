package com.codingame.game;

import java.util.Objects;

public class Scan {
    int fishId;
    FishType type;
    int color;

    public Scan(Fish fish) {
        this.fishId = fish.id;
        this.type = fish.type;
        this.color = fish.color;
    }

    public Scan(FishType type, int color) {
        this.type = type;
        this.color = color;
    }

    @Override
    public int hashCode() {
        return Objects.hash(color, type);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        Scan other = (Scan) obj;
        return color == other.color && type == other.type;
    }

    public String toInputString() {
        return Serializer.join(fishId);
    }

    @Override
    public String toString() {
        return String.format(
            "%s (%d) %s (%d)",
            Game.COLORS[color],
            color,
            type.name().toLowerCase(),
            type.ordinal()
        );

    }

}
