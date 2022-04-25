extends Node


signal stopPlayer
signal startPlayer

signal disconnectAll

var inventory = []

var activeItem = ""

#Items built dynamically
var items = {}

signal updateInventory

signal getPath(start, end)
signal pathReady

signal movePlayer(pos)

signal playerDoneWalking

signal dioBoxOver

var path = []

func getPathTo(startPos, endPos):
	emit_signal("getPath", startPos, endPos)

var textInstance = load("res://Scenes/textBox.tscn")

signal addTextBox(arr, npcFace, faceArray)

var queuedDioBoxes = []


func addDioBox(textArray, face: String = "",faceArr: Array = []):
	
	emit_signal("addTextBox", textArray, face, faceArr)
	emit_signal("stopPlayer")
	
func addItem(id):
	
	inventory.append(id)
	emit_signal("updateInventory")
	
func removeItem(id):
	inventory.erase(id)
	emit_signal("updateInventory")
	activeItem = ""
	
func dioBoxOver():
	emit_signal("startPlayer")
	emit_signal("dioBoxOver")
	
func _ready():
	emit_signal("updateInventory")



func queueDioBox(textArray, face:String = "", faceArr: Array = []):
	queuedDioBoxes.append(textArray)
	queuedDioBoxes.append(face)
	queuedDioBoxes.append(faceArr)
	
func activateQueuedDio():
	if queuedDioBoxes.size() != 0:
		addDioBox(queuedDioBoxes[0])
		
	queuedDioBoxes.clear()
	
	
	
	
	
