extends Area2D

#Variables
export(bool) var show_hit = true
const HitEffect = preload("res://HitEffect.tscn")
var invincible = false setget set_invincible
onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

#Signals
signal invincibility_started
signal invincibility_ended

#Invincibility when hit
func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_started():
	collisionShape.set_deferred("disabled", true)


func _on_HurtBox_invincibility_ended():
	collisionShape.disabled = false

#Hit Effect
func _on_HurtBox_area_entered(_area):
	if show_hit:
		var effect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position 



#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
