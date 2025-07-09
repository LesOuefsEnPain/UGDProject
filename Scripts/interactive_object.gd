extends Area3D

var keysprite: Sprite3D
var is_player_in = false
var is_interacted = false

@export var itemname = ""
@export var itemdesc = ""
@export var itemimage: Texture2D
@export var id: String = ""

var inspscreen: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keysprite = $keyinstruction
	keysprite.visible = false
	inspscreen = get_tree().root.get_child(GlobalSingleton.scene_node_idx).get_node("InspectionScreen")
	GlobalSingleton.connect("exitbtn", closebtn)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action("interact") and is_player_in and !is_interacted):
		if id == "wdrobe":
			is_interacted = true
			get_parent().open_w()
		elif id == "door":
			is_interacted = true
			get_parent().go_out()
		else:
			is_interacted = true
			inspscreen.open_screen(itemname, itemdesc, itemimage)
	elif (event.is_action("close") and is_interacted):
		if id == "wdrobe":
			is_interacted = false
			get_parent().close_w()
		else:
			is_interacted = false
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
		
func closebtn():
	is_interacted = false
		
