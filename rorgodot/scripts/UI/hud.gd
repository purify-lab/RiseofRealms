extends Panel

# 顶部购买士兵和购买土地的两个按钮
@onready var BtnBuySoldier = $Top/Soldier/BtnBuySoldier
@onready var BtnShowMyLands = $Top/Lands/BtnShowMyLands

#钱包标签
@onready var LabAddress = $Top/Address/addr

# 地块 士兵 金币标签
@onready var LabMyLands = $Top/Lands/Label
@onready var LabMySoldiers = $Top/Soldier/Label
@onready var LabMyGold = $Top/Coins/Label

@onready var btn_current_a_exchange: TextureButton = $Top/currencyA/BtnCurrentAExchange
@onready var btn_current_b_exchange: TextureButton = $Top/currencyB/BtnCurrentBExchange
@onready var btn_current_c_exchange: TextureButton = $Top/currencyC/BtnCurrentCExchange

# 我的Entity ID
var MyEntityKey

var IsBuying

# 购买首都按钮
@onready var BtnBuyCapital = $BtnBuyCapital

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BtnBuySoldier.pressed.connect(self.OnBuySoldier)
	BtnShowMyLands.pressed.connect(self.OnShowMyLands)
	MudMgr.connect("SigOnPlayerDetailUpdate", onPlayerDetailUpdate)
	MudMgr.connect("SigChainConnected", onMyselfLogined)
	print("OS: ", OS.get_name())
	if not OS.get_name() == "Windows":
		MudMgr.Setup()
	else:
		FinishedInit()
	BtnBuyCapital.pressed.connect(OnClickBuyCapital)
	btn_current_a_exchange.pressed.connect(openExchangePage)
	btn_current_b_exchange.pressed.connect(openExchangePage)
	btn_current_c_exchange.pressed.connect(openExchangePage)
	
# 打开置换的界面
func openExchangePage():
	UiMgr.open_pledge_currency_page($"..")

# 我的信息来了之后检查是否购买了主城
func FinishedInit():
	if not MudMgr.myselfDetail.isSpawnCapital:
		$"../PurchaseLandPanel".visible = true
	else:
		print("Already Buy Capital...")
	
func OnClickBuyCapital():
	#UiMgr.open_buy_capital_page($"..")
	$"../PurchaseLandPanel".visible = true

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
		MudMgr.myselfDetail = myDetail

func OnBuySoldier():
	var t = UiMgr.OpenBuySoldier()
	$"..".add_child(t)

func OnShowMyLands():
	var t = UiMgr.OpenMyLandsPage($"..")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
