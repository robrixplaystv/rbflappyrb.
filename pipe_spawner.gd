extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_time: float = 1.5
var time_since_last_spawn := 0.0

func _process(delta: float) -> void:
	time_since_last_spawn += delta
	if time_since_last_spawn > spawn_time:
		time_since_last_spawn = 0.0
		spawn_pipe()

func spawn_pipe() -> void:
	if pipe_scene == null:
		print("ERROR: NO PIPE SCENE ASSIGNED IN INSPECTOR!")
		return
		
	print("SPAWNER: Spawning a new pipe.")
	var pipe = pipe_scene.instantiate()
	
	# Set position BEFORE adding it to the tree
	pipe.position = Vector2(1000, randf_range(450, 750))
	
	# Add it to the scene
	add_child(pipe)
