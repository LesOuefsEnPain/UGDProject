extends CharacterBody3D


@export var SPEED = 10.0
@export var JUMP_VELOCITY = 4.5

var cecsprite : AnimatedSprite3D

var motion = "idle"
var side = "_forward"

var direction: Vector3

var camspring: SpringArm3D
var pivot: Node3D
var cam: Camera3D
var camlpos: Vector3

var inv: Inventory

var testitem = preload("res://Objects/test_item.tscn")

func _ready() -> void:
	cecsprite = $ceciliasprite
	cam = $Pivot/SpringArm3D/Camera3D
	camlpos = cam.position
	camspring = $Pivot/SpringArm3D
	pivot = $Pivot
	inv = $Inventory
	await get_tree().create_timer(3).timeout
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/bedroom.dialogue"), "tutorial")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if !Input.is_anything_pressed(): #guys ts for handling idle motion
		direction.x = 0
		direction.z = 0
		motion = "idle"
		
	cecsprite.animation = motion+side #handling animation block of code
	if (!cecsprite.is_playing()):
		cecsprite.play()
	if (side == "_forward"):
		cecsprite.offset.x = 0
		cecsprite.scale = Vector3(1.15, 1.15, 1.15)
		cecsprite.position.y = 1
	elif (side == "_left"):
		cecsprite.offset.x = 150
		cecsprite.scale = Vector3(1, 1, 1)
		cecsprite.position.y = 0
	else:
		cecsprite.offset.x = 0
		cecsprite.scale = Vector3(1, 1, 1)
		cecsprite.position.y = 0
		
	
	velocity.x = direction.x*SPEED #responsible for motion (does physics ik such a crime)
	velocity.z = direction.z*SPEED
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if (GlobalSingleton.can_player_move):
		if event.is_action_pressed("forward"): #input for movement blocks
			direction.z = 1
			direction.x = 0
			motion = "walk"
			side = "_forward"
		elif event.is_action_pressed("back"):
			direction.z = -1
			direction.x = 0
			motion = "walk"
			side = "_forward"
		elif event.is_action_pressed("right"):
			direction.x = 1
			direction.z = 0
			motion = "walk"
			side = "_right"
		elif event.is_action_pressed("left"):
			direction.x = -1
			direction.z = 0
			motion = "walk"
			side = "_left"
			
	#temporary testing code - to be removed later
	if Input.is_action_just_pressed("debug"):
		var ti: invitem = testitem.instantiate()
		inv.add_item(ti)
	if Input.is_action_just_pressed("debug2"):
		inv.remove_item(inv.equippeditem)
	if Input.is_action_just_pressed("debug3"):
		print(GlobalSingleton.check_inv("Kim Dokja", 2))
	pass
	
func cam_interpolate(newgpos: Vector3):
	camspring.remove_child(cam)
	pivot.add_child(cam)
	var tween = get_tree().create_tween()
	var rtween = get_tree().create_tween()
	tween.tween_property(cam, "global_position", newgpos, 1)
	rtween.tween_property(cam, "rotation_degrees", Vector3(0, 90, 30), 1)
	
func cam_deinterpolate():
	var tween = get_tree().create_tween()
	var rtween = get_tree().create_tween()
	var wait = get_tree().create_timer(1)
	tween.tween_property(cam, "position", camlpos, 1)
	rtween.tween_property(cam, "rotation_degrees", Vector3(0, 0, 0), 1)
	await wait.timeout
	pivot.remove_child(cam)
	camspring.add_child(cam)
