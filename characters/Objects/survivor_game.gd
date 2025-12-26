extends Node2D

var mobs_killed = 0


func _ready():
	%GameOver.visible = false
	spawn_random_trees(200)
func unpause():
	get_tree().paused = false

func spawn_random_trees(count):
	var tree_positions = []
	
	for i in range(count):
		var tree = preload("res://characters/Objects/tree.tscn").instantiate()
		var valid_position = false
		var pos = Vector2.ZERO
		
		while !valid_position:
			pos = Vector2(
				randf_range(-4900,4900),
				randf_range(-4900,4900)
			)
			valid_position = true
			for existing_pos in tree_positions:
				if pos.distance_to(existing_pos) < 400:
					valid_position = false
					break
		tree.position = pos
		tree_positions.append(pos)
		add_child(tree)







func spawn_mob():
	var new_mob = preload("res://characters/Objects/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.connect("mob_died", _on_mob_died)
	
func spawn_orange():
	var new_orange = preload("res://characters/orange/orange.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_orange.global_position = %PathFollow2D.global_position
	add_child.call_deferred(new_orange)

func _on_mob_died():
	mobs_killed += 1
	
	if mobs_killed % 20 == 0:
		spawn_orange()

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func reset_game():
	unpause()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	unpause()
	get_tree().change_scene_to_file("res://ui.tscn")

func _on_reset_pressed() -> void:
	reset_game()
