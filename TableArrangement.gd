extends Node2D

@export var table_scene: PackedScene
@export var seat_scene: PackedScene
var score

var selectedSeat: int = -1
var seats = []

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
		newSeat.clicked.connect(
			Callable(_on_seat_click)
				.bind(index))
		add_child(newSeat)
		seats.append(newSeat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_seat_click(selected: bool, index: int):
	print("Seat ", index, " clicked!")
	if selectedSeat == -1: # no seat was selected, select this seat
		selectedSeat = index
		seats[index].changeSelectionStatus(true)
	elif index == selectedSeat: # this seat was selected, unselect this seat
		selectedSeat = -1
		seats[index].changeSelectionStatus(false)
	else: # another seat was selected, swap them
		print("Swapping ", selectedSeat, " and ", index)
		seats[index].changeSelectionStatus(false)
		seats[selectedSeat].changeSelectionStatus(false)
		selectedSeat = -1
