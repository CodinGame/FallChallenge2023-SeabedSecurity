package com.codingame.game.action;

public class WaitAction extends Action {

    private String message;
    int light;

    public WaitAction(int light) {
        super(ActionType.WAIT);
        this.light = light;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
