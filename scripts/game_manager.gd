extends Node2D

@onready var player = get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_area_2d_body_entered(body, animation_action):
	player.enable_animation(animation_action)
	pass # Replace with function body.