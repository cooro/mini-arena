extends Node2D

var game_over
var game_phase
var player_node
var mob_container
var item_container
var rng
var score
var unlocked_mobs
var unlocked_items
var spawn_counter

func _ready():
	scale = Vector2(Global.global_scale_factor, Global.global_scale_factor)
	game_over = false
	game_phase = 0
	player_node = get_node("Player")
	mob_container = get_node("Mobs")
	item_container = get_node("Items")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	score = 0
	unlocked_mobs = []
	unlock_new_feature(Global.mob_unlock_order[0], Global.mob_dictionary, unlocked_mobs)
	unlocked_items = []
	unlock_new_feature(Global.item_unlock_order[0], Global.item_dictionary, unlocked_items)
	spawn_counter = Global.spawn_counter_max


func _process(_delta):
	if game_phase == 0:		# player movement
		player_node.set_action_allowed()
		game_phase += 1
		
	elif game_phase == 2:	# item detection
		for i in item_container.get_children():
			if get_player_vector(i) == Vector2(0, 0):
				i.switch_weapon()
				i.queue_free()
		if spawn_counter <= 0:
			spawn_feature(unlocked_items, item_container, Global.arena_floor)
		game_phase += 1
		
	elif game_phase == 3:	# mob movement
		for i in mob_container.get_children():
			i.move_mob(get_player_vector(i))
		if spawn_counter <= 0:
			spawn_feature(unlocked_mobs, mob_container, Global.arena_edges)
			spawn_counter = Global.spawn_counter_max
		game_phase += 1
		
	elif game_phase == 4:	# check for game over
		if game_over:
			end_game()
		game_phase = 0


# Returns a vector from the given origin node to the player node.
func get_player_vector(origin):
	return player_node.position - origin.position


# Selects a random mob from the unlocked mobs array, and spawns it.
func spawn_feature(spawn_pool: Array, container: Node, spawn_locations: Array = [Vector2(0, 0)]):
	var rand_int = rng.randi() % spawn_pool.size()
	var selected_feature_name = spawn_pool[rand_int]
	var selected_feature = load("res://" + selected_feature_name + ".tscn")
	var selected_feature_instance = selected_feature.instance()
	container.add_child(selected_feature_instance, true)
	selected_feature_instance.position = spawn_locations[rng.randi() % spawn_locations.size()]
	print("New " + selected_feature_name + " spawned.")


# Finds a key with the given name in the given dict, and adds it to the given
#  spawn pool a number of times according to its spawn weight.
func unlock_new_feature(feature_name: String, dict: Dictionary, spawn_pool: Array):
	for _i in range(dict[feature_name]):
		spawn_pool.append(feature_name)


# Records your score and loads the game over scene.
func end_game():
	pass


# Signal from the Player node triggers this to advance the game after the player
#  has taken an action.
func _on_Player_end_player_turn():
	spawn_counter -= 1
	game_phase += 1
