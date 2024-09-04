extends Node

var mud
var player_update
var player_detail_update
var capital_update
var army_update
var land_update

var json

signal SigOnPlayerUpdate(data)
signal SigOnPlayerDetailUpdate(data)

signal SigChainConnected(data)

var playerDetailStorage = {}
var playerStorage = {}
var capitalStorage = {}
var armyStorage = {}
var landStorage = {}

var myInfo = {}

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
	
func OnCapitalUpdate(data):
	var capital = data[0].value[0]
	var tile_id = capital.tileId
	MapDrawer.DrawCapital(tile_id)
	
	print("UpdateCapital Update")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
	MapDrawer.DrawArmy(t.destination)
	
	
# 查找一个可用的Army 编号
func FindAvailableArmy():
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
