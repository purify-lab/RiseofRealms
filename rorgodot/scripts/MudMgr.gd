extends Node

var mud
var player_update
var player_detail_update
var capital_update
var army_update
var land_update

var json

var playerDetailStorage = {}
var playerStorage = {}
var capitalStorage = {}
var armyStorage = {}
var landStorage = {}

var myEntityKey = false
var myWallet = false

var playerUpdateCallback = []
var playerDetailUpdateCallback = []
var capitalUpdateCallback = []
var landUpdateCallback = []
var armyUpdateCallback = []

func SetPlayerUpdateCallback(cb):
	playerUpdateCallback.append(cb)
	
func SetPlayerDetailUpdateCallback(cb):
	playerDetailUpdateCallback.append(cb)

func SetCapitalUpdateCallback(cb):
	capitalUpdateCallback.append(cb)
	
func SetLandUpdateCallback(cb):
	landUpdateCallback.append(cb)

func SetArmyUpdateCallback(cb):
	armyUpdateCallback.append(cb)

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
	
func OnPlayerDetailUpdate(data):
	if not myEntityKey:
		myEntityKey = JavaScriptBridge.eval("window.mud.network.playerEntity")
	if not myWallet:
		myWallet = JavaScriptBridge.eval("window.mud.network.walletClient.account.address")
	playerDetailStorage[data[0].entity] = data[0].value[0]
	print("Jerry OnPlayer DetailUpdate: ", data[0].entity)

func OnPlayerUpdate(data):
	print("Jerry OnPlayer Update:", data[0].entity)
	playerStorage[data[0].entity] = data[0].value[0]

func FindPlayerByKey(key):
	return playerStorage[key]

func FindPlayerDetailByKey(key):
	return playerDetailStorage[key]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
