extends Node3D

var bedroomdialogues = preload("res://Dialogue/bedroomFirst.dialogue")

@onready var inventory: Control = $Cecilia/Inventory
@onready var door = $ceciliabedroom/bedroomdoor
@onready var door_io = door.get_node("InteractiveObject")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSingleton.connect("dsignal", dialogue_signal_received)
	inventory.connect("item_used", item_used)
	door.connect("get_out", get_out)
	door_io.set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_wake_dialogue():
	DialogueManager.show_dialogue_balloon(bedroomdialogues, "awake")
	pass
	
func dialogue_signal_received(para: String):
	if para == "start":
		await get_tree().create_timer(0.75).timeout
		$AnimationPlayer.play("transitionin")
		await get_tree().create_timer(1.5).timeout
		$Cutscene1Cam.queue_free()
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("transitionout")
		await get_tree().create_timer(2.5).timeout
		DialogueManager.show_example_dialogue_balloon(bedroomdialogues, "instruction")
	pass
	
func item_used(item: String):
	if item == "Cerulean Dress" or item == "Coral y Rozada" or "Le Blanc":
		dress_wore()
		pass
	pass
	
func dress_wore():
	await get_tree().create_timer(4).timeout
	DialogueManager.show_example_dialogue_balloon(bedroomdialogues, "continue")
	door_io.set_process(true)
	pass
	
func get_out():
	print("get out")
	pass
