extends Panel

@onready var BtnAttack = $BtnAtk

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnAttack.pressed.connect(OnAttack)

func OnAttack():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
