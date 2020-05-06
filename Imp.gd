extends Area2D

var damage_amount
var health

var tile_distance

func _ready():
	damage_amount = 1
	health = 1
	
	tile_distance = Global.tile_distance

# This is the mob's AI
func move_mob(player_vector):
	print(get_name() + ": ", player_vector)
	if player_vector.x < 0:
		position.x -= tile_distance # move west
	elif player_vector.x > 0:
		position.x += tile_distance # move east
	elif player_vector.y < 0:
		position.y -= tile_distance # move north
	elif player_vector.y > 0:
		position.y += tile_distance # move south
