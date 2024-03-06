extends Node3D

@export var item:BaseInfo

var targeted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = item.scene.instantiate()
	add_child(instance) # Replace with function body.

