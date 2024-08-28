extends Panel

@onready var BtnBuySoldier = $Top/Soldier/BtnBuySoldier
@onready var BtnShowMyLands = $Top/Lands/BtnShowMyLands

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnBuySoldier.pressed.connect(self.OnBuySoldier)
	BtnShowMyLands.pressed.connect(self.OnShowMyLands)
	if not GameConfig.isDev:
		MudMgr.Setup()

func OnBuySoldier():
	var t = UiMgr.OpenBuySoldier()
	$"..".add_child(t)

func OnShowMyLands():
	var t = UiMgr.OpenMyLandsPage($"..")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
