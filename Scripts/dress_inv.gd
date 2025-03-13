class_name dressinv extends invitem

@export var dress_type: String = ""

func use_item() -> bool:
	if dress_type == "b":
		get_parent().SPEED += 5
	elif dress_type == "p":
		get_parent().get_node("Inventory").add_space(2)
	elif dress_type == "w":
		pass
	uses -= 1
	if uses == 0:
		return true
	else:
		return false
