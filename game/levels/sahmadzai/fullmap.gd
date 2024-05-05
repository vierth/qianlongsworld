extends CanvasLayer

@onready var player_node = owner.find_child("Player", true)
@onready var neck_node = player_node.find_child("Neck", true)  # Access the "Neck" node
@onready var terrain_node = owner.find_child("terrain_mesh", true)  # Ensure accurate path
@onready var map_overlay = get_node("ColorRect")  # Transparent background
@onready var full_map = get_node("TextureRect")  # Full-screen map
@onready var player_marker = get_node("/root/game_tile/MiniMap/SubViewportContainer/SubViewport/PlayerMarker")
@onready var full_player_marker = get_node("PlayerMarker")

var terrain_size_x = 0
var terrain_size_y = 0

var full_screen_map_visible = false

func _ready():
	# Ensure everything starts hidden
	map_overlay.visible = false
	full_map.visible = false
	full_player_marker.visible = false

	if terrain_node:
		# Get the bounding box of the terrain mesh
		var aabb = terrain_node.get_aabb()
		terrain_size_x = aabb.size.x
		terrain_size_y = aabb.size.z  # Note: Z-axis for Y-coordinate mapping
		print("Terrain size is: ", terrain_size_x, " x ", terrain_size_y)

func _input(event):
	# Toggle full-screen map on pressing "toggle_map"
	if event.is_action_pressed("toggle_map"):
		full_screen_map_visible = not full_screen_map_visible
		GameState.map_active = full_screen_map_visible  # Update map_active based on map visibility
		toggle_map_visibility(full_screen_map_visible)

func toggle_map_visibility(_visible):
	# Set the visibility of the map overlay and content
	map_overlay.visible = _visible
	full_map.visible = _visible
	full_player_marker.visible = _visible

func _process(_delta):
	if full_screen_map_visible:
		# Update map and marker positions
		full_player_marker.position = get_player_marker_position()
		print("Player Position", full_player_marker.position)
		full_player_marker.rotation = player_marker.rotation  # Match rotation

func get_player_marker_position():
	# Retrieve the player's current position and map it to the full-screen coordinates
	var player_position = player_node.global_transform.origin
	var map_scale_x = (full_map.texture.get_size().x / terrain_size_x) / 2
	var map_scale_y = (full_map.texture.get_size().y / terrain_size_y) / 2

	# Map the player's 3D position to 2D coordinates directly
	var map_x = player_position.x * map_scale_x
	var map_y = player_position.z * map_scale_y  # Use Z-axis for Y-coordinate mapping

	# Clamp to ensure coordinates stay within valid range
	map_x = clamp(map_x, 0, full_map.texture.get_size().x) + 296
	map_y = clamp(map_y, 0, full_map.texture.get_size().y)

	return Vector2(map_x, map_y)
