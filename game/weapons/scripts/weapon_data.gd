class_name WeaponData
extends Resource

# === IDENTIFICATION ===
# These idenity the weapon in code and UI
@export var id: String = "" # Unique key like "peck", "wing_slap"
@export var display_name: String = "" # Shown to player: TODO: Update with localization names filipino folklore names
@export_multiline var description: String = "" # Tooltip text, can be multiple lines 

# === COMBAT STATS ===
# Core values that determine weapon behavior 
@export var base_damage: float = 10.0  # Starting damage before upgrades/bonuses
@export var cooldown: float = 1.0  # Seconds between auto-fires
@export var weapon_type: String = "melee"  # "melee", "projectile", "aoe", "passive"

# === VISUALS ===
# Art assets for displaying the weapon
@export var sprite: Texture2D  # In-game weapon visual (projectile, effect area)
@export var icon: Texture2D  # 16x16 icon for UI (level-up choices, HUD slots)
@export var projectile_color: Color = Color.WHITE  # Tint for projectiles (white = no tint)


# === MODIFIERS ===
# Special effects and scaling properties
@export var debuff_type: String = ""  # "slow", "burn", "none" - status effect applied
@export var debuff_duration: float = 0.0  # How long debuff lasts in seconds
@export var debuff_strength: float = 0.0  # Debuff intensity (slow %, burn DPS)
@export var radius_modifier: float = 1.0  # Multiplier for AOE size (1.0 = normal)
@export var speed_modifier: float = 1.0  # Projectile speed multiplier
@export var projectile_count: int = 1  # Number of projectiles per shot
@export var pierce_count: int = 0  # How many enemies a projectile passes through

# === UPGRADES ===
# Level-up progression data - each dict has: level, damage, effect_description
@export var upgrades: Array[Dictionary] = []

# === HELPER FUNCTIONS ===
## Returns the upgrade dictionary for the given level, or empty dict if not found
func get_upgrade(level: int) -> Dictionary:
	# Loop through all upgrade entries looking for matching level
	for upgrade in upgrades:
		if upgrade.get("level", -1) == level:
			return upgrade
	# No upgrade found for this level
	return {}
