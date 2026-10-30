extends Control

@onready var background: TextureRect = $BackgroundTextRect
@onready var camera: Camera2D = $Camera

# Sends the size vector of the background texture rect as a signal whenever the size of the node changes
func _ready() -> void:
	background.resized.connect(func(): camera.applyBounds(background.size))
	camera.applyBounds(background.size)
