extends RigidBody3D

# variable global 
@export_range(750.0, 3000.0) var thrust: float = 1000.0 
@export_range(50.0, 150.0) var torque_thrus: float = 100.0 

var is_transition: bool = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrus * delta))
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrus * delta))

func _on_body_entered(body: Node) -> void: 
	if is_transition == false: 
		if "Goal" in body.get_groups():
			complete_level(body.file_path)

		if "Hazard" in body.get_groups():
			crash_secuence()

#funcion para recheckpoit al momento de estrellarse con la base 
func crash_secuence() -> void:
	print("KABOOM!")

	set_process(false)
	is_transition = true

	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)
	#Recalculo de choque en la escena.
	
	
func complete_level(next_level_path: String) -> void:
	print("level completed")
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_path))