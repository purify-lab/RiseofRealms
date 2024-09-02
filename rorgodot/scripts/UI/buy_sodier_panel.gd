extends Panel

@onready var BtnClose = $Content/BtnClose
@onready var BtnBuy = $Content/BtnBuy

@onready var infantryCount = $Content/Item1/NinePatchRect/TextEdit
@onready var cavalryCount = $Content/Item2/NinePatchRect/TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.pressed.connect(self.onClose)
	BtnBuy.pressed.connect(onBuy)

func onClose():
	queue_free()
	
func onBuy():
	var infantryNum = 0
	var cavalryNum = 0
	if infantryCount.text != "":
		infantryNum = int(infantryCount.text)
	if cavalryCount.text != "":
		cavalryNum = int(cavalryCount.text)
	MudMgr.BuySoldier(infantryNum, cavalryNum)
	onClose()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
