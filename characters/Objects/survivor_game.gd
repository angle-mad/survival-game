extends Node2D

var mobs_killed = 0

const MAP_MIN = -4900
const MAP_MAX = 4900
const TREE_SPACING = 400

func _ready():
	%GameOver.visible = false
	$Stats/Enemies_Killed.text = "Enemies Killed: " + str(mobs_killed)
	spawn_random_trees(200)
	await get_tree().create_timer(5.0).timeout
	$Timer.start()
	

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
				randf_range(MAP_MIN,MAP_MAX),
				randf_range(MAP_MIN,MAP_MAX)
			)
			valid_position = true
			for existing_pos in tree_positions:
				if pos.distance_to(existing_pos) < TREE_SPACING:
					valid_position = false
					break
		tree.position = pos
		tree_positions.append(pos)
		add_child(tree)



func spawn_mob():
	var new_mob = preload("res://characters/Objects/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, MAP_MIN, MAP_MAX)
	spawn_pos.y = clamp(spawn_pos.y, MAP_MIN, MAP_MAX)
	new_mob.global_position = spawn_pos
	
	add_child(new_mob)
	new_mob.connect("mob_died", _on_mob_died)
	
func spawn_flower():
	var new_flower = preload("res://characters/flower/flower.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, MAP_MIN, MAP_MAX)
	spawn_pos.y = clamp(spawn_pos.y, MAP_MIN, MAP_MAX)
	new_flower.global_position = spawn_pos
	
	new_flower.global_position = %PathFollow2D.global_position
	add_child.call_deferred(new_flower)
	new_flower.connect("mob_died", _on_mob_died)
	
func spawn_puffer():
	var new_puffer = preload("res://pufferfish.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, MAP_MIN, MAP_MAX)
	spawn_pos.y = clamp(spawn_pos.y, MAP_MIN, MAP_MAX)
	new_puffer.global_position = spawn_pos
	
	new_puffer.global_position = %PathFollow2D.global_position
	add_child.call_deferred(new_puffer)
	new_puffer.connect("mob_died", _on_mob_died)
	
func spawn_goblin():
	var new_goblin = preload("res://goblin.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, MAP_MIN, MAP_MAX)
	spawn_pos.y = clamp(spawn_pos.y, MAP_MIN, MAP_MAX)
	new_goblin.global_position = spawn_pos
	
	new_goblin.global_position = %PathFollow2D.global_position
	add_child.call_deferred(new_goblin)
	new_goblin.connect("mob_died", _on_mob_died)
	
	
	
	
func spawn_orange():
	var new_orange = preload("res://characters/orange/orange.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, MAP_MIN, MAP_MAX)
	spawn_pos.y = clamp(spawn_pos.y, MAP_MIN, MAP_MAX)
	new_orange.global_position = spawn_pos
	
	new_orange.global_position = %PathFollow2D.global_position
	add_child.call_deferred(new_orange)
	new_orange.connect("mob_died", _on_mob_died)

func _on_mob_died():
	AudioManager.play_sfx("res://music/mutantdie.wav")
	mobs_killed += 1
	$Stats/Enemies_Killed.text = "Enemies Killed: " + str(mobs_killed)
	
	if mobs_killed % 20 == 0:
		spawn_orange()
		
	if mobs_killed % 9 == 0:
		spawn_flower()
		
	if mobs_killed % 3 == 0:
		spawn_goblin()
		
	if mobs_killed == 4:
		spawn_puffer()
		
func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func reset_game():
	unpause()
	AudioManager.play_music()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	unpause()
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://ui.tscn")

func _on_reset_pressed() -> void:
	reset_game()
