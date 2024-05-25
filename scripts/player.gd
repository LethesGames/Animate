extends CharacterBody2D


#const SPEED = 300.0
@export var SPEED:float = 200.0
#const JUMP_VELOCITY = -400.0
@export var JUMP_VELOCITY:float = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
var animations_array = [1, 0, 0, 0] #Idle, Run, Jump, Slide

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var has_jumped:bool = false
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and animations_array[2]:
		has_jumped = true
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	handle_animations(direction, has_jumped)
		#if is_on_floor():
			#if animations_array[0]:
				#animated_sprite.play("Idle")
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func handle_animations(direction, has_jumped) -> void:	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if has_jumped and animations_array[2]:
		animated_sprite.play("Jump")
	else: 
		if not (animated_sprite.animation == "Jump" and animated_sprite.is_playing()):
			if (velocity.x > 0 or velocity.x < 0) and animations_array[1]:
				animated_sprite.play("Run")
			else:
				if animations_array[0]:
					animated_sprite.play("Idle")
		else:
			if is_on_floor():
				animated_sprite.play("Idle")


func enable_animation(animation_action:String) -> void:
	match animation_action:
		"run":
			animations_array[1] = 1
		"jump":
			animations_array[2] = 1
		"slide":
			animations_array[3] = 1
