extends TextureButton
@export var Normal : Texture2D
@export var Pressed : Texture2D
@export var Hover : Texture2D

@export var image : NodePath

var texture : NinePatchRect

func OnMouseDown():
	if Pressed:
		texture.texture = Pressed

func OnMouseUp():
	if Normal:
		texture.texture = Normal

func onMouseEnter():
	if Hover:
		texture.texture = Hover
	
func onMouseLeave():
	if Normal:
		texture.texture = Normal
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = get_node(image)
	connect("button_down", OnMouseDown)
	connect("button_up", OnMouseUp)
	connect("mouse_entered", onMouseEnter)
	connect("mouse_exited", onMouseLeave)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
