extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_button_down():
	SceneSwitcher.switch_scene("res://levels/main/main.tscn")

func _on_quit_button_button_down():
	get_tree().quit()

func _on_settings_button_button_down():
	SceneSwitcher.switch_scene("res://levels/GUI/settingsscreen/settings_screen.tscn")

func _on_credits_button_button_down():
	SceneSwitcher.switch_scene("res://levels/GUI/creditsscreen/credits_screen.tscn")
