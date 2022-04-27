extends Node2D

export(int) var wander_range = 10
onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

#Gets enemy to move randomly

func _ready():
	update_target_position()

func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector
	
func get_time_left():
	return timer.time_left
	
func start_wander_timer(duration):
	timer.start(duration)
	
func _on_Timer_timeout():
	update_target_position()


#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
