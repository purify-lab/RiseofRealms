extends Node

@onready var line_2d: Line2D = $Line2D

func Draw(from, to):
	line_2d.add_point(from)
	line_2d.add_point(to)
	
func DrawPoints(points):
	for i in points:
		var pos = MapDrawer.GetScenePosByCoords(i)
		line_2d.add_point(pos)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
