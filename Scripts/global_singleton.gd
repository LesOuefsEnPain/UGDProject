extends Node

signal dsignal(para: String)
signal exitbtn

#global variables here
var can_player_move = true

var scene_node_idx: int = 2
var ginventory: Array[invitem] = [invitem.new(), invitem.new(), invitem.new(), invitem.new(), invitem.new()]
var ginvsize = 5
var aud_to_kill: AudioStreamPlayer

var allpfps = ["res://Sprites/ceciliatest.png", "res://Sprites/VarrickThumbnail.png"]

#put ur dialogue variables here and also put a comment of which dialogue variables are for
var has_met1 = false

func check_inv(n: String, q: int) -> bool:
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	return player_inv.check_inventory(n, q)

func check_eq(n: String) -> bool:
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	return player_inv.check_equipped(n)

func use_eq_item():
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	player_inv.verify_item_existence(player_inv.equippeditem)

func add_inv_item(respath: String):
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	var itemres = load(respath)
	var itemins: invitem = itemres.instantiate()
	player_inv.add_item(itemins)
	
func play_aud(respath: String):
	var audiores = load(respath)
	var audplayer: AudioStreamPlayer = AudioStreamPlayer.new()
	audplayer.stream = audiores
	add_child(audplayer)
	audplayer.play()
	aud_to_kill = audplayer
	audplayer.connect("finished", audfinished)
	
func audfinished():
	aud_to_kill.queue_free()
	pass
	
func change_pfp(respath: String):
	var pfpres = load(respath)
	var tex: TextureRect = get_tree().get_first_node_in_group("chimage")
	tex.texture = pfpres
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
