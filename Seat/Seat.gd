## Seats are the things that the user actually interacts with. They do not change
## size, but they signal whenever they are clicked, and hover on interact.
##
## This is because players can be swapped into empty seats, so empty seats need
## to be interactable.

extends Area2D

signal clicked()

var isHovering = false

var screen_size
var self_size = Vector2(400, 100)

func get_selection_based_scale():
	return Vector2.ONE * (1.1 if isHovering else 1)

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
		clicked.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
