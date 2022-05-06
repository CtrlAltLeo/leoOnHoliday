extends Node2D


export(String) var targetArea

export(Array, String) var text

export(AudioStreamMP3) var cutsceneMusic

func _ready():
	
	Globals.hideUI()
	
	if cutsceneMusic != null:
		MusicBox.changeMusic(cutsceneMusic.resource_path)
	
	if Globals.cutscenesPlayed.has(self.name):
		
		get_tree().change_scene(targetArea)
		Globals.cutscenesPlayed.append(self.name)
		
		
	startAnimation()

func startAnimation():
	$AnimationPlayer.play("cutScene")
	




func _on_AnimationPlayer_animation_finished(anim_name):
	Globals.showUI()
	get_tree().change_scene(targetArea)
