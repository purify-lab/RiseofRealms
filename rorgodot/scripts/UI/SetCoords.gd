extends TextureRect

@onready var locationText = $Label

func SetTileID(id):
	pass
	
func SetTilePos(pos : Vector3i):
	locationText.text = str(pos)
