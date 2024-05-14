extends Node3D

@onready var is_entered=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_3d_body_entered(body):
	is_entered=true
	

func _on_area_3d_body_exited(body):

	is_entered=false
	
func get_is_entered():
	return is_entered
