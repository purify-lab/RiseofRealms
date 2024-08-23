extends Node

var rAxies
var qAxies
var sAxies

var tileSize = 45.0
var HalfSize = tileSize / 2.0
var SideRadius

#地图大小六边形边界 递归深度
var mapSize = 60

var tileScene = preload("res://scene/tile.tscn")
var GameNode

var Maps = {}

func Init(_game_node):
	SideRadius = HalfSize * sqrt(3.0)
	rAxies = Vector3(0, 0, -1.5 * HalfSize)
	qAxies = Vector3(SideRadius,0, 1.5 * HalfSize)
	sAxies = Vector3(-SideRadius, 0,  1.5 * HalfSize)
	GameNode = _game_node
	create()
	

#根据坐标获取场景位置
func GetScenePosByCoords(coords):
	var t = qAxies * coords.x + rAxies * coords.y + sAxies * coords.z
	return Vector2(t.x, t.z)
	
func create_tile(pos):
	var new_tile = tileScene.instantiate()
	var scene_pos = GetScenePosByCoords(pos)
	new_tile.SetCoord(pos)
	new_tile.set_position(scene_pos)
	GameNode.add_child(new_tile)
	return new_tile
	
func create():
	Maps = {}
	var start = create_tile(Vector3i(0, 0, 0))
	var open = []
	open.append(start)
	Maps[start.coord] = start
	
	for i in mapSize:
		var next_turn = []
		for j in open:
			for k in j.GetNeighbours():
				if !Maps.has(k):
					var nt = create_tile(k)
					Maps[k] = nt
					next_turn.append(nt)
			open = next_turn
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("MapDrawer is Ready")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
