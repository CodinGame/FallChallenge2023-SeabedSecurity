package com.codingame.game.action;

import java.util.regex.Pattern;

public enum ActionType {

    MOVE(
        "^MOVE (?<x>-?\\d+) (?<y>-?\\d+) (?<light>1|0)(?:\\s+(?<message>.+))?"
    ),
    WAIT(
        "^WAIT (?<light>1|0)(?:\\s+(?<message>.+))?"
    );

    private Pattern pattern;

    ActionType(String pattern) {
        this.pattern = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
    }

    public Pattern getPattern() {
        return pattern;
    }

}
