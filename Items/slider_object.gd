extends CharacterBody2D

@export var Gravity : float = 400

func _physics_process(delta):

	velocity.y += delta * Gravity

	move_and_slide()


func _on_area_2d_body_entered(body):
	#print(str(body.name))
	if body.is_in_group("Ground"):
		queue_free()
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()


func _ready():
	add_to_group("FallingObject")
