extends Node3D

class_name invitem

@export var idname: String = "Empty"
@export var itemtex: Texture2D = load("res://UI/nothing.png")
@export var uses: int = -1

func use_item() -> bool:
	uses -= 1
	if uses == 0:
		return true
	else:
		return false
