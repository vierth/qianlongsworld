extends Area

var player_in_area = false
var text_box_visible = false

# Reference to the text box
onready var text_box = $CanvasLayer/Panel

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	text_box.visible = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		toggle_text_box()

func _on_body_entered(body):
	if body.name == "Player":  # Assuming your player node is named "Player"
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func toggle_text_box():
	text_box_visible = not text_box_visible
	text_box.visible = text_box_visible
