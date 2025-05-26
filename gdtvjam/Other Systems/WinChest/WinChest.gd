extends StaticBody2D

@export var win_scene: PackedScene
@export var win_dialouge: DialogueResource

@onready var collider: CollisionShape2D = %Collider

@onready var chest_sprite: Sprite2D = %Chest
@onready var chest_interactable: Interactable = %ChestInteractable
@onready var chest_interact: CollisionShape2D = %ChestInteract

@onready var amulet_sprite: Sprite2D = %Amulet
@onready var amulet_interactable: Interactable = %AmuletInteractable
@onready var amulet_interact: CollisionShape2D = %AmuletInteract


func _ready() -> void:
    chest_interactable.interact = _chest_interact
    amulet_interactable.interact = _amulet_interact

func _chest_interact() -> void:
    DialogueManager.show_example_dialogue_balloon(win_dialouge, "Chest")
    chest_sprite.visible = false
    amulet_sprite.visible = true
    chest_interact.disabled = true
    amulet_interact.disabled = false

func _amulet_interact() -> void:
    DialogueManager.show_example_dialogue_balloon(win_dialouge, "Amulet")
    get_tree().change_scene_to_file("uid://d3a5nng4xkp3l")