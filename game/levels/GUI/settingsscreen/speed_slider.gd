extends HSlider

@onready var slider = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	slider.value = Settings.player_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_value_changed(value):
	slider.value = value
