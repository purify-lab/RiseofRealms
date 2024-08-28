extends Node

var rAxies
var qAxies
var sAxies

var tileSize = 45.0
var HalfSize = tileSize / 2.0
var SideRadius

#当前生成的ID
var nowId = 1

#地图大小六边形边界 递归深度
var mapSize = 60

var tileScene = preload("res://scene/tile.tscn")

#地图根节点
var GameNode

# 根据场景内的坐标获得Hex坐标
func SnapToHexGrid(pos):
	var q = roundi((sqrt(3.0) / 3.0 * pos.x - pos.y / 3.0) / tileSize)
	var r = roundi((2.0 / 3.0 * pos.y) / tileSize)
	var s = -q - r
	var res = Vector3i(q, r, s)
	return res

#坐标地块对应字典 生成过程会作为检查重复的依据
var Maps = {}

#Id地块对应字典
var TileByID = {}

#坐标地块对应字典
var TileByPos = {}

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

#生成一个单块Tile
func create_tile(pos):
	var new_tile = tileScene.instantiate()
	var scene_pos = GetScenePosByCoords(pos)
	new_tile.SetCoord(pos)
	new_tile.SetId(nowId)
	
	TileByID[nowId] = new_tile
	TileByPos[pos] = new_tile
	nowId = nowId + 1
	new_tile.set_position(scene_pos)
	GameNode.add_child(new_tile)
	return new_tile
	
func create():
	Maps = {}
	TileByID = {}
	TileByPos = {}
	nowId = 1
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
