extends CharacterBody2D
@export var move_speed : float = 500
@export var Gravity : float = 200

func _physics_process(_delta):
	#Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),0)

	velocity = input_direction * move_speed



	move_and_slide()


func kill():
	print("Kill Called")
	#get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	print(str("Collision Detected"))
	if body.is_in_group("FallingObject"):
		print("We should restart now")

