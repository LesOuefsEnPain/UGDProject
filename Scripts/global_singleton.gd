extends Node

#global variables here
var can_player_move = true

var ginventory: Array[invitem] = [invitem.new(), invitem.new(), invitem.new(), invitem.new(), invitem.new()]
var ginvsize = 5

func check_inv(n: String, q: int) -> bool:
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	return player_inv.check_inventory(n, q)

func check_equipped(n: String) -> bool:
	var player_inv: Inventory = get_tree().get_first_node_in_group("cec").get_node("Inventory")
	return player_inv.check_equipped(n)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
