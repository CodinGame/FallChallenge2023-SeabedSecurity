package com.codingame.game;

public class Vector {
    public static final Vector ZERO = new Vector(0, 0);
    private final double x, y;

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        long temp;
        temp = Double.doubleToLongBits(x);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(y);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        Vector other = (Vector) obj;
        if (Double.doubleToLongBits(x) != Double.doubleToLongBits(other.x)) return false;
        if (Double.doubleToLongBits(y) != Double.doubleToLongBits(other.y)) return false;
        return true;
    }

    public Vector(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public Vector(Vector a, Vector b) {
        this.x = b.x - a.x;
        this.y = b.y - a.y;
    }

    public Vector(double angle) {
        this.x = Math.cos(angle);
        this.y = Math.sin(angle);
    }

    public Vector rotate(double angle) {
        double nx = (x * Math.cos(angle)) - (y * Math.sin(angle));
        double ny = (x * Math.sin(angle)) + (y * Math.cos(angle));

        return new Vector(nx, ny);
    };

    public boolean equals(Vector v) {
        return v.getX() == x && v.getY() == y;
    }

    public Vector round() {
        return new Vector((int) Math.round(this.x), (int) Math.round(this.y));
    }

    public Vector truncate() {
        return new Vector((int) this.x, (int) this.y);
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double distance(Vector v) {
        return Math.sqrt((v.x - x) * (v.x - x) + (v.y - y) * (v.y - y));
    }

    public boolean inRange(Vector v, double range) {
        return (v.x - x) * (v.x - x) + (v.y - y) * (v.y - y) <= range * range;
    }

    public Vector add(Vector v) {
        return new Vector(x + v.x, y + v.y);
    }

    public Vector mult(double factor) {
        return new Vector(x * factor, y * factor);
    }

    public Vector sub(Vector v) {
        return new Vector(this.x - v.x, this.y - v.y);
    }

    public double length() {
        return Math.sqrt(x * x + y * y);
    }

    public double lengthSquared() {
        return x * x + y * y;
    }

    public Vector normalize() {
        double length = length();
        if (length == 0)
            return new Vector(0, 0);
        return new Vector(x / length, y / length);
    }

    public double dot(Vector v) {
        return x * v.x + y * v.y;
    }

    public double angle() {
        return Math.atan2(y, x);
    }

    @Override
    public String toString() {
        return "[" + x + ", " + y + "]";
    }

    public String toIntString() {
        return (int) x + " " + (int) y;
    }

    public Vector project(Vector force) {
        Vector normalize = this.normalize();
        return normalize.mult(normalize.dot(force));
    }

    public final Vector cross(double s) {
        return new Vector(-s * y, s * x);
    }

    public Vector hsymmetric(double center) {
        return new Vector(2 * center - this.x, this.y);
    }

    public Vector vsymmetric(double center) {
        return new Vector(this.x, 2 * center - this.y);
    }

    public Vector vsymmetric() {
        return new Vector(this.x, -this.y);
    }

    public Vector hsymmetric() {
        return new Vector(-this.x, this.y);
    }

    public Vector symmetric() {
        return symmetric(new Vector(0, 0));
    }

    public Vector symmetric(Vector center) {
        return new Vector(center.x * 2 - this.x, center.y * 2 - this.y);
    }

    public boolean withinBounds(double minx, double miny, double maxx, double maxy) {
        return x >= minx && x < maxx && y >= miny && y < maxy;
    }

    public boolean isZero() {
        return x == 0 && y == 0;
    }

    public Vector symmetricTruncate(Vector origin) {
        return sub(origin).truncate().add(origin);
    }

    public Vector symmetricTruncate() {
        return new Vector(
            (x < Game.CENTER.x) ? Math.floor(x) : Math.ceil(x),
            (y < Game.CENTER.y) ? Math.floor(y) : Math.ceil(y)
        );
    }

    public double euclideanTo(double x, double y) {
        return Math.sqrt(sqrEuclideanTo(x, y));
    }

    public double sqrEuclideanTo(double x, double y) {
        return Math.pow(x - this.x, 2) + Math.pow(y - this.y, 2);
    }

    public double sqrEuclideanTo(Vector other) {
        return sqrEuclideanTo(other.x, other.y);
    }

    public Vector add(double x, double y) {
        return new Vector(this.x + x, this.y + y);
    }

    public double manhattanTo(Vector other) {
        return manhattanTo(other.x, other.y);
    }

    public double chebyshevTo(double x, double y) {
        return Math.max(Math.abs(x - this.x), Math.abs(y - this.y));
    }

    public double manhattanTo(double x, double y) {
        return Math.abs(x - this.x) + Math.abs(y - this.y);
    }

    public double euclideanTo(Vector pos) {
        return euclideanTo(pos.x, pos.y);
    }

    public Vector epsilonRound() {
        return new Vector(
            Math.round(x * 10000000.0) / 10000000.0,
            Math.round(y * 10000000.0) / 10000000.0
        );
    }
}
