extends Control

var canmove1 = false
var canmove2 = false
var canmove3 = false

var panel1: ColorRect
var panel2: ColorRect
var panel3: ColorRect

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
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	canmove1 = false
	panel1.visible = false
	pass # Replace with function body.


func _on_button_2_mouse_entered() -> void:
	canmove2 = true
	panel2.visible = true
	pass # Replace with function body.


func _on_button_2_mouse_exited() -> void:
	canmove2 = false
	panel2.visible = false
	pass # Replace with function body.


func _on_button_3_mouse_entered() -> void:
	canmove3 = true
	panel3.visible = true
	pass # Replace with function body.


func _on_button_3_mouse_exited() -> void:
	canmove3 = false
	panel3.visible = false
	pass # Replace with function body.
