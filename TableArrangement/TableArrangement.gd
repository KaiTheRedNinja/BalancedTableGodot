extends Node2D

const cellWidth = 100

@export var table_scene: PackedScene
@export var seat_scene: PackedScene
@export var character_scene: PackedScene
var score

var selectedChar = null

## Characters mapped to their seats
var characters = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	setupTable()

# The position for a table, relative to the screen
func positionForTable(tableIndex: int):
	# To break down the magic value
		# 2 -> Position of the first table from the center
		# 4 -> Number of cells lower the second table is from the first
		# -4*tableIndex -> 0 if table index is 0, -4 if table index is 1
	return Vector2(0, (2-4*tableIndex) * cellWidth)

# The position for a seat, relative to the position of the table
func positionForSeat(seatIndex: int):
	var height = (-1 if seatIndex < 4 else 1)*cellWidth
	var width = (-1.5*cellWidth) + seatIndex%4 * cellWidth
	return Vector2(width, height)

func setupTable():
	var screen_size = get_viewport_rect().size
	var centerPos = (screen_size) /2
	for tableIndex in range(2):
		var table = table_scene.instantiate()
		# we subtract it here so that index 0 is above index 1
		var tablePos = centerPos - positionForTable(tableIndex)
		table.position = tablePos
		add_child(table)
		
		for seatIndex in range(8):
			var newSeat = seat_scene.instantiate()
			newSeat.position = tablePos + positionForSeat(seatIndex)
			newSeat.clicked.connect(
				Callable(_on_seat_click)
					.bind(seatIndex + tableIndex*8))
			add_child(newSeat)
	
	var character = character_scene.instantiate()
	add_child(character)
	characters[0] = -1
	selectedChar = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func moveCharacterToSeat(character: int, seat: int):
	print("Moving character ", character, " to ", seat)
	# remove character from old seat
	# add character to new seat

func _on_seat_click(index: int):
	print("Seat ", index, " clicked!")
	# determine the character inside the seat
	var seatCharacter = characters.find_key(index)
	
	# if character doesn't exist at the seat
	if seatCharacter == null:
		# if no character is selected, do nothing
		if selectedChar == null:
			print("No character selected")
		# if a character *is* selected, move that character to this seat
		else:
			print("Moving character ", selectedChar, " to empty seat ", index)
			moveCharacterToSeat(selectedChar, index)
			selectedChar = null
	# if a character does exist at the seat
	else:
		# if no character was previously selected, select this character
		if selectedChar == null:
			print("Selecting character ", seatCharacter)
			selectedChar = seatCharacter
		# if a character was previously selected, perform a swap
		else:
			print("Swapping ", seatCharacter, " and ", selectedChar)
			# move this seat's character to the selected character's seat
			moveCharacterToSeat(seatCharacter, characters[selectedChar])
			# move selected character to this seat
			moveCharacterToSeat(selectedChar, index)
			selectedChar = null
