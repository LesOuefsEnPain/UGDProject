extends Node3D

var bedroomdialogues = preload("res://Dialogue/bedroomFirst.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSingleton.connect("dsignal", dialogue_signal_received)
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
