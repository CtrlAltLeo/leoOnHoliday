extends Node2D

export var id_name = ""

export(Texture) var image

export(String,"nills", "view", "pickup", "useable", "door", "inventory", "NPC", "story", "youtube") var itemType

var walkPos = Vector2()

var startPosition = Vector2()

var canClick = false

export (Array, String) var viewText 

export var removeItemOnPower = true

export(Dictionary) var reactionText = {}
export(Array, String) var powerSignals = []
export(Array, String) var keys = []

var state = 0

export var doorLocked = false
export var doorExit = ""
export(String) var doorLockedText = "The door is locked."
export(String) var doorUseText = "You open the door."

export(Texture) var npcFace
export(Array, int) var faceArray

export var sparkle = false

signal powerSignal
signal activateSignal
signal doorUnlock

func _ready():
	
	$CPUParticles2D.emitting = sparkle
	
	startPosition = self.position

	Globals.connect("disconnectAll", self, "disconnectFromPlayer")
	
	#saves time :) 
	if id_name == "":
		id_name = self.name
	
	
	
	#Creates item ID in game
	if !Globals.items.has(id_name):
		Globals.items[id_name] = {"image":image.load_path, "type":itemType, "remove":false, "doorLocked":doorLocked}
	
	#prepares item image on load.
	if itemType == "inventory":
		$Sprite.texture = load(image)
		$isInventory.show()
		$Light2D.texture = load(image)
		
	else:
		$Sprite.texture = image
		$Light2D.texture = image
	
	#Set the light's position
	$Light2D.position = $Sprite.position
	$Light2D.rotation = $Sprite.rotation
	$Light2D.scale = $Sprite.scale
	
	#sets walkpos in code
	walkPos = $walkPos.global_position

	#if item globally removed, remove again
	if Globals.items[id_name]["remove"] and itemType != "inventory":
		queue_free()
		
	
	#Keeps global door state
	doorLocked = Globals.items[id_name]["doorLocked"]
	
	#Creates a view dio and removes itself.
	if itemType == "story" and not Globals.items[id_name]["remove"]:
		Globals.queueDioBox(viewText)
		remove()
	
func _process(delta):
	
	if Input.is_action_just_pressed("leftClick") and canClick :
		
		if itemType == "inventory":
			Globals.activeItem = id_name
			
			return
		
		Globals.emit_signal("disconnectAll")
		Globals.emit_signal("movePlayer", walkPos)
		Globals.connect("playerDoneWalking", self, "activate")


func _on_Area2D_mouse_entered():
	canClick = true
	


func _on_Area2D_mouse_exited():
	canClick = false
	

func remove():
	Globals.items[id_name]["remove"] = true
	queue_free()
	#prob set it's global bit stuff as well.
	
func use():
	
	if Globals.activeItem == "":
		
		Globals.addDioBox(viewText)
		return

	showReactionText()
	
	if powerSignals.has(Globals.activeItem):
		emit_signal("powerSignal")
		
		if removeItemOnPower:
			Globals.removeItem(Globals.activeItem)
		
		remove()
	
	Globals.activeItem = ""
	
	
func showReactionText():
	if reactionText.has(Globals.activeItem):
		Globals.addDioBox(reactionText[Globals.activeItem])
	else:
		Globals.addDioBox(["You can't do that."])
	
	

func door():
	
	
	if keys.has(Globals.activeItem):
		unlockDoor()
		
		if removeItemOnPower:
			Globals.removeItem(Globals.activeItem)
			
	elif !keys.has(Globals.activeItem) and Globals.activeItem != "":
		showReactionText()
		return
		
		
	if doorLocked:
		Globals.addDioBox([doorLockedText])
	else:
		Globals.addDioBox([doorUseText])
		Globals.connect("dioBoxOver" ,self, "useDoor")
		
		


func activate():
	Globals.disconnect("playerDoneWalking" ,self, "activate")
	emit_signal("activateSignal")
	
	if itemType == "door":
		door()
		
	
	if itemType == "view":
		
		if Globals.activeItem != "":
			showReactionText()
			Globals.activeItem = ""
		
		else:	
			Globals.addDioBox(viewText)
	
	if itemType == "NPC":
		
		if Globals.activeItem != "":
			use()
		
		else:	
			Globals.addDioBox(viewText, npcFace.load_path, faceArray)
	
	if itemType == "pickup":
		
		if Globals.activeItem != "":
			showReactionText()
			return
		
		Globals.addDioBox(viewText) #The text is only shown when you pick it up, not when it's given
		pickup()
		
	if itemType == "useable":
		
		use()
		
	if itemType == "youtube":
		OS.shell_open("https://www.youtube.com/channel/UCp9Ma9QCchFfEmokJILwXEw")
		
	

	
func unlockDoor():
	doorLocked = false
	Globals.items[id_name]["doorLocked"] = false
	emit_signal("doorUnlock")
	
func lockDoor():
	doorLocked = true
	Globals.items[id_name]["doorLocked"] = true
	
func useDoor():
	Globals.disconnect("dioBoxOver", self, "useDoor")
	get_tree().change_scene(doorExit)


func pickup():
	
	Globals.addItem(id_name)
	remove()
	


func _on_lightTimer_timeout():
	$AnimationPlayer.play("flicker")
	
func disconnectFromPlayer():
	Globals.disconnect("playerDoneWalking" ,self, "activate")

func hideItem():
	self.hide()
	Globals.items[self.id_name]["remove"] = true
	
	
func showItem():
	self.show()
	Globals.items[self.id_name]["remove"] = false
	
func resetPosition():
	self.position = startPosition
