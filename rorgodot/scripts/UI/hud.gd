extends Panel

@onready var BtnBuySoldier = $Top/Soldier/BtnBuySoldier
@onready var BtnShowMyLands = $Top/Lands/BtnShowMyLands

@onready var LabAddress = $Top/Address/addr
@onready var LabMyLands = $Top/Lands/Label
@onready var LabMySoldiers = $Top/Soldier/Label
@onready var LabMyGold = $Top/Coins/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnBuySoldier.pressed.connect(self.OnBuySoldier)
	BtnShowMyLands.pressed.connect(self.OnShowMyLands)
	MudMgr.connect("SigOnPlayerDetailUpdate", onPlayerDetailUpdate)
	MudMgr.connect("SigChainConnected", onMyselfLogined)
	print("OS: ", OS.get_name())
	if not OS.get_name() == "Windows":
		MudMgr.Setup()

func onPlayerDetailUpdate(data):
	print("********* Player Detail Updated!")

func onMyselfLogined(data):
	print("********** Logged In ************")
	LabAddress.text = Utils.MakeAddressString(data.wallet)
	var entityKey = data.EntityKey
	var myDetail = MudMgr.FindPlayerDetailByKey(entityKey)
	if myDetail:
		print("My Solderis is " + str(myDetail.cavalryA) + "  CavalryB: " + str(myDetail.cavalryB))
		var soldierCount = myDetail.cavalryA + myDetail.cavalryB + myDetail.cavalryC + myDetail.infantry
		var gold = myDetail.gold
		var lands = myDetail.lands
		LabMyGold.text = str(gold)
		LabMyLands.text = str(lands)
		LabMySoldiers.text = str(soldierCount)


func OnBuySoldier():
	var t = UiMgr.OpenBuySoldier()
	$"..".add_child(t)

func OnShowMyLands():
	var t = UiMgr.OpenMyLandsPage($"..")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
