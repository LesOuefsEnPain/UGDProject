#hii saihaan i hope you get this or else im gonna be super sad bc why am i so bad at this </3
#warda if u can see ts ur cool and u got it correctly!!!!

extends CharacterBody3D


@export var SPEED = 10.0
@export var JUMP_VELOCITY = 4.5

var cecsprite : AnimatedSprite3D

var motion = "idle"
var side = "_forward"

var direction: Vector3

func _ready() -> void:
	cecsprite = $ceciliasprite

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
		cecsprite.scale = Vector3(1.15, 1.15, 1.15)
		cecsprite.position.y = 1
	else:
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
	pass
