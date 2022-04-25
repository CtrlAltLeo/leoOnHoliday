extends Node2D

export(AudioStream) var sceneMusic

var canWalk = false

func _ready():
	
	$zoneNameDebug.text = self.name
	
	if sceneMusic != null:
		MusicBox.changeMusic(sceneMusic.resource_path)
		
	
	Globals.connect("getPath", self, "getPath")
	Globals.connect("addTextBox", self, "addTextBox")
	
	Globals.activateQueuedDio()
	

func getPath(start, end):
	
	var p =  $Navigation2D.get_simple_path(start, end)
	
	Globals.path = p
	Globals.emit_signal("pathReady")


func _process(delta):
	
	
	if Input.is_action_just_pressed("leftClick") and canWalk:
		Globals.emit_signal("disconnectAll")
		$player.setDestination(get_viewport().get_mouse_position())
		
	if Input.is_action_just_pressed("rightClick"):
		Globals.activeItem = ""
	
		


func _on_walkableArea_mouse_entered():
	canWalk = true

func _on_walkableArea_mouse_exited():
	canWalk = false
	
func addTextBox(arr, face, faceArr):
	var nBox = Globals.textInstance.instance()
	nBox.text = arr
	
	print(faceArr)
	
	if face != "":
		nBox.hasFaces = true
		nBox.npcFace = face
		nBox.faceToText = faceArr
	
	self.add_child(nBox)
