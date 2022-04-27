extends Area2D

var player = null 

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null


#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
