extends Node2D

#Loads chest effect
const ChestEffect = preload("res://chestEffect.tscn")

#Creates an instance of the effect
func create_chest_effect():
	var chestEffect = ChestEffect.instance()
	var world = get_tree().current_scene
	world.add_child(chestEffect)
	chestEffect.global_position = global_position


#Activates the effect when chest is hit
func _on_HurtBox_area_entered(_area):
	create_chest_effect()
	

#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
