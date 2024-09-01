extends Node2D

@onready var sprite = $Sprite2D

var coord
var id = -1

@export var texture : Array[Texture2D]

func GetNeighbours():
	return [
		coord + Vector3i(1, 0, -1),
		coord + Vector3i(1, -1, 0),
		coord + Vector3i(0, -1, 1),
		coord + Vector3i(-1, 0, 1),
		coord + Vector3i(-1, 1, 0),
		coord + Vector3i(0, 1, -1),
	];
	
func SetCoord(pos):
	coord = pos
	
func SetId(Id):
	id = Id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = texture[randi_range(0, texture.size() - 1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
