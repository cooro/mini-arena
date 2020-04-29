extends KinematicBody2D



func _ready():
	pass


func _process(delta):
	match get_input():
		1:
			# todo
		2:
			# todo
		3:
			# todo
		4:
			# todo
		_:
			# todo


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
	else:
		return 0
