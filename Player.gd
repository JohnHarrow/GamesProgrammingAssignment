extends KinematicBody2D

#Initializing Variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300
const ACCEL = 10
var motion = Vector2()
var facing_right = true
var input_vector = Vector2.ZERO
var stats = PlayerStats
onready var hurtbox = $HurtBox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

#State Machine Variables
enum {
	MOVE,
	ATTACK1,
	ATTACK2
}
var state = MOVE

			
func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	


#Physics Precessing
func _physics_process(_delta):
	#Gravity
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED

	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1

	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	#State Machine
	match state:
		MOVE:
			move_state()
		
		ATTACK1:
			attack1_state()
			
		ATTACK2:
			attack2_state()
	motion = move_and_slide(motion, UP)

#Function to control movement and jumping
func move_state():
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():	
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("Fall")

	if Input.is_action_just_pressed("Attack 1 Button"):
		state = ATTACK1
	if Input.is_action_just_pressed("Attack 2 Button"):
		state = ATTACK2

	
#Attack States		
func attack1_state():
	if facing_right == true:
		$AnimationPlayer.play("Attack 1 Right")
	else:
		$AnimationPlayer.play("Attack 1 Left")
	
func attack2_state():
	if facing_right == true:
		$AnimationPlayer.play("Attack 2 Right")
	else:
		$AnimationPlayer.play("Attack 2 Left")
	
func attack_animation_finished():
	state = MOVE
	
	

#For when player is hit
func _on_HurtBox_area_entered(_area):
	stats.health -= 1
	hurtbox.start_invincibility(0.5)

#Blink animation when hit
func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")



#References
#https://www.youtube.com/watch?v=xFEKIWpd0sU&ab_channel=EliCuaycong - Basic movement and gravity for player
#https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1&ab_channel=HeartBeast - State Machine
