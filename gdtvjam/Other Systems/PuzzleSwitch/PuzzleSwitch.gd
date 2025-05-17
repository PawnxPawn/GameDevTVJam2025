extends Area2D

@onready var sprite: AnimatedSprite2D = %Sprite

func _on_body_entered(body:Node2D) -> void:
    if (body.is_in_group("block") || body.is_in_group("player")):
        sprite.play("pushed")
        #only allows the block to trigger the actual switch
        if (body.is_in_group("block")):
            body.linear_velocity = Vector2.ZERO
            body.angular_velocity = 0
            SignalBus.puzzle_switch_on.emit()

func _on_body_exited(body:Node2D) -> void:
    if (body.is_in_group("block") || body.is_in_group("player")):
        sprite.play("normal")
        #only allows moving the block away from the puzzle switch to trigger the switch being off
        if (body.is_in_group("block")):
            SignalBus.puzzle_switch_off.emit()
        #if its the player leaving the button should still be pushed.
        else:
            sprite.play("pushed")