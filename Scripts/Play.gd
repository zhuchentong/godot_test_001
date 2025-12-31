extends CharacterBody2D

@export var move_speed: float = 1000;
@export var animator: AnimatedSprite2D
@export var timer: Timer
@export var bullet_scene: PackedScene

var is_game_over: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if is_game_over:
		return
		
	velocity = Input.get_vector("left","right","up",'down') * move_speed;
	
	# 如果速度为0, 播放站立动画
	if velocity == Vector2.ZERO:
		animator.play("idle")
	else:
		animator.play("run")
	
	move_and_slide()
	
	
func game_over() -> void:
	is_game_over = true
	animator.play("game_over")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return 
		
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(60, 60)
	get_tree().current_scene.add_child(bullet_node)
