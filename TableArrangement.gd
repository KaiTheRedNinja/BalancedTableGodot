extends Node2D

@export var table_scene: PackedScene
@export var seat_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	setupTable()

func setupTable():
	var screen_size = get_viewport_rect().size
	var table = table_scene.instantiate()
	var tablePos = (screen_size) /2
	table.position = tablePos
	add_child(table)
	
	const cellWidth = 100
	for index in range(8):
		# this is relative to the position of the table
		var height = (-1 if index < 4 else 1)*cellWidth
		var width = (-1.5*cellWidth) + index%4 * cellWidth
		var newSeat = seat_scene.instantiate()
		newSeat.position = tablePos + Vector2(width, height)
		add_child(newSeat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
