extends Node
var buy_soldier_panel = preload("res://scene/buy_sodier_panel.tscn")
var land_info_page = preload("res://scene/land_info_page.tscn")
var pledge_currenyc_page = preload("res://scene/pledge_currency.tscn")
var mylands_page = preload("res://scene/owne_tiles.tscn")
var buy_capital_page = preload("res://scene/PurchaseLandPanel.tscn")
var pledge_currency_page = preload("res://scene/pledge_currency.tscn")

func open(name):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func OpenBuySoldier():
	var t = buy_soldier_panel.instantiate()
	return t
	
func OpenMyLandsPage(parent):
	var t = mylands_page.instantiate()
	parent.add_child(t)
	return t

func OpenLandInfo(parent):
	var t = land_info_page.instantiate()
	parent.add_child(t)	
	t.OpenAnim()
	return t
	
func open_buy_capital_page(parent):
	var t = buy_capital_page.instantiate()
	parent.add_child(t)
	return t

# 打开置换界面
func open_pledge_currency_page(parent):
	var t = pledge_currency_page.instantiate()
	parent.add_child(t)
	return t

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
