extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print(get_parent().name)
	for o in get_parent().get_node("YSort").get_children():
		if o.get_class() == "Squad" :
			o.AllFire()
	pass # Replace with function body.
