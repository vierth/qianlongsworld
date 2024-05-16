extends Node

var painting_image
var list_of_paintings=["https://ids.lib.harvard.edu/ids/iiif/51634639/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-8280_01/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-6210_03/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-8013_12/full/full/0/default.jpg",
"https://ids.si.edu/ids/iiif/FS-8015_04/full/full/0/default.jpg"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_painting_image(img):
	painting_image=img
