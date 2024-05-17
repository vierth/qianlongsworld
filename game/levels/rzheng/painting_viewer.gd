extends Node

@onready var painting = $painting
########################
# EXPORT PARAMS
########################
# zoom
@export_range (0, 100, 0.5) var min_zoom:float = 1
@export_range (0, 100, 0.5) var max_zoom:float = 6
@export_range (0, 100, 0.5) var zoom_speed:float = 10

# pan
@export_range (0, 10, 0.5) var pan_speed:float = 2
@export var allow_zoom: bool = true
@export var allow_pan: bool = true


########################
# PARAMS
########################
# zoom
@onready var camera = $Camera2D
var zoom_direction = 0
var zoom_target:Vector2
# pan
var is_panning = false
var _last_mouse_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	zoom_target=camera.zoom
	#var image = GlobalSingleton.get_painting_image()
	var image=GlobalSingleton.painting_image
	if image != null:
		var img_size=image.get_size()
		var width=img_size[0]
		var height=img_size[1]
		var texture = ImageTexture.create_from_image(image)
		painting.set_texture(texture)
		set_sprite_size(height)
		
func _process(delta: float) -> void:
	#_move(delta)
	_zoom(delta)
	_pan()

func _input(event: InputEvent) -> void:
	# pan
	if event.is_action_pressed("camera_pan"):
		is_panning = true
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("camera_pan"):
		is_panning = false

func set_sprite_size(img_height):
	if img_height>900:
		painting.scale.x=900.0/img_height
		painting.scale.y=900.0/img_height

func _on_button_pressed():
	SceneSwitcher.switch_scene("res://levels/rzheng/dynamic_gallery_3d.tscn")

func _zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in") and zoom_target[0]<=max_zoom:
		zoom_target*=1.1
	if Input.is_action_just_pressed("camera_zoom_out") and zoom_target[0]>=min_zoom:
		zoom_target*=0.9
	camera.zoom=camera.zoom.slerp(zoom_target, zoom_speed*delta)
		

func _pan():
	if not allow_pan or not is_panning:
		return
	# get mouse speed
	var mouse_speed = _get_mouse_speed()
	camera.position=camera.position-mouse_speed*(1/camera.zoom.x)
		
func _get_mouse_speed() -> Vector2:
	# calculate speed
	var current_mouse_pos = get_viewport().get_mouse_position()
	var mouse_speed = current_mouse_pos - _last_mouse_position
	# update last click position
	_last_mouse_position = current_mouse_pos
	# return speed
	return mouse_speed
