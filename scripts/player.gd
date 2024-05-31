extends CharacterBody2D


#const SPEED = 300.0
@export var SPEED:float = 200.0
#const JUMP_VELOCITY = -400.0
@export var JUMP_VELOCITY:float = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
var can_idle:bool = true
var can_run:bool = false
var can_jump:bool = false
var can_slide:bool = false
var has_jumped:bool = false
var has_slide:bool = false
	
func _physics_process(delta):
	has_jumped = false
	has_slide = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if (
		Input.is_action_just_pressed("jump") 
		and is_on_floor() 
		and can_jump
	):
		has_jumped = true
		velocity.y = JUMP_VELOCITY
	
	if (
		Input.is_action_just_pressed("slide") 
		and is_on_floor() 
		and can_slide
	):
		has_slide = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	handle_animations(direction, has_jumped)

	move_and_slide()


func handle_animations(direction, has_jumped) -> void:	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if has_jumped and can_jump: #Saltar
		animated_sprite.play("Jump")
	elif has_slide and can_slide: #Slide
		animated_sprite.play("Slide")
	elif (
		(velocity.x > 0 or velocity.x < 0) 
		and can_run 
		and is_on_floor()
	): #Correr
		if (
			not (animated_sprite.animation == "Jump" and animated_sprite.is_playing()) 
			and not (animated_sprite.animation == "Slide" and animated_sprite.is_playing())
		):
			animated_sprite.play("Run")
	else: #Idle (por defecto)
		if (
			is_on_floor() 
			and not (animated_sprite.animation == "Slide" 
			and animated_sprite.is_playing())
		): 
			animated_sprite.play("Idle")


func enable_animation(animation_action:String) -> void:
	match animation_action:
		"run":
			can_run = 1
			floor_max_angle = 0.785398
		"jump":
			can_jump = 1
		"slide":
			can_slide = 1
