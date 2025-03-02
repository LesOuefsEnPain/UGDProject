extends StaticBody3D

var is_player_in = false #this variable keeps in check if the player is inside of interaction bounds
var is_letter_open = false
var ui: Control #reference variable for the object UI which is the object in which there is all the text and all
var letter: Control #reference to the letter object
var interacttxt: Label #reference to the interactdirection object which is of kind Label (text)

func _ready() -> void:
	ui = $InteractUI/UI #now we are actually giving the reference to the object UI
	letter = $InteractUI/UI/Letter
	interacttxt = $InteractUI/UI/InteractDirection
	pass 


func _process(delta: float) -> void:
	pass

func _on_detector_body_entered(body: Node3D) -> void: #gets called whenever anything enters the detector
	if body.is_in_group("cec"): #only the object of cecilia is in group cec so if the thing that enters detector is in group cec it has to be cecilia
		is_player_in = true
		ui.visible = true; #when player enters, the ui pops up
	pass 


func _on_detector_body_exited(body: Node3D) -> void: #gets called whenever anything exits the detector
	if body.is_in_group("cec"):
		is_player_in = false
		ui.visible = false
		close_letter() #close letter if player moves away and is open
	pass 
	
func _input(event: InputEvent) -> void:
	if (event.is_action("interact") and is_player_in): #checks to see if player is in interaction bounds while E which is action interact is pressed
		open_letter()
	elif (event.is_action("close") and is_letter_open): #same logic but player being in doesnt matter so we r using letter being open
		close_letter()
	pass

func open_letter(): #self explanatory
	letter.visible = true
	interacttxt.visible = false
	
	is_letter_open = true
	pass
	
func close_letter(): #self explanatory
	letter.visible = false
	interacttxt.visible = true
	
	is_letter_open = false
	pass

	

	
