extends GPUParticles2D

## Self-destructs after particles finish playing
## WHY: One-shot particles need cleanup to avoid memory leaks

func _ready() -> void:
	# Connect to the finished signal - emitted when one_shot completes
	finished.connect(_on_finished)


func _on_finished() -> void:
	# Remove this particle node from the scene
	queue_free()
