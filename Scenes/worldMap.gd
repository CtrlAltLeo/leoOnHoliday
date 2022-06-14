extends Node2D

var locationP = load("res://Scenes/locationPoint.tscn")

var open = false

var locked = false

func _ready():
	Globals.connect("hideUI", self, "hide")
	Globals.connect("showUI", self, "show")
	

func createLocationNodes():
	
	var count = 0
	for place in Globals.fastTravels.keys():
		
		var nPoint = locationP.instance()
		nPoint.Name = place
		nPoint.sceneDestination = Globals.fastTravels[place]
		nPoint.position = Vector2($point.position.x + (150 * (count % 4)),$point.position.y + (200 * (count / 4)))
		nPoint.connect("pressed",self, "close")
		$Sprite/places.add_child(nPoint)		
		count += 1


func open():
	
	if locked:
		return
	
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
	
func lock():
	locked = true
	$openMap.hide()
	
func unlock():
	locked = false
	$openMap.show()
