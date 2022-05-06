extends Node2D

var itemInstance = load("res://Scenes/item.tscn")

func _ready():
	print("loaded")
	Globals.connect("updateInventory", self, "updateInventory")
	
	Globals.connect("hideUI", self, "hide")
	Globals.connect("showUI", self, "show")


func updateInventory():
	

	clearChildren()
	
	var spacing = 0
	for item in Globals.inventory:
		var nItem = itemInstance.instance()
		nItem.itemType = "inventory"
		nItem.id_name = item
		nItem.image = Globals.items[item]["image"]
		nItem.position.y = 50
		nItem.position.x = (100 * spacing) + 50
		
		spacing += 1
		self.add_child(nItem)
		print("added",item)
	
func clearChildren():
	for child in get_child_count():
		get_child(child).queue_free()
		

		

	
