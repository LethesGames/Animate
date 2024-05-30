extends CanvasLayer


@onready var idle_texture_rect:TextureRect = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/IdleTextureRect
@onready var run_texture_rect = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/RunTextureRect
@onready var jump_texture_rect = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/JumpTextureRect2
@onready var slide_texture_rect = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/HBoxContainer/SlideTextureRect3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_animation(animation:String) -> void:
	match animation:
		"idle":
			idle_texture_rect.modulate = Color(1,1,1)
		"run":
			run_texture_rect.modulate = Color(1,1,1)
		"jump":
			jump_texture_rect.modulate = Color(1,1,1)
		"slide":
			slide_texture_rect.modulate = Color(1,1,1)
