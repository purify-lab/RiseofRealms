extends Panel

# 步兵数量
@onready var soldier_1_num: Label = $NinePatchRect/Soldier1/Soldier1Num

# 骑兵数量
@onready var soldier_2_num: Label = $NinePatchRect/Soldier2/Soldier2Num

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func SetInfo(land):
	soldier_1_num.text = str(land.infantry)
	soldier_2_num.text = str(land.cavalryA)
