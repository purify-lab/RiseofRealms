extends Panel
@onready var BtnClose = $Content/BtnClose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.pressed.connect(self.onClose)

func onClose():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
