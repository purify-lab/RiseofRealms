extends Control

@onready var BtnClose = $Bg/BtnClose
@onready var infantryInp = $Bg/Item1/NinePatchRect/TextEdit
@onready var calvalryInp = $Bg/Item2/NinePatchRect/TextEdit
@onready var BtnAtk = $Bg/BtnAtk

var currentPos = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnClose.pressed.connect(onClose)
	BtnAtk.pressed.connect(onAtk)
	
# 设置当前选择的目标地块
func SetDestination(pos):
	currentPos = pos
	$Bg/loc.SetTilePos(pos)

func onClose():
	visible = false
	
func onAtk():
	print("Attacking :", currentPos)
	var infantryNum = 0
	var caralryNum  = 0
	if infantryInp.text != "":
		infantryNum = int(infantryInp.text)
	if calvalryInp.text != "":
		caralryNum = int(calvalryInp.text)
	var tileId = MapDrawer.TileByPos[currentPos].id
	var army_id = MudMgr.FindAvailableArmy()
	MudMgr.March(tileId, infantryNum, caralryNum, 0, 0, army_id)
	onClose()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
