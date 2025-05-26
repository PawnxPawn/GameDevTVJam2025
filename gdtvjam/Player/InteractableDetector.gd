extends Area2D

@onready var interact_label: Label = %InteractLabel

var pulling: bool = false
var object_close: bool = false

var interaction_text: String
var not_block_interactable: Interactable

func _ready() -> void:
	interact_label.text = ""

func _process(_delta: float) -> void:
	if (not_block_interactable != null):
		interact_label.text = "Press E to {interact}".format({"interact": not_block_interactable.interaction_name})

func _input(_event: InputEvent) -> void:
	if (object_close && Input.is_action_just_pressed("push_pull") && not_block_interactable == null):
		pulling = !pulling
		_display_label(pulling, interaction_text)
	elif (object_close && Input.is_action_just_pressed("push_pull") && not_block_interactable != null):
		not_block_interactable.interact.call()
		pass
	else:
		interact_label.text = ""


func _display_label(is_pulling: bool, interaction_string: String) -> void:
	if (is_pulling):
		interact_label.text = "Press E to stop"
	else:
		interact_label.text = "Press E to {interact}".format({"interact": interaction_string})

func _on_area_entered(area:Area2D) -> void:
	if (area is Interactable):
		var interactable: Interactable = area as Interactable
		if (interactable.interact != null):
			not_block_interactable = interactable
		_display_label(false, interactable.interaction_name)
		interaction_text = interactable.interaction_name
		object_close = true
		

func _on_body_exited(_body:Node2D) -> void:
	interact_label.text = ""
	interaction_text = ""
	object_close = false
	not_block_interactable = null
