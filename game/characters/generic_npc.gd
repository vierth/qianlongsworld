extends CharacterBody3D

var player_detected = false

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)

func _process(_delta):
	if player_detected:
		if Input.is_action_just_pressed("interact"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			player_detected.talking = true
			run_dialogue("dufufanIntro")


func _on_area_3d_body_entered(body):
	if body.has_method("player"):
		player_detected = body
		print("I've found the player!") # Replace with function body.



func _on_area_3d_body_exited(body):
	if body.has_method("player"):
		print('player exited area')
		player_detected = false
	 # Replace with function body.

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg):
	print('singal fire')
	print(player_detected)
	if arg == "exit":
		
		player_detected.talking = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

