extends Control

class_name Inventory

var invarr: Array[invitem]
var equippeditem = 0
var invsize: int
var itemspr_ref: Sprite3D
var currentitemtext: Label
var islistopen = false
var items = []

func _ready() -> void:
	invarr = GlobalSingleton.ginventory
	invsize = GlobalSingleton.ginvsize
	itemspr_ref = get_parent().get_node("ItemSprite")
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
			#listitem.set_item_text(i, str(i+1) + ". " + invarr[i].idname)
			setup_list(invsize)
			equip_item(i)
			space_exists = true
			break
	if !space_exists:
		print("inventory is full")
	pass
	
func remove_item(idx: int):
	invarr[idx].queue_free()
	invarr[idx] = invitem.new()
	#listitem.set_item_text(idx, str(idx+1) + ". " + invarr[idx].idname)
	setup_list(invsize)
	equip_item(idx)
	pass

func equip_item(idx: int):
	equippeditem = idx
	itemspr_ref.texture = invarr[equippeditem].itemtex
	currentitemtext.text = str(equippeditem + 1) + ". " + invarr[equippeditem].idname

func setup_list(num: int):
	#var loopvar = listitem.item_count+1
	#for x: int in num:
		#listitem.add_item(str(loopvar) + ". " + invarr[loopvar-1].idname)
		#loopvar+=1
	var loopvar = 0
	for x in invarr:
		if !(items.size() < loopvar+1):	
			items[loopvar] = {'texture': x.itemtex, 'title': x.idname, 'id': str(loopvar)}
		else:
			items.append({'texture': x.itemtex, 'title': x.idname, 'id': str(loopvar)})
		loopvar += 1
		pass
	$RadialMenu.set_items(items)
	pass
		
func add_space(addsize: int):
	invsize += addsize
	for x: int in addsize:
		invarr.append(invitem.new())
	setup_list(invsize)
	
func check_equipped(id: String) -> bool:
	if invarr[equippeditem].idname == id:
		return true
	else:
		return false
		
func check_inventory(id: String, qnt: int) -> bool:
	var amnt: int = 0
	for item in invarr:
		if item.idname == id:
			amnt+=1
	if amnt >= qnt:
		return true
	else:
		return false
		
func verify_item_existence(idx: int):
		var player = get_tree().get_first_node_in_group("cec")
		player.add_child(invarr[idx])
		
		var result: bool = invarr[idx].use_item()
		if result:
			remove_item(idx)
		else:
			player.remove_child(invarr[idx])

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("showinvlist"):
		if (!islistopen):
			var tw1 = get_tree().create_tween()
			tw1.tween_property(currentitemtext, "modulate", Color(1, 1, 1, 0), 0.4)
			$RadialMenu.open_menu(Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y / 2))
			islistopen = true
	elif event.is_action_released("showinvlist"):
		if (islistopen):
			var tw1 = get_tree().create_tween()
			tw1.tween_property(currentitemtext, "modulate", Color(1, 1, 1, 1), 0.4)
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
		verify_item_existence(equippeditem)
	pass


func _on_radial_menu_item_selected(id: Variant, position: Variant) -> void:
	equip_item(int(id))
	pass # Replace with function body.
