extends Node3D

class_name invitem

@export var idname: String = "Empty"
@export var itemtex: Texture2D = null
@export var uses: int = -1

func use_item() -> bool:
	return false
