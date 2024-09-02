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

var myselfDetail = {
	isInit = true,
	isSpawnCapital = false
}

func Setup():
	json = JSON.new()
	print("On Mud Mgr Init")
	JavaScriptBridge.eval("window.mud.setup()")
	mud = JavaScriptBridge.get_interface("mud")
	player_update = JavaScriptBridge.create_callback(OnPlayerUpdate)
	mud.player_updated = player_update
	
	player_detail_update = JavaScriptBridge.create_callback(OnPlayerDetailUpdate)
	mud.player_detail_updated = player_detail_update

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
