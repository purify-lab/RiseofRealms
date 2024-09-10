extends Node

signal CurrencyAChange(amount)
signal CurrencyBChange(amount)
signal CurrencyCChange(amount)

var mud
var player_update
var player_detail_update
var capital_update
var army_update
var land_update
var all_catch_up
var js_currencya_update
var js_currencyb_update
var js_currencyc_update

var json

var isAllCatchUp = false

signal SigOnPlayerUpdate(data)
signal SigOnPlayerDetailUpdate(data)

signal SigChainConnected(data)

var playerDetailStorage = {}
var playerStorage = {}
var capitalStorage = {}
var armyStorage = {}
var landStorage = {}

var myInfo = {}

var undrawnArmy = []

var myEntityKey = false
var myWallet = false

# 地图上所有的主城
var CapitalsOnMap = {}

var myselfDetail = {
	isInit = true,
	isSpawnCapital = false
}

var ArmyByEntity = {}

func Setup():
	json = JSON.new()
	print("On Mud Mgr Init")
	JavaScriptBridge.eval("window.mud.setup()")
	mud = JavaScriptBridge.get_interface("mud")
	player_update = JavaScriptBridge.create_callback(OnPlayerUpdate)
	mud.player_updated = player_update
	
	player_detail_update = JavaScriptBridge.create_callback(OnPlayerDetailUpdate)
	mud.player_detail_updated = player_detail_update
	
	army_update = JavaScriptBridge.create_callback(OnArmyUpdate)
	mud.army_updated = army_update
	
	capital_update = JavaScriptBridge.create_callback(OnCapitalUpdate)
	mud.capital_updated = capital_update
	
	land_update = JavaScriptBridge.create_callback(OnLandUpdate)
	mud.land_updated = land_update
	
	all_catch_up = JavaScriptBridge.create_callback(OnAllCatchUp)
	mud.all_catch_up = all_catch_up
	
	js_currencya_update = JavaScriptBridge.create_callback(OnCurrencyAUpdate)
	mud.tokena_updated = js_currencya_update
	js_currencyb_update = JavaScriptBridge.create_callback(OnCurrencyBUpdate)
	mud.tokenb_updated = js_currencyb_update
	js_currencyc_update = JavaScriptBridge.create_callback(OnCurrencyCUpdate)
	mud.tokenc_updated = js_currencyc_update

func OnCurrencyAUpdate(data):
	emit_signal("CurrencyAChange", data[0])

func OnCurrencyBUpdate(data):
	emit_signal("CurrencyBChange", data[0])
	
func OnCurrencyCUpdate(data):
	emit_signal("CurrencyCChange", data[0])
	
	
# 地块更新消息
func OnLandUpdate(data):
	var land = data[0].value[0]
	landStorage[land.tileId] = land
	print("On Land Update...")

# 查找地块
func FindLand(id):
	if landStorage.has(id):
		return landStorage[id]
	return null
	
# 区块同步完成
func OnAllCatchUp(data):
	print("All Catch Up....")
	TimerMgr.set_timeout(3, RealCatchUp)

func RealCatchUp():
	print("Real All Catch UP.....")
	isAllCatchUp = true
	if not playerStorage.has(myEntityKey):
		SpawnPlayer()
	DrawAllArmy()
	
# 生成玩家
func SpawnPlayer():
	if OS.get_name() == "Windows":
		pass
	else:
		JavaScriptBridge.eval("window.mud.spawnPlayer()")
	
func OnCapitalUpdate(data):
	var capital = data[0].value[0]
	var tile_id = capital.tileId
	MapDrawer.DrawCapital(tile_id)
	CapitalsOnMap[capital.owner] = capital
	
	print("UpdateCapital Update")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# 查找我自己的首都
func find_my_capital():
	var tt = CapitalsOnMap[myEntityKey]
	return tt

# 查找指定人的主城
func find_capital(key):
	for i in CapitalsOnMap:
		print("We  Get : ", i)
	return CapitalsOnMap[key]

# 购买士兵
func BuySoldier(infantryNum, cavalryNum):
	if not OS.get_name() == "Windows":
		if infantryNum > 0:
			JavaScriptBridge.eval("window.mud.buyInfantry(" + str(infantryNum) + ")")
		if cavalryNum > 0:
			JavaScriptBridge.eval("window.mud.buyCavalryA(" + str(cavalryNum) + ")")
	else:
		print("Buy Soldier: ", infantryNum, "  ",  cavalryNum)
	
# 购买主城
func BuyCapital(tileId):
	if not OS.get_name() == "Windows":
		JavaScriptBridge.eval("window.mud.spawnCapital(" + str(tileId) + ")")
	else:
		print("Cannot work on windows " + str(tileId))

# 派兵：
func March(tileId, inf, calA, calB, calC, armyId):
	var cmd = "window.mud.marchArmy(%s, %s, %s, %s, %s, %s)"
	cmd = cmd % [str(tileId), str(inf), str(calA), str(calB), str(calC), str(armyId)]
	if not OS.get_name() == "Windows":
		JavaScriptBridge.eval(cmd)
	else:
		print("Marching... ", cmd)

func OnPlayerDetailUpdate(data):
	if not myEntityKey:
		myEntityKey = JavaScriptBridge.eval("window.mud.network.playerEntity")
		myInfo.EntityKey = myEntityKey
	if not myWallet:
		myWallet = JavaScriptBridge.eval("window.mud.network.walletClient.account.address")
		myInfo.wallet = myWallet
	
	playerDetailStorage[data[0].entity] = data[0].value[0]
	print("...... Storing: " + data[0].entity, data[0].value[0])
	print("Jerry OnPlayer DetailUpdate: ", data[0].entity)
	emit_signal("SigOnPlayerDetailUpdate", data[0].value[0])
	emit_signal("SigChainConnected", myInfo)

# 部队更新
func OnArmyUpdate(data):
	var t = data[0].value[0]
	var owner = t.owner
	var army_id = t.id
	if t.lastTime <= 0:
		return
	if not ArmyByEntity.has(owner):
		ArmyByEntity[owner] = {}
	var player = ArmyByEntity[owner]
	player[army_id] = t
	undrawnArmy.append(t)
	if isAllCatchUp:
		DrawAllArmy()

func DrawAllArmy():
	for i in undrawnArmy:
		MapDrawer.DrawArmy(i)
	undrawnArmy = []
	
	
# 查找一个可用的Army 编号
func FindAvailableArmy():
	if OS.get_name() == "Windows":
		return 1
	if not ArmyByEntity.has(myEntityKey):
		return 1
	var amryList = ArmyByEntity[myEntityKey]
	for i in range(1, 10):
		if not amryList.has(i):
			print("Found Army Id: ", i)
			return i
	return -1

func OnPlayerUpdate(data):
	print("Jerry OnPlayer Update:", data[0].entity)
	playerStorage[data[0].entity] = data[0].value[0]

func FindPlayerByKey(key):
	return playerStorage[key]

func FindPlayerDetailByKey(key):
	if playerDetailStorage.has(key):
		return playerDetailStorage[key]
	else:
		print("Cannot find Key : " + key)
		for i in playerDetailStorage.keys():
			print("We Have Keys: " + i)
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
