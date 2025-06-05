extends AnimatedSprite2D

@onready var timer = $Timer
@export var animation_name: String = "grow_shine"

func _ready() -> void:
	animation = animation_name

func _process(_delta: float) -> void:
	if not is_playing() and timer.is_stopped():
		frame = 0
		var random_start: float = randf_range(.5, 2.5)
		timer.start(random_start)

func _on_timer_timeout() -> void:
	play()
