extends Node2D

var musicToPlay = ""

var musicPlaying = false

func _ready():
	startMusic()
	


func startMusic():
	$AudioStreamPlayer.play()
	musicPlaying = true
	
func stopMusic():
	$AudioStreamPlayer.stop()
	musicPlaying = false
	
func changeMusic(songID):
	musicToPlay = songID
	
	if songID == $AudioStreamPlayer.stream.resource_path:
		return
	
	$AnimationPlayer.play("switchSong")
	

	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "switchSong":
		$AudioStreamPlayer.stream = load(musicToPlay)
		startMusic()
		$AnimationPlayer.play("startNewSong")
	
