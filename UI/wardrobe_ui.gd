extends Control

var canmove1 = false
var canmove2 = false
var canmove3 = false

var panel1: Panel
var panel2: Panel
var panel3: Panel

var bluedress = preload("res://Objects/bluedress.tscn")
var pinkdress = preload("res://Objects/pinkdress.tscn")
var whitedress = preload("res://Objects/whitedress.tscn")

@onready var animplayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	panel1 = $ColorRect
	panel2 = $ColorRect2
	panel3 = $ColorRect3
	pass
	
func _process(delta: float) -> void:
	if canmove1:
		var mousepos = get_viewport().get_mouse_position()
		panel1.global_position = mousepos
	elif canmove2:
		var mousepos = get_viewport().get_mouse_position()
		panel2.global_position = mousepos
	elif canmove3:
		var mousepos = get_viewport().get_mouse_position()
		panel3.global_position = mousepos
	pass


func _on_button_mouse_entered() -> void:
	canmove1 = true
	panel1.visible = true
	animplayer.play("White")
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	canmove1 = false
	panel1.visible = false
	animplayer.stop()
	pass # Replace with function body.


func _on_button_2_mouse_entered() -> void:
	canmove2 = true
	panel2.visible = true
	animplayer.play("Pink")
	pass # Replace with function body.


func _on_button_2_mouse_exited() -> void:
	canmove2 = false
	panel2.visible = false
	animplayer.stop()
	pass # Replace with function body.


func _on_button_3_mouse_entered() -> void:
	canmove3 = true
	panel3.visible = true
	animplayer.play("Blue")
	pass # Replace with function body.


func _on_button_3_mouse_exited() -> void:
	canmove3 = false
	panel3.visible = false
	animplayer.stop()
	pass # Replace with function body.
	
func handle_wardrobe():
	var wdrobe = get_tree().get_first_node_in_group("wardrobe")
	wdrobe.destroy_interactability()
	wdrobe.close_w()


func _on_button_3_pressed() -> void:
	var inventoryobj: Inventory = get_tree().get_first_node_in_group("inventory")
	var bd: dressinv = bluedress.instantiate()
	inventoryobj.add_item(bd)
	handle_wardrobe()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	var inventoryobj: Inventory = get_tree().get_first_node_in_group("inventory")
	var pd: dressinv = pinkdress.instantiate()
	inventoryobj.add_item(pd)
	handle_wardrobe()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	var inventoryobj: Inventory = get_tree().get_first_node_in_group("inventory")
	var wd: dressinv = whitedress.instantiate()
	inventoryobj.add_item(wd)
	handle_wardrobe()
	pass # Replace with function body.


func _on_escape_pressed() -> void:
	GlobalSingleton.exitbtn.emit()
	var wdrobe = get_tree().get_first_node_in_group("wardrobe")
	wdrobe.close_w()
	pass # Replace with function body.
