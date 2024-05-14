extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_button_button_down():
	SceneSwitcher.switch_scene("res://levels/GUI/titlescreen/title_screen.tscn")
