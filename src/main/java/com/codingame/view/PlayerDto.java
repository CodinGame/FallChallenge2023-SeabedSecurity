package com.codingame.view;

import com.codingame.game.Player;

public class PlayerDto {
    String message;

    public PlayerDto(Player player) {
        message = player.getMessage();
    }
}
