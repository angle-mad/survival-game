extends Node2D

var mobs_killed = 0

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
