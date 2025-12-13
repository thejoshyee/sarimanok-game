# Sarimanok Survivor - Weapon System (Weeks 1-3)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Feature 3: Weapon System

**What It Does:**
Weapons attack automatically on a cooldown. Player collects weapons through level-up choices. Each weapon has different behavior and can be upgraded.

## Weapon Roster (6 Total: 4 Unique + 2 Clones)

| Weapon              | Type       | Behavior                         | Cooldown | Base Damage |
| ------------------- | ---------- | -------------------------------- | -------- | ----------- |
| **Peck**            | Melee      | Quick jab in facing direction    | 0.5s     | 10          |
| **Wing Slap**       | AOE        | Circle around player             | 1.5s     | 8           |
| **Feather Shot**    | Projectile | Shoots feather at nearest enemy  | 1.0s     | 12          |
| **Spiral Feathers** | Orbital    | 4 feathers orbit player          | Passive  | 6           |
| **Ice Shard**       | Projectile | Slow feather + enemy slow debuff | 1.2s     | 10          |
| **Flame Wing**      | AOE        | Smaller, stronger AOE circle     | 1.5s     | 10          |

## Weapon Descriptions

**Peck (Starting Weapon):**

- Short range melee attack
- Damages enemies in small cone in front of player
- Fast attack speed
- Player always starts with this

**Wing Slap:**

- Damages ALL enemies in radius around player
- Larger area than Peck
- Slower cooldown
- Great for crowds

**Feather Shot:**

- Shoots feather projectile toward nearest enemy
- Travels across screen
- Pierces through 1 enemy (at level 1)
- Good for ranged threats

**Spiral Feathers:**

- 4 feathers orbit the player constantly
- Damages enemies on contact
- No cooldown (always active)
- Great for close-range protection
- Reuses Feather Shot projectile sprite (rotated)

## Weapon Levels

Each weapon can be upgraded to Level 5 through level-up choices:

**Peck Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ---------------------- |
| 1 | 10 | Base |
| 2 | 15 | +50% damage |
| 3 | 20 | +100% damage |
| 4 | 25 | Faster cooldown (0.4s) |
| 5 | 35 | Hits in wider arc |

**Wing Slap Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------ |
| 1 | 8 | Base |
| 2 | 12 | +50% damage |
| 3 | 16 | Larger radius |
| 4 | 20 | +150% damage |
| 5 | 28 | Even larger radius |

**Feather Shot Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------------- |
| 1 | 12 | 1 feather |
| 2 | 14 | 2 feathers |
| 3 | 16 | 3 feathers |
| 4 | 18 | Feathers pierce 2 enemies |
| 5 | 24 | 4 feathers, pierce 3 |

**Spiral Feathers Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------------ |
| 1 | 6 | 4 orbiting feathers |
| 2 | 8 | +33% damage |
| 3 | 10 | Faster rotation speed |
| 4 | 12 | 6 orbiting feathers |
| 5 | 16 | 8 feathers, larger orbit |

## Maximum Weapons

Player can hold up to **6 weapons** at once.

If you have 6 weapons and level up, you'll only see upgrade options for existing weapons ("+1" options), not new weapons.

## Clone Weapons (2 Additional - Low-Cost Variety)

To increase build variety without scope explosion, add 2 "clone" weapons that reuse existing weapon logic with different stats/visuals:

| Clone Weapon   | Base Weapon  | Visual Change | Stat Change                                   |
| -------------- | ------------ | ------------- | --------------------------------------------- |
| **Ice Shard**  | Feather Shot | Blue feather  | Slower projectile + 0.5s slow debuff on enemy |
| **Flame Wing** | Wing Slap    | Orange AOE    | +20% damage, smaller radius                   |

**Ice Shard:**

- Reuses Feather Shot projectile logic
- Blue-tinted feather sprite (recolor)
- Slower projectile speed (100 vs 150)
- Applies 0.5s slow debuff to hit enemies (50% speed reduction)
- Great for kiting and crowd control

**Flame Wing:**

- Reuses Wing Slap AOE logic
- Orange/red AOE effect (recolor)
- +20% damage (10 base vs 8)
- 75% radius of Wing Slap
- Higher risk/reward for aggressive players

## Data-Driven Weapon Architecture

To make adding weapons trivial (10-15 minutes per weapon), use Godot Resources:

```gdscript
# weapons/weapon_data.gd - Data-driven weapon definitions
class_name WeaponData
extends Resource

@export var id: String
@export var display_name: String
@export var description: String
@export var base_damage: int
@export var cooldown: float
@export var weapon_type: String  # "projectile", "aoe", "melee", "orbital"
@export var sprite: Texture2D
@export var icon: Texture2D
@export var upgrades: Array[Dictionary]  # [{level, damage, effect_description}]

# Optional modifiers (for clones and variants)
@export var debuff_type: String = ""  # "slow", "burn", etc.
@export var debuff_duration: float = 0.0
@export var debuff_strength: float = 0.0  # e.g., 0.5 = 50% slow
@export var radius_modifier: float = 1.0
@export var speed_modifier: float = 1.0
@export var projectile_count: int = 1
@export var pierce_count: int = 1
```

**Benefits:**

- New weapons = create `.tres` resource file, no code changes
- Clone weapons share base weapon's script, just different data
- Easy to balance (tweak numbers in Inspector, no recompile)
- Update 1 weapon additions become trivial

## Technical Requirements

- Weapon base class with cooldown timer
- Each weapon type extends base class
- Weapon manager tracks equipped weapons
- Weapons fire automatically when cooldown ready
- Visual effects for each weapon attack
- Damage detection using Area2D
- **WeaponData Resource for data-driven definitions**
- **Debuff system for slow/burn effects (used by clone weapons)**

## Placeholder Art (Week 1-3)

All weapons use ColorRect placeholders or simple shapes during Weeks 1-3.

---

**Related Files:**
- [Core Foundation](prd-core-foundation.md) - Player Character (Feature 1)
- [Enemy System](prd-core-enemies.md) - Feature 2
- [Progression Systems](prd-core-progression.md) - Features 4-6, Week 1-3 tasks
