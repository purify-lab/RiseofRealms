extends Panel

@onready var BtnClose = $Content/BtnClose
@onready var UnocuppiedPanel = $Content/UnocuppiedPanel
@onready var OccupiedPanel = $Content/OccupiedPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.connect("pressed", CloseAnim)

func onClose():
	queue_free()

func OpenAnim():
	$AnimationPlayer.play("open")

func CloseAnim():
	$AnimationPlayer.play("close")
	
func SetLocation(pos):
	$Content/loc.SetTilePos(pos)
	
	
func InitData(data):
	if data:
		UnocuppiedPanel.visible = false
		OccupiedPanel.visible = true
	else:
		UnocuppiedPanel.visible = true
		OccupiedPanel.visible = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
