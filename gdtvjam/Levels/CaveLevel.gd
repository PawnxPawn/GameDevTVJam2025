extends Node

@export var switches_needed: int
var switches_pressed: int = 0

signal puzzle_completed


func _ready() -> void:
    SignalBus.puzzle_switch_on.connect(_on_puzzle_switch_pressed)
    SignalBus.puzzle_switch_off.connect(_on_puzzle_switch_released)
      


func _on_puzzle_switch_pressed() -> void:
    switches_pressed += 1
    if (switches_needed == switches_pressed):
        puzzle_completed.emit()

func _on_puzzle_switch_released() -> void:
    switches_pressed -= 1


