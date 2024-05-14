extends Node3D

# zoom
@export_range (0, 100, 0.5) var min_zoom: float = 3
@export_range (0, 100, 0.5) var max_zoom: float = 20
@export_range (0, 100, 0.5) var zoom_speed: float = 20
@export_range (0, 1, 0.05) var zoom_speed_damp: float = 0.8
@export var allow_zoom: bool = true
@export var zoom_to_curser: bool = false

@onready var neck = $"."
@onready var player = $"../PlayerMesh"
@onready var player_collision=$"../CollisionShape3D"
var zoom_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_zoom(delta)

func _input(event: InputEvent) -> void:
	# zoom
	if event.is_action_pressed("camera_zoom_in"):
		zoom_direction = -1
	if event.is_action_pressed("camera_zoom_out"):
		zoom_direction = 1
		
func _zoom(delta: float) -> void:
	if not allow_zoom or not zoom_direction:
		return
		
	var new_zoom = clamp(
		neck.position.z + zoom_direction * zoom_speed * delta,
		min_zoom,
		max_zoom
	)
	neck.position.z=new_zoom
	player.position.z=new_zoom
	player_collision.position.z=new_zoom
	zoom_direction=0
	

