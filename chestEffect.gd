extends AnimatedSprite


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	play("Animate")

func _on_animation_finished():
	queue_free()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://WinMenu.tscn")

#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
