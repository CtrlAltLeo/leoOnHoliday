extends KinematicBody2D

var animation = "up"

var canMove = true

var targetPos = Vector2()

var targetItemPath = ""

var path = []
var pathPoint = 0

var moving = false

var speed = 200

var flipSprite = false

func _ready():
	changeSize()
	Globals.connect("pathReady", self, "startDestination")
	Globals.connect("movePlayer", self, "setDestination")
	Globals.connect("stopPlayer", self, "disallowMove")
	Globals.connect("startPlayer", self, "allowMove")

signal atPos(pos)

func setDestination(pos):
	if canMove:
		Globals.getPathTo(self.position, pos)


	

func startDestination():
	print("starting")
	moving = true
	path = Globals.path
	pathPoint = 1

	
	
func moveTo():
	
	changeSize()
	
	var direction = path[pathPoint] - position
	
	targetPos = path[pathPoint]
	
	direction = direction.normalized()
	
	if targetPos.x > position.x:
		flipSprite = true
	else:
		flipSprite = false
	
	if position.distance_to(path[pathPoint]) < 3:
		
		if pathPoint + 1 < path.size():
			pathPoint += 1
			
			
		else:
			moving = false
			print("here")
			Globals.emit_signal("playerDoneWalking")
	
	
	move_and_slide(direction * speed)
	
	
func changeAnimation():
	pass
	
func changeSize():
	$AnimatedSprite.scale.x = position.y / 400
	$AnimatedSprite.scale.y = position.y / 400

	
	
func _process(delta):
	
	

	
	
	if moving:
		moveTo()
		
	animate()
		
func allowMove():
	canMove = true

func disallowMove():
	canMove = false
	

func animate():
	
	
	$AnimatedSprite.flip_h = flipSprite
	
	if moving:
		$AnimatedSprite.animation = "walk"
	else:
		$AnimatedSprite.animation = "idle"
		
	
		
		

