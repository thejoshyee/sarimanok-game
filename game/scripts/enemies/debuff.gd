class_name Debuff
extends Resource

# What kind of debuff ("slow", "burn", etc.)
@export var debuff_type: String
# How strong the effect is (0.0 - 1.0)
# For slow, 0.3 means 30% speed reduction per stack
@export var strength: float
# How long the debuff lasts in seconds
@export var duration: float
# Tracks how long this debuff has been active
var elapsed: float = 0.0
