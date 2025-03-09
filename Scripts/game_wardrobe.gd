extends StaticBody3D

var animplayer: AnimationPlayer
var refpos: Node3D
var wardrobe_ui_inst: Control
var wardrobe_ui = preload("res://UI/wardrobe_ui.tscn")

func _ready() -> void:
	animplayer = $animp
	refpos = $Refpos
	pass
	
func _process(delta: float) -> void:
	pass
	
func open_w():
	GlobalSingleton.can_player_move = false
	animplayer.play("wardrobe_open")
	get_tree().get_first_node_in_group("cec").cam_interpolate(refpos.global_position)
	wardrobe_ui_inst = wardrobe_ui.instantiate()
	var timer = get_tree().create_timer(1)
	await timer.timeout
	get_tree().root.get_child(1).add_child(wardrobe_ui_inst)
	
func close_w():
	GlobalSingleton.can_player_move = true
	animplayer.play("wardrobe_close")
	get_tree().get_first_node_in_group("cec").cam_deinterpolate()
	wardrobe_ui_inst.queue_free()
