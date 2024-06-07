extends Area2D


@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	get_tree().call_group("GameManager", "_on_coin_area_entered")
	print("collected")
	animation_player.play("collected")
	pass # Replace with function body.
