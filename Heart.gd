extends Node2D

var stats = PlayerStats


func _on_HurtBox_area_entered(_area):
	queue_free()
	if stats.health < 4:
		stats.health += 1



#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
