extends Area3D

var keysprite: Sprite3D
var is_player_in = false
var is_letter_open = false

@export var itemname = ""
@export var itemdesc = ""
@export var itemimage: Texture2D

var inspscreen: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keysprite = $keyinstruction
	keysprite.visible = false
	inspscreen = get_tree().root.get_child(1).get_node("InspectionScreen")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action("interact") and is_player_in):
		is_letter_open = true
		inspscreen.open_screen(itemname, itemdesc, itemimage)
	elif (event.is_action("close") and is_letter_open):
		is_letter_open = false
		inspscreen.close_screen()
	pass

func detect_enter(body: Node3D):
	if (body.is_in_group("cec")):
		is_player_in = true
		keysprite.visible = true
		
func detect_exit(body: Node3D):
	if (body.is_in_group("cec")):
		is_player_in = false
		keysprite.visible = false
		
