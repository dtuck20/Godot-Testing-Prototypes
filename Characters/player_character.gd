extends CharacterBody2D

@export var move_speed : float = 500

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var bullet_speed = 2000
var bullet = preload("res://Top Down Test/Items/bullet.tscn")
var animation_locked : bool = false

func _physics_process(_delta):
	#Get input direction
#	var input_direction = Vector2(
#		Input.get_action_strength("right") - Input.get_action_strength("left"),
#		Input.get_action_strength("down") - Input.get_action_strength("up")
#	)
#
#	velocity = input_direction * move_speed
#
#
#
#	move_and_slide()

	velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		velocity.y -= move_speed
	if Input.is_action_pressed("down"):
		velocity.y += move_speed
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
		if position.x < get_global_mouse_position().x:
			if not animation_locked:
				animated_sprite.play("Backward")
				animated_sprite.flip_h = true
		if position.x > get_global_mouse_position().x:
			if not animation_locked:
				animated_sprite.play("Forward")
				animated_sprite.flip_h = true
		
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		if position.x > get_global_mouse_position().x:
			if not animation_locked:
				animated_sprite.play("Backward")
				animated_sprite.flip_h = true
		if position.x < get_global_mouse_position().x:
			if not animation_locked:
				animated_sprite.play("Forward")
				animated_sprite.flip_h = true

	if not animation_locked:
		if velocity == Vector2.ZERO:
			animated_sprite.play("Idle")
		
	if position.x < get_global_mouse_position().x:
		animated_sprite.flip_v= false
	else:
		animated_sprite.flip_v= true

	move_and_slide()

	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Fire"):
		fire()



func fire():
	animation_locked = true
	var x : int = 1
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $BulletSpawnPoint.global_position
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
	animated_sprite.play("Pew")
	get_tree().get_root().call_deferred("add_child",bullet_instance)
	x = randi_range(1,3)

	match x:
		1: 
			$Pew.play()
		2: 
			$Pew2.play()
		3: 
			$Pew3.play() 


func kill():
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		kill()


func _on_animated_sprite_2d_animation_finished():
	animation_locked = false
