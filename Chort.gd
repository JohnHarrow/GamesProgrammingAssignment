extends KinematicBody2D

#Variables
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4
var motion = Vector2()
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var player_facing_right = true
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var hurtbox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

#State Machine variables
enum {
	IDLE,
	WANDER,
	CHASE
}
var state = CHASE

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	#Knockback + Gravity
	if Input.is_action_pressed("right"):
		player_facing_right = true
	if Input.is_action_pressed("left"):
		player_facing_right = false	
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	motion = move_and_slide(motion, UP)
	
	#State Machine
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
					
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
				
	#Stops them from overlapping 			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400	
	velocity = move_and_slide(velocity)
		
func accelerate_towards_point(point, delta):
		var direction = global_position.direction_to(point)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		sprite.flip_h = velocity.x < 0
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
			
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_area_entered(_area):
	if player_facing_right == true:	
		knockback = Vector2.RIGHT * 100
	else:
		knockback = Vector2.LEFT * 100
	stats.health -= 1
	hurtbox.start_invincibility(0.4)


func _on_Stats_no_health():
	queue_free()

func _on_HurtBox_invincibility_started():
	animationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	animationPlayer.play("Stop")


#References
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast
