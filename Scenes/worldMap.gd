extends Node2D

var locationP = load("res://Scenes/locationPoint.tscn")

var open = false
	

func createLocationNodes():
	
	for place in Globals.fastTravels.keys():
		
		var nPoint = locationP.instance()
		nPoint.Name = place
		nPoint.sceneDestination = Globals.fastTravels[place]
		nPoint.position = Vector2(rand_range(0, 800), rand_range(0,300))
		nPoint.connect("pressed",self, "close")
		$Sprite/places.add_child(nPoint)		



func open():
	if Globals.dioBoxOpen == false and open == false:
		$Sprite.show()
		createLocationNodes()
		Globals.stopPlayer()
		open = true

func close():
	$Sprite.hide()
	deletePlaces()
	Globals.startPlayer()
	open = false
	
func deletePlaces():
	for c in $Sprite/places.get_child_count():
		$Sprite/places.get_child(c).queue_free()



func _on_closeMap_pressed():
	close()


func _on_openMap_pressed():
	open()
