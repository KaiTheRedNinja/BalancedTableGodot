extends Area2D

signal clicked(selected: bool)

var isSelected = false

var isHovering = false

var screen_size
var self_size = Vector2(400, 100)

func changeSelectionStatus(selected: bool):
	isSelected = selected
	scale = get_selection_based_scale()

func get_selection_based_scale():
	var selectionMultiplier
	var hoveringMultiplier
	
	if isSelected:
		selectionMultiplier = 1.3
		hoveringMultiplier = (0.95 if isHovering else 1)
	else:
		selectionMultiplier = 1
		hoveringMultiplier = (1.1 if isHovering else 1)
	
	return Vector2.ONE * selectionMultiplier * hoveringMultiplier

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _mouse_enter():
	isHovering = true
	scale = get_selection_based_scale()

func _mouse_exit():
	isHovering = false
	scale = get_selection_based_scale()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		isHovering = false
		scale = get_selection_based_scale()
		clicked.emit(isSelected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
