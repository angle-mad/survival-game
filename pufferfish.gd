extends CharacterBody2D

var health = 5
var rotation_speed = 3.0

@onready var player = get_node("/root/Game/Player")


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 250.0
	move_and_slide()

func take_damage():
	health -= 1
	
	if health == 0:
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
	
	
	
