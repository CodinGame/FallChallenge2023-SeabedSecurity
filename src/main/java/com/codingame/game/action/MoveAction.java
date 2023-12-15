package com.codingame.game.action;

public class MoveAction extends Action {

    private String message;
    int x, y, light;

    public MoveAction(int x, int y, int light) {
        super(ActionType.MOVE);
        this.x = x;
        this.y = y;
        this.light = light;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
