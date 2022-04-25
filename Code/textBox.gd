extends Node2D


var text = []
var active = 0

var canSee = -1
var over = false

var hasFaces = false
var faceToText = []
var npcFace = ""
var playerFace = "res://Images/Portraits/leoPortrait.png"


func _ready():
	if hasFaces:
		$portrait.show()
	
	start()
	

func start():
	restart()
	
	changeFace()
	
	$RichTextLabel.text = text[active]
	
	$canSeeTimer.start()
	
	
func restart():
	canSee = -1
	over = false
	active = 0
	
func nextPage():
	
	$RichTextLabel.visible_characters = 0
	canSee = 0
	over = false
	active+= 1
	$RichTextLabel.text = text[active]
	$canSeeTimer.start()
	
	changeFace()


func _on_canSeeTimer_timeout():
	canSee += 1
	$RichTextLabel.visible_characters = canSee
	
	if canSee == text[active].length():
		over = true
		return
		
	$canSeeTimer.start()
	
func seeAllText():
	canSee = text[active].length()
	$RichTextLabel.visible_characters = canSee
	
func close():
	
	Globals.dioBoxOver()
	
	queue_free()
	print("goneb")
	
func _process(delta):
	
	if Input.is_action_just_pressed("leftClick"):
		
		if over:
			
			if active + 1 < text.size():
				nextPage()
			else:
				close()
				
		else:
			seeAllText()
			over = true
			

func changeFace():
	
	if hasFaces == false:
		return
	
	
	
	if faceToText[active] == 1:
		$portrait.texture = load(playerFace)
		print("player")
	else:
		$portrait.texture = load(npcFace)
		print("npcFace")
