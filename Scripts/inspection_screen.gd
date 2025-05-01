extends Control

#declaring variables
var titlelabel: Label
var desclabel: Label
var imageobj: TextureRect

signal closebtn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	titlelabel = $ItemTitle
	desclabel = $ItemDesc
	imageobj = $ItemImage
	pass # Replace with function body.
	
func open_screen(title: String, desc: String, tex: Texture2D):
	GlobalSingleton.can_player_move = false
	
	titlelabel.text = title
	desclabel.text = desc
	
	imageobj.texture = tex
	
	var easeintween = get_tree().create_tween()
	easeintween.tween_property(self, "modulate", Color(1, 1, 1, 1), 1)
	pass
	
func close_screen():
	GlobalSingleton.can_player_move = true
	
	var easeouttween = get_tree().create_tween()
	easeouttween.tween_property(self, "modulate", Color(1,1,1,0), 1)
	pass


func _on_escape_pressed() -> void:
	closebtn.emit()
	close_screen()
	pass # Replace with function body.
