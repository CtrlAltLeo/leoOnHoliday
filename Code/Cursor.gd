extends Node2D

func _process(delta):
	
	if Globals.activeItem != "":
		$Sprite.texture = load(Globals.items[Globals.activeItem]["image"])
	else:
		$Sprite.texture = null
		
	position = get_viewport().get_mouse_position()
