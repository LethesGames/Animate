extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
var animations_array = [0, 0, 0, 0] #Idle, Run, Jump, Slide

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		if animations_array[1]:
			animated_sprite.play("Run")
		if animated_sprite.flip_h:
			animated_sprite.flip_h = false
		velocity.x = direction * SPEED
	elif direction < 0:
		if animations_array[1]:
			animated_sprite.play("Run")
		if not animated_sprite.flip_h:
			animated_sprite.flip_h = true
		velocity.x = direction * SPEED
	else:
		if animations_array[0]:
			animated_sprite.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
