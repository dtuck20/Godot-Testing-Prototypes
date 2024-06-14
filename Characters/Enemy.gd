extends CharacterBody2D

var speed = 300
var accel = 7

signal killed(enemy)


@onready var nav: NavigationAgent2D = $NavigationAgent2D

#var velocity = Vector2()
func _ready():
	add_to_group("Enemies")
	
	


func _physics_process(delta):
	var Player = get_parent().get_parent().get_node("PlayerCharacter")
	var direction = Vector3()
	
#	position += (Player.position - position)/100
	look_at(Player.position)
	nav.target_position = Player.position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	if Player.position.x < position.x:
		$AnimatedSprite2D.flip_v = true
	else:
		$AnimatedSprite2D.flip_v = false
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletGroup"):
		self.death(self)
		queue_free()
		body.queue_free()

func death(enemy):
	killed.emit(enemy)
