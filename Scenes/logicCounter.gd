extends Node2D


export var value = 0
export var targetValue = 1

export (Array, String) var order

signal True

var startingVal

func _ready():
	startingVal = value

func getName(na):
	
	print("ayo")
	
	if order[value] == na:
		addOne()
	else:
		reset()


func addOne():
	value += 1
	check()
	
func subtractOne():
	value -= 1
	check()
	
func reset():
	value = startingVal
	
func check():
	print("checking..")
	if value == targetValue:
		emit_signal("True")
		print("passed!")

