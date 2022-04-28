extends Node2D

export var Name = ""
export var location = ""



func _ready():
	if Globals.fastTravels.has(Name):
		return
		
	Globals.fastTravels[Name] = location
