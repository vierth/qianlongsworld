extends Area3D

@export_file var destination_scene : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(_body):
	SceneSwitcher.switch_scene(destination_scene)
