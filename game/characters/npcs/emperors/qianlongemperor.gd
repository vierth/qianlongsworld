extends CharacterBody3D
# adapted from https://www.youtube.com/watch?v=Tmy1tzhDLl4

var player_detected = false

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)

func _process(_delta):
	if player_detected:
		if Input.is_action_just_pressed("interact"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			player_detected.talking = true
			print(player_detected.talking)
			run_dialogue("qianlongIntro")

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		print("player entered my space")
		player_detected = body

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		print("player existed area")
		player_detected = false # Replace with function body.

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg):
	if arg == "qianlong_exit":
		player_detected.talking = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
