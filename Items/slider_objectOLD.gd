extends CharacterBody2D

@export var Gravity : float = 200

func _physics_process(delta):

	velocity.y += delta * Gravity

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Ground"):
		print(str(body.name))
		queue_free()
