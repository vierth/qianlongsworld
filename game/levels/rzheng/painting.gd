extends Node3D

@onready var canvas_mesh: MeshInstance3D = $painting
var list_of_paintings=["https://ids.lib.harvard.edu/ids/iiif/51634639/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-8280_01/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-6210_03/full/full/0/default.jpg", 
"https://ids.si.edu/ids/iiif/FS-8013_12/full/full/0/default.jpg",
"https://ids.si.edu/ids/iiif/FS-8015_04/full/full/0/default.jpg"]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var image=GlobalSingleton.painting_image
	if image != null:
		var img_size=image.get_size()
		var width=img_size[0]
		var height=img_size[1]

		var mesh_size=self.get_size_for_mesh(width, height)
		canvas_mesh.mesh.size[0]=mesh_size[0]
		canvas_mesh.mesh.size[1]=mesh_size[1]
			
		print(canvas_mesh.mesh.size)
			
		var texture = ImageTexture.create_from_image(image)
		var material: BaseMaterial3D = canvas_mesh.get_active_material(0)
		material.albedo_texture = texture		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_http_request_request_completed(result, response_code, headers, body):
	print("request complete!")
	if result != HTTPRequest.RESULT_SUCCESS or response_code > 299:
		push_error("Failed to get image")
		return
	
	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	if error != OK:
		push_error("Failed to load image")
		return
		
	GlobalSingleton.set_painting_image(image)
	
	var img_size=image.get_size()
	var width=img_size[0]
	var height=img_size[1]
	
	var mesh_size=self.get_size_for_mesh(width, height)
	canvas_mesh.mesh.size[0]=mesh_size[0]
	canvas_mesh.mesh.size[1]=mesh_size[1]
		
	print(canvas_mesh.mesh.size)
		
	var texture = ImageTexture.create_from_image(image)
	var material: BaseMaterial3D = canvas_mesh.get_active_material(0)
	material.albedo_texture = texture		

func show_new_painting():
	var http = get_node("HTTPRequest")
	http.set_use_threads(true)
	if GlobalSingleton.list_of_paintings.size()==0:
		print("You have seen all the paintings")
		return
	var my_random_number = rng.randi_range(0, GlobalSingleton.list_of_paintings.size()-1)
	print("painting number selected: ", my_random_number)
	http.request(GlobalSingleton.list_of_paintings[my_random_number])
	GlobalSingleton.list_of_paintings.remove_at(my_random_number)
	
func get_size_for_mesh(img_width, img_height):
	var mesh_width=3
	var mesh_height=3

	if img_width>img_height:
		mesh_width=3
		mesh_height=(img_height *3.0)/img_width
	elif img_height>img_width:
		mesh_width=(img_width*3.0)/img_height
		mesh_height=3
	return [mesh_width, mesh_height]
	
func switch_mode():
	SceneSwitcher.switch_scene("res://levels/rzheng/painting_viewer.tscn")
	
