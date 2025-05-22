extends Node

enum character_size
{
    BIG = 2,
    NORMAL = 1,
    SMALL = 0
}

var is_credits_called = false

var current_player_size: character_size = character_size.BIG