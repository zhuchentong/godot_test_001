extends Area2D

# 速度
@export var slime_speed: float = -200; 
@export var animator: AnimatedSprite2D
@export var health = 1

var is_enabled: bool = false
var is_death: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not is_death:
		position += Vector2(slime_speed, 0) * _delta 


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("hit player")
		
		body.game_over()

func _on_area_entered(area: Area2D) -> void:
	if not is_enabled:
		return 
		
	if area.is_in_group("Bullet"):
		area.queue_free()

		health -= 1
		
		if health <= 0:
			animator.play("death")
			is_death = true
			get_tree().current_scene.score += 1
			# 等待死亡动画
			await get_tree().create_timer(0.6).timeout
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_enabled = true
