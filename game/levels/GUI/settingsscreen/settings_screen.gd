extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_button_button_down():
	SceneSwitcher.switch_scene("res://levels/GUI/titlescreen/title_screen.tscn")

func _on_speed_slider_value_changed(value):
	Settings.player_speed = value

func _on_mouse_sens_slider_value_changed(value):
	Settings.mouse_sensitivity = value
