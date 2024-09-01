extends Node
var buy_soldier_panel = preload("res://scene/buy_sodier_panel.tscn")
var land_info_page = preload("res://scene/land_info_page.tscn")
var pledge_currenyc_page = preload("res://scene/pledge_currency.tscn")
var mylands_page = preload("res://scene/owne_tiles.tscn")

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
