extends Control

@onready var background: TextureRect = $BackgroundTextRect
@onready var camera: BoundedCamera = $Camera

# Sends the size vector of the background texture rect as a signal whenever the size of the node changes
func _ready() -> void:
	background.resized.connect(func() ->void: camera.applyBounds(background.size))
	camera.applyBounds(background.size)
