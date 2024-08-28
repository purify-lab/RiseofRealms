extends Camera2D
var is_dragging = false
var last_mouse_position = Vector2()

var zoom_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# 检查鼠标是否在 UI 上
				is_dragging = true
				last_mouse_position = event.position
			else:
				is_dragging = false
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var t = get_global_mouse_position()
			var coord = MapDrawer.SnapToHexGrid(t)
			MapDrawer.PlaceBuildingOnTile(coord)
			print("Mouse Clicked At: ", t, coord)
			
	if event is InputEventMouseMotion and is_dragging:
		# 计算鼠标移动的偏移量
		var delta = event.position - last_mouse_position
		# 更新相机位置
		position -= delta / zoom
		last_mouse_position = event.position
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		# 鼠标滚轮向上滚动，放大
		zoom += Vector2(zoom_speed, zoom_speed)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		# 鼠标滚轮向下滚动，缩小
		zoom -= Vector2(zoom_speed, zoom_speed)
		
	zoom.x = clampf(zoom.x, 1.0, 5.0)
	zoom.y = clampf(zoom.y, 1.0, 5.0)
