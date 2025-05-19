extends Area2D

@onready var interact_label: Label = %InteractLabel

var pulling: bool = false
var object_close: bool = false

var interaction_text: String

func _input(_event: InputEvent) -> void:
	if (object_close && Input.is_action_just_pressed("push_pull")):
		pulling = !pulling
		_display_label(pulling, interaction_text)


func _display_label(is_pulling: bool, interaction_string: String) -> void:
	if (is_pulling):
		interact_label.text = "Press E to stop"
	else:
		interact_label.text = "Press E to {0}".format(interaction_string)

func _on_area_entered(area:Area2D) -> void:
	if (area is Interactable):
		var interactable: Interactable = area as Interactable
		_display_label(false, interactable.interaction_name)
		interaction_text = interactable.interaction_name
		object_close = true
		

func _on_body_exited(_body:Node2D) -> void:
	interact_label.text = ""
	interaction_text = ""
	object_close = false