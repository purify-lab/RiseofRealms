extends Node

var rAxies
var qAxies
var sAxies

var tileSize = 45.0
var HalfSize = tileSize / 2.0
var SideRadius

# 当前生成的ID
var nowId = 1

# 地图大小六边形边界 递归深度
var mapSize = 60

# 地块场景
var tileScene = preload("res://scene/tile.tscn")

# 建筑场景
var buildingScene = preload("res://scene/building.tscn")

# 士兵形象
var soldierScene = preload("res://scene/infantry.tscn")

#地图根节点
var GameNode

var CapitalCursor
var isPlacingCapital = false

# 根据场景内的坐标获得Hex坐标
func SnapToHexGrid(pos):
	var q = roundi((sqrt(3.0) / 3.0 * pos.x + pos.y / 3.0) / tileSize)
	var r = -roundi((2.0 / 3.0 * pos.y) / tileSize)
	var s = -q - r
	var res = Vector3i(q, r, s)
	return res

#坐标地块对应字典 生成过程会作为检查重复的依据
var Maps = {}

#Id地块对应字典
var TileByID = {}

#坐标地块对应字典
var TileByPos = {}

# 初始化
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

func PlaceBuildingOnTile(pos):
	var scene_pos = GetScenePosByCoords(pos)
	var t = buildingScene.instantiate()
	t.set_position(scene_pos)
	GameNode.add_child(t)
	
	return t
	
# 生成一个单块Tile
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

# 创建一整张地图
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
	
func get_neighbours(coord):
	return [
		coord + Vector3i(1, 0, -1),
		coord + Vector3i(1, -1, 0),
		coord + Vector3i(0, -1, 1),
		coord + Vector3i(-1, 0, 1),
		coord + Vector3i(-1, 1, 0),
		coord + Vector3i(0, 1, -1),
	]

# 绘制士兵军队
func DrawArmy(tileId):
	var tile = TileByID[tileId]
	var pos = GetScenePosByCoords(tile.coord)
	var startPos = GetScenePosByCoords(Vector3i.ZERO)
	var path = find_path(Vector3i.ZERO, tile.coord)
	print("Find Path: ",  path)
	var line = route_scene.instantiate()
	GameNode.add_child(line)
	line.DrawPoints(path)

	var t = soldierScene.instantiate()
	GameNode.add_child(t)
	t.set_position(pos)

# 绘制主城
func DrawCapital(tileId):
	var tile = TileByID[tileId]
	var pos = GetScenePosByCoords(tile.coord)
	var t = buildingScene.instantiate()
	GameNode.add_child(t)
	t.set_position(pos)
	
var route_scene = preload("res://scene/route.tscn")
# 绘制路线
func DrawLine(from, to):
	var t = route_scene.instantiate()
	GameNode.add_child(t)
	t.Draw(from, to)

# 计算两个地点的Cube距离
func cube_distance(a : Vector3i, b : Vector3i):
	var vec = a - b;
	return (absf(vec.x) + absf(vec.y) + absf(vec.z)) / 2.0;

# 寻路
func find_path(from: Vector3i, to: Vector3i):
	var start = from
	var open = {}
	var closed = {}
	var path = {}
	
	open[start] = 0
	while open.size() > 0:
		var minDis = 1.7014117e+38
		var nowPos = Vector3i.ZERO
		var cost = 0
		for i in open.keys():
			var nowDis = open[i]
			var totaldis = nowDis + cube_distance(i, to)
			if minDis > totaldis:
				minDis = totaldis
				nowPos = i
				cost = totaldis
		closed[nowPos] = cost
		open.erase(nowPos)
		
		var neighbours = get_neighbours(nowPos)
		for k in neighbours:
			if not TileByPos.has(k):
				continue
			if closed.has(k):
				continue
			if not open.has(k):
				path[k] = nowPos
				open[k] = closed[nowPos] + cube_distance(k, to)
			if k == to:
				var reverse = k
				var finalPath = []
				
				while reverse != from:
					reverse = path[reverse]
					if reverse != from:
						finalPath.append(reverse)
				
				finalPath.append(from)	
				finalPath.reverse()
				finalPath.append(to)
				
				return finalPath
	return null
		
		
