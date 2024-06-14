extends Node2D

var FallingObject = preload("res://Top Down Test/Characters/slider_object.tscn")
@export var Score : float = 0


func _on_timer_timeout():
	spawnObject()


func spawnObject():
	#print(str('spawning object'))


	var Player = get_node("Slider_Character")

	@warning_ignore("shadowed_variable_base_class")
	var position = Vector2(randf_range(Player.position.x - 200, Player.position.x + 200), -550)
	var object = FallingObject.instantiate()
	object.scale.x = randf_range(2,15)
	object.scale.y = 3
	object.position = position
	object.add_to_group("FallingObject")
	call_deferred("add_child",object)





func _on_child_exiting_tree(node):
	if node.is_in_group("FallingObject"):
		Score += 1
		$Label.set_text("Score: " + str(Score))
		#print(str(Score))


func _ready():
	Score = 0
