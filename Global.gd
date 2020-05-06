extends Node

var holding_item_name = ""		# item player is holding
var holding_damage_amount = 0	# damage value of held item
var holding_hit_tiles = []		# which tiles item can attack

const tile_distance = 10		# distance between tiles
const grid_size = 5			# size of the field in tiles
var global_scale_factor		# used for scaling assets to different sizes

var spawn_counter_max = 3				# number of turns between spawns

const mob_dictionary = {"Goblin":3, "Imp":2}	# list of all the mobs, and their spawn weight
const mob_unlock_order = ["Goblin", "Imp"]	# new enemies are unlocked in this order

const item_dictionary = {"Dagger":3}
const item_unlock_order = ["Dagger"]

var arena_edges = []
var arena_floor = []

func _ready():
	global_scale_factor = calc_scale_factor()
	var grid_steps = calc_grid_steps(grid_size, tile_distance)
	arena_floor = calc_arena_floor(grid_steps, grid_steps)
	arena_edges = calc_arena_edges(arena_floor)


func calc_grid_steps(grid_size: int, tile_width: int):
	var return_array = []
	for i in range(grid_size):
		return_array.append( (1+i)*tile_width - (tile_width/2.0) )
	return return_array


func calc_arena_floor(x_vals: Array, y_vals: Array):
	var return_array = []
	for i in x_vals:
		for j in y_vals:
			return_array.append(Vector2(i, j))
	return return_array


func calc_arena_edges(arena_floor: Array):
	var return_array = []
	for i in arena_floor:
		if i.x == arena_floor.min().x or i.x == arena_floor.max().x:
			return_array.append(i)
		elif i.y == arena_floor.min().y or i.y == arena_floor.max().y:
			return_array.append(i)
	return return_array


func set_holding_vars_to_default():
	holding_item_name = ""
	holding_damage_amount = 0
	holding_hit_tiles = []

func calc_scale_factor():
	var viewport_size = get_viewport().get_visible_rect().size
	if viewport_size.x > viewport_size.y:
		return viewport_size.y / (tile_distance * grid_size)
	else:
		return viewport_size.x / (tile_distance * grid_size)
