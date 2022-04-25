extends Node2D




func _on_play_pressed():
	get_tree().change_scene("res://Rooms/prison1.tscn")
	


func _on_openBugDocs_pressed():
	OS.shell_open("https://docs.google.com/spreadsheets/d/1OA5jKAkkByk4k5n2hO_05w-adQVDrBiXX1nGZGr0Cxc/edit?usp=sharing")
