extends Panel

@onready var BtnClose = $Content/BtnClose
@onready var LabCoords = $Content/CoordLab
@onready var BtnBuy = $Content/Icon/ConfirmBtn
@onready var BtnSelect = $Content/SelectBtn

# 是否正在选择地块
var isPickingTile = false

# 当前的选择目标
var currentPosition = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.pressed.connect(Close)
	BtnBuy.pressed.connect(onBuy)
	BtnSelect.pressed.connect(OnSelect)
	
func Close():
	isPickingTile = false
	visible = false

func onBuy():
	if not currentPosition:
		return
	var tile = MapDrawer.TileByPos[currentPosition]
	MudMgr.BuyCapital(tile.id)
	Close()

func OnSelect():
	visible = false
	isPickingTile = true

func OnPickTile(pos):
	LabCoords.text = "Coordinate: " + str(pos)
	currentPosition = pos
	visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
