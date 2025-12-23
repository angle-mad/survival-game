extends Area2D

#AI WRITTEN - Somethng messed up when saving my file last time and the orginal code from a tutorial video just decided to stop working so I asked AI to fix what was wrong and I'm not really sure what happened originally but this works.
func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		for body in enemies_in_range:  # Add this line!
			if body.collision_layer == 2:  # Only target mobs on Layer 2
				$WeaponPivot.look_at(body.global_position)
				if $Timer.is_stopped():
					$Timer.start()
				break
	else:
		$Timer.stop()
#End of AI WRITTEN code

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot() 
