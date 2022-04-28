extends Node2D


var sceneDestination = ""
var Name = ""

signal pressed

func _ready():
	$RichTextLabel.text = Name


func _on_travel_pressed():
	emit_signal("pressed")
	get_tree().change_scene(sceneDestination)
