extends AnimatedSprite2D

func PlayWalk():
	play("idle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayWalk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
