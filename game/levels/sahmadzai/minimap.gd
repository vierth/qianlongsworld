extends CanvasLayer

@onready var player_node = owner.find_child("Player", true)
@onready var neck_node = player_node.find_child("Neck", true)  # Access the "Neck" node
@onready var player_marker = get_node("SubViewportContainer/SubViewport/PlayerMarker")
@onready var subViewport = get_node("SubViewportContainer/SubViewport")
@onready var textureRect = get_node("SubViewportContainer/SubViewport/TextureRect")
@onready var terrain_node = owner.find_child("terrain_mesh", true)  # Ensure accurate path
var texture_size = Vector2(100, 100)  # Default fallback size, adjust as needed
var subViewport_size = Vector2(200, 200)  # Default fallback size, adjust as needed
var terrain_size_x = 0
var terrain_size_y = 0

func _ready():
	# Ensure the TextureRect has a valid texture assigned
	if textureRect.texture:
		texture_size = textureRect.texture.get_size()
		print("Texture size is: ", texture_size)

	# Ensure the SubViewport has a valid size assigned
	if subViewport.size:
		subViewport_size = subViewport.size
		print("Viewport size is: ", subViewport_size)

	# Check if the terrain node has valid size data
	if terrain_node:
		# Get the bounding box of the terrain mesh
		var aabb = terrain_node.get_aabb()
		terrain_size_x = aabb.size.x
		terrain_size_y = aabb.size.z  # Note: Z-axis for Y-coordinate mapping
		print("Terrain size is: ", terrain_size_x, " x ", terrain_size_y)

func _process(_delta):
	if player_node and neck_node and terrain_node:
		# Get player's 3D position
		var player_position = player_node.global_transform.origin
		#print("Player position is: ", player_position)

		# Map the player's 3D coordinates to 2D map coordinates
		var map_scale_x = texture_size.x / terrain_size_x
		var map_scale_y = texture_size.y / terrain_size_y

		var map_x = clamp(-player_position.x * map_scale_x, -texture_size.x, 0)
		var map_y = clamp(-player_position.z * map_scale_y, -texture_size.y, 0)

		# Center TextureRect to match player's movement
		var map_position = Vector2(map_x + subViewport_size.x / 2, map_y + subViewport_size.y / 2)
		textureRect.position = clamp_position(map_position, texture_size, subViewport_size)

		# Get the Y-axis rotation from the Neck node
		var neck_rotation = neck_node.global_transform.basis.get_euler().y

		# Check if map is near its bounds on each axis
		var x_at_bounds = map_position.x != clamp_position(map_position, texture_size, subViewport_size).x
		var y_at_bounds = map_position.y != clamp_position(map_position, texture_size, subViewport_size).y
		
		if x_at_bounds and y_at_bounds:
			# Move marker freely along both axis if map is at its bounds
			var marker_x = map_x
			var marker_y = map_y
			player_marker.position = Vector2(-marker_x, -marker_y)
			#print("At both bounds")
		elif x_at_bounds:
			# Move marker freely along x axis if map is at its x bound
			var marker_x = map_x
			player_marker.position = Vector2(-marker_x, subViewport_size.y / 2)
			#print("At x bound")
		elif y_at_bounds:
			# Move marker freely along y axis if map is at its x bound
			var marker_y = map_y
			player_marker.position = Vector2(subViewport_size.x / 2, -marker_y)
			#print("At y bound")
		else:
			# Keep marker centered on both axis if not at either bound
			player_marker.position = Vector2(subViewport_size.x / 2, subViewport_size.y / 2)

		# Rotate the marker to match the player's neck rotation
		player_marker.rotation = -neck_rotation
	else:
		printerr("Player node, Neck node, or Terrain node not found.")

func clamp_position(pos, _texture_size, _subViewport_size):
	# Clamp map position to remain within texture's size
	var clamped_x = clamp(pos.x, -_texture_size.x + _subViewport_size.x, 0)
	var clamped_y = clamp(pos.y, -_texture_size.y + _subViewport_size.y, 0)
	return Vector2(clamped_x, clamped_y)
