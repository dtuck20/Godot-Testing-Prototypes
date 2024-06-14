extends Node2D

var enemy = preload("res://Top Down Test/Characters/enemy_2.tscn")
@onready var spawn_location_1 = get_node("EnemySpawn1")
@onready var spawn_location_2 = get_node("EnemySpawn2")
@onready var spawn_location_3 = get_node("EnemySpawn3")
@onready var spawn_location_4 = get_node("EnemySpawn4")
@onready var spawn_location_5 = get_node("EnemySpawn5")
@onready var spawn_location_6 = get_node("EnemySpawn6")
@onready var setup_timer = get_node("setup_timer")
@onready var wave_timer = get_node("wave_timer")

#@export var ui: UI

var wave : int = 1

var during_wave : bool = true

func spawn_enemy():
	var Player = get_parent().get_node("PlayerCharacter")
	var enemy_instance = enemy.instantiate()
	var x : int = 1
	
	
	x = randi_range(1,6)
	
	match x:
		1: 
			enemy_instance.position = spawn_location_1.global_position
		2: 
			enemy_instance.position = spawn_location_2.global_position
		3: 
			enemy_instance.position = spawn_location_3.global_position
		4: 
			enemy_instance.position = spawn_location_4.global_position
		5: 
			enemy_instance.position = spawn_location_5.global_position
		6: 
			enemy_instance.position = spawn_location_6.global_position
			
	if enemy_instance.position.distance_to(Player.position) > 800 and during_wave:
		call_deferred("add_child",enemy_instance)
		print("Spawning enemy at location " + str(x))
		
	if enemy_instance.position.distance_to(Player.position) < 800:
		print("Not spawning enemy due to proximity " + str(enemy_instance.position.distance_to(Player.position)))
	
	
	
func _on_timer_timeout():
	if during_wave:
		spawn_enemy()
		#print("Calling Spawning Enemy")


func _on_audio_stream_player_finished():
	$bg_music.play()
	


func _on_setup_timer_timeout():
	during_wave = true
	wave_timer.start(wave * 30)
	

func _on_wave_timer_timeout():
	during_wave = false
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for item in enemies:
		item.queue_free()
	$wave_end_audio.play()
	setup_timer.start(30)
	wave += 1
	
#func _physics_process(_delta):
#	print("Wave Time Left: " + str(wave_timer.time_left))
#	print("Setup Time Left: " + str(setup_timer.time_left))


