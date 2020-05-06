extends KinematicBody2D

var tile_distance
var monster_colliding
var action_allowed
signal end_player_turn

func _ready():
	tile_distance = Global.tile_distance
	monster_colliding = false
	action_allowed = true


func _process(delta):
	var old_pos = position
	var action_taken = false
	
	if action_allowed:
		# Movement
		if Input.is_action_just_pressed('ui_left'):
			position.x -= tile_distance
			if monster_colliding: position.x += tile_distance
			action_taken = true
		if Input.is_action_just_pressed('ui_right'):
			position.x += tile_distance
			if monster_colliding: position.x -= tile_distance
			action_taken = true
		if Input.is_action_just_pressed('ui_up'):
			position.y -= tile_distance
			if monster_colliding: position.y += tile_distance
			action_taken = true
		if Input.is_action_just_pressed('ui_down'):
			position.y += tile_distance
			if monster_colliding: position.y -= tile_distance
			action_taken = true
		if Input.is_action_pressed("ui_accept"):
			action_taken = true
	
	if action_taken:
		end_action()


func end_action():
	action_allowed = false
	emit_signal("end_player_turn")

func set_action_allowed():
	action_allowed = true

func get_input():
	# Movement
	if Input.is_action_just_pressed('ui_left'):
		return 1
	if Input.is_action_just_pressed('ui_right'):
		return 2
	if Input.is_action_just_pressed('ui_up'):
		return 3
	if Input.is_action_just_pressed('ui_down'):
		return 4
	if Input.is_action_just_pressed('ui_accept'):
		return 5
	else:
		return 0

