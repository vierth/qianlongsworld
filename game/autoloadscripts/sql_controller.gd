extends Node

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path = "res://data/data.db"
	database.open_db()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_item_data(item_id):
	return database.select_rows("items", "ID = " + str(item_id), 
	["*"])[0]
