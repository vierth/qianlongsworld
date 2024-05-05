extends CharacterBody3D

@export var warp_location = Vector3(0,2,0)
@export var min_y : int = -20

@onready var neck = $Neck
@onready var cam = $Neck/Camera3D

var speed = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Specify if being observed
var observed = null
var talking = false

# set up mouse handling
func _unhandled_input(event):
	if event is InputEventMouseButton and not talking:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			cam.rotate_x(-event.relative.y * 0.01)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(90))
	if event.is_action_pressed("speed_up"):
		speed += 1
	if event.is_action_pressed("speed_down"):
		speed -= 1
		if speed < 0:
			speed = 0

	#if event.is_action_pressed("interact"):
		## check for what we are interacting with
		#
		#print(SqlController.get_item_data(1))

func _physics_process(delta):
	if GameState.map_active:
		return
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)

		if global_position.y < min_y:
			global_position = warp_location

		move_and_slide()

func _process(_delta):
	var coll = %RayCast3D.get_collider()
	
	if coll != observed:
		if coll != null:
			print(coll.get_parent().item.name)
		if observed != null :	
			pass
		observed = coll
		
func player():
	pass
