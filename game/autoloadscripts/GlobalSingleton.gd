extends Node

var painting_image
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_painting_image():
	return painting_image
	
func set_painting_image(img):
	painting_image=img
