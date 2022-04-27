extends Node2D

#Loads Effect
const PotEffect = preload("res://PotEffect.tscn")

#Creats an instance of the effect
func create_pot_effect():
	var potEffect = PotEffect.instance()
	var world = get_tree().current_scene
	world.add_child(potEffect)
	potEffect.global_position = global_position


func _on_HurtBox_area_entered(_area):
	create_pot_effect()
	queue_free()
	

#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
