class_name PassiveData
extends Resource

# === IDENTIFICATION ===
# Unique key and display info for UI
@export var id: String = ""                    # Unique key like "iron_beak", "thick_plumage"
@export var display_name: String = ""          # Shown to player: "Iron Beak"
@export_multiline var description: String = "" # Tooltip: "+10% Damage per level"

# === PASSIVE STATS ===
# How the passive modifies player stats
@export var effect: String = ""           # What stat it modifies: "damage", "max_hp", "move_speed", "pickup_range"
@export var bonus_per_level: float = 0.0  # How much bonus each level gives (0.10 = +10%, 15.0 = +15 HP)
@export var max_level: int = 5            # Cap for upgrades

# === VISUALS ===
@export var icon: Texture2D  # 16x16 icon for level-up UI

# === HELPER FUNCTIONS ===
## Returns the total bonus at a given level
## Multiplicative passives (damage, speed, pickup_range): returns multiplier to add (e.g., 0.5 at lv5)
## Additive passives (max_hp): returns flat bonus (e.g., 75 at lv5)
func get_bonus(level: int) -> float:
	return bonus_per_level * clampi(level, 0, max_level)
