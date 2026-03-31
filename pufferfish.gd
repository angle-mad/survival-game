extends CharacterBody2D

signal mob_died
var health = 5
var rotation_speed = 3.0
var attack_cooldown = 0.0
var straight = 0.0

@onready var player = get_node("/root/Game/Player")


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 250.0
	move_and_slide()
	
	attack_cooldown += _delta
	if attack_cooldown >= 2:
		shoot_spikes()
		
		
func shoot_spikes():
	straight = 0.0
	for i in range(8):
		var spike = preload("res://spike.tscn").instantiate()
		spike.direction = Vector2.RIGHT.rotated(deg_to_rad(straight))
		straight += 45
		get_parent().add_child(spike)
		spike.global_position = global_position
	attack_cooldown = 0.0

func take_damage():
	health -= 1
	
	if health == 0:
		mob_died.emit()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
	
	
	
