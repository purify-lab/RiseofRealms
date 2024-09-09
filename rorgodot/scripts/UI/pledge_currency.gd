extends Panel

@onready var btn_close: TextureButton = $Content/BtnClose
@onready var confirm_btn: TextureButton = $Content/ConfirmBtn
@onready var amount: TextEdit = $Content/Amout/Amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_close.pressed.connect(close)
	confirm_btn.pressed.connect(onConfirm)
	
func onConfirm():
	close()

func close():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
