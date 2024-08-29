extends Panel

@onready var BtnClose = $Content/BtnClose
@onready var UnocuppiedPanel = $Content/UnocuppiedPanel
@onready var OccupiedPanel = $Content/OccupiedPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.connect("pressed", self.onClose)

func onClose():
	print("Close")
	queue_free()
	
func InitData(data):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
