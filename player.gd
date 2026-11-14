extends CharacterBody2D

@export var jump_force: float = -450.0
@export var gravity: float = 1500.0
var is_dead := false
var score := 0

# Grab the labels using their path in the scene tree
@onready var score_label = $"../CanvasLayer/ScoreLabel"
@onready var game_over_label = $"../CanvasLayer/GameOverLabel"

func _ready() -> void:
	add_to_group("player")
	# Hide the game over text at the start
	game_over_label.visible = false

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return
		
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		velocity.y = jump_force
		
	move_and_slide()
	rotation = clamp(velocity.y * 0.001, -0.5, 1.5)
	
	if global_position.y > 600: 
		die()

func add_score() -> void:
	score += 1
	# UPDATE THE TEXT ON THE SCREEN
	score_label.text = "Score: " + str(score)

func die() -> void:
	if is_dead: return
	is_dead = true
	
	# SHOW THE GAME OVER TEXT
	game_over_label.visible = true
	game_over_label.text = "GAME OVER\nScore: " + str(score)
	
	get_tree().call_group("pipes", "set_process", false)
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
