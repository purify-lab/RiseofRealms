extends Node

var _timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	
func set_timeout(sec, cb : Callable):
	_timer.start(sec)
	await _timer.timeout
	cb.call()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
