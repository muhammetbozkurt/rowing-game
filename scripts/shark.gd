extends CharacterBody3D

@export var speed = 3.0
@export var rotation_speed = 2.0

var target: Node3D

func _ready() -> void:
	target = get_tree().get_root().find_child("Boat", true, false)

func _physics_process(delta: float) -> void:
	if not target:
		return
		

	var direction = (target.global_transform.origin - global_transform.origin).normalized()
	var angle_to_target = direction.signed_angle_to(global_transform.basis.z, Vector3.UP)

	if abs(angle_to_target) > 0.1:
		rotate_y(sign(angle_to_target) * rotation_speed * delta)

	velocity = -transform.basis.z * speed
	move_and_slide()


func _on_attack_area_body_entered(body: Node3D) -> void:
	if is_instance_valid(body) and body == target:
		print("game end")
		get_tree().reload_current_scene()
		
