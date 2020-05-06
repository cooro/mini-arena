extends Area2D

var item_name = ""
var hit_tiles
var damage_amount = 1


func switch_weapon():
	Global.holding_item_name = item_name
	Global.holding_damage_amount = damage_amount
	Global.holding_hit_tiles = hit_tiles
