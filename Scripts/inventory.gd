extends Control

class_name Inventory

var invarr: Array[invitem]
var equippeditem = 0
var invsize: int
var itemspr_ref: Sprite3D
var listitem: ItemList
var currentitemtext: Label
var islistopen = false

func _ready() -> void:
	invarr = GlobalSingleton.ginventory
	invsize = GlobalSingleton.ginvsize
	itemspr_ref = get_parent().get_node("ItemSprite")
	listitem = $AllItems
	currentitemtext = $CurrentItem
	equip_item(equippeditem)
	setup_list(invsize)
	pass
	
func _process(delta: float) -> void:
	pass

func add_item(it: invitem):
	var space_exists = false
	for i in invsize:
		if (invarr[i].idname == "Empty"):
			invarr[i] = it
			listitem.set_item_text(i, str(i+1) + ". " + invarr[i].idname)
			equip_item(i)
			space_exists = true
			break
	if !space_exists:
		print("inventory is full")
	pass
	
func remove_item(idx: int):
	invarr[idx].queue_free()
	invarr[idx] = invitem.new()
	listitem.set_item_text(idx, str(idx+1) + ". " + invarr[idx].idname)
	equip_item(idx)
	pass

func equip_item(idx: int):
	equippeditem = idx
	itemspr_ref.texture = invarr[equippeditem].itemtex
	currentitemtext.text = str(equippeditem + 1) + ". " + invarr[equippeditem].idname

func setup_list(num: int):
	var loopvar = listitem.item_count+1
	for x: int in num:
		listitem.add_item(str(loopvar) + ". " + invarr[loopvar-1].idname)
		loopvar+=1
		
func add_space(addsize: int):
	invsize += 2
	for x: int in addsize:
		invarr.append(invitem.new())
	setup_list(addsize)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("showinvlist"):
		if (!islistopen):
			var tw1 = get_tree().create_tween()
			var tw2 = get_tree().create_tween()
			tw1.tween_property(currentitemtext, "modulate", Color(1, 1, 1, 0), 0.4)
			tw2.tween_property(listitem, "modulate", Color(1,1,1,1), 0.4)
			islistopen = true
	elif event.is_action_released("showinvlist"):
		if (islistopen):
			var tw1 = get_tree().create_tween()
			var tw2 = get_tree().create_tween()
			tw1.tween_property(currentitemtext, "modulate", Color(1, 1, 1, 1), 0.4)
			tw2.tween_property(listitem, "modulate", Color(1,1,1,0), 0.4)
			islistopen = false
	
	if Input.is_action_just_pressed("inv1"):
		equip_item(0)
	elif Input.is_action_just_pressed("inv2"):
		equip_item(1)
	elif Input.is_action_just_pressed("inv3"):
		equip_item(2)
	elif Input.is_action_just_pressed("inv4"):
		equip_item(3)
	elif Input.is_action_just_pressed("inv5"):
		equip_item(4)
	elif Input.is_action_just_pressed("inv6") and invsize > 5:
		equip_item(5)
	elif Input.is_action_just_pressed("inv7") and invsize > 6:
		equip_item(6)
	elif Input.is_action_just_pressed("use_item"):
		var player = get_tree().get_first_node_in_group("cec")
		player.add_child(invarr[equippeditem])
		
		var result: bool = invarr[equippeditem].use_item()
		if result:
			remove_item(equippeditem)
		else:
			player.remove_child(invarr[equippeditem])
	pass
