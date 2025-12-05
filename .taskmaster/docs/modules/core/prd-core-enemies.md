# Sarimanok Survivor - Enemy System (Weeks 1-3)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Feature 2: Enemy System

**What It Does:**
Enemies spawn at screen edges, walk toward the player, and deal damage on contact. Killing enemies drops XP and Gold.

## Enemy Roster (2 for Weeks 1-3)

| Enemy             | HP  | Damage | Speed | Spawns At | Behavior         |
| ----------------- | --- | ------ | ----- | --------- | ---------------- |
| **Green Duwende** | 10  | 5      | 80    | 0:00+     | Walks to player  |
| **Red Duwende**   | 25  | 10     | 100   | 8:00+     | Faster, stronger |

**Note:** Santelmo and Manananggal deferred to Week 4.

## Duwende Color Variants

In Filipino folklore, duwendes have different ranks/types indicated by color:

- **Green:** Common, mischievous
- **Red:** More aggressive, territorial

This is culturally authentic AND saves art time (recolor same sprite).

## Difficulty Scaling

Enemy stats scale over time to create late-game challenge:

```gdscript
# Enemy stat scaling - add to spawn manager
func get_scaled_hp(base_hp: int, elapsed_minutes: float) -> int:
    # +5% HP per 5 minutes
    var scale = 1.0 + (elapsed_minutes / 5.0) * 0.05
    return int(base_hp * scale)

func get_scaled_damage(base_damage: int, elapsed_minutes: float) -> int:
    # +3% damage per 5 minutes
    var scale = 1.0 + (elapsed_minutes / 5.0) * 0.03
    return int(base_damage * scale)
```

| Time  | Green HP | Green Dmg | Red HP | Red Dmg |
| ----- | -------- | --------- | ------ | ------- |
| 0:00  | 10       | 5         | -      | -       |
| 10:00 | 11       | 5         | 27     | 10      |
| 20:00 | 12       | 6         | 30     | 11      |

## Enemy Behaviors

**Duwende (All Colors):**

```
Every frame:
  direction = (player.position - self.position).normalized()
  velocity = direction * speed
  move_and_slide()

On contact with player:
  player.take_damage(damage)
```

**Enemy Collision Rules:**

- Enemies pass through each other (no inter-enemy collision)
- This is intentional for performance and gameplay (allows swarming)
- Enemies DO collide with player (deal damage on overlap)
- Enemies DO NOT collide with arena boundaries (spawn outside, walk in)

## Spawn System

**Spawn Location:** Random point on screen edge (just outside visible area)

**Spawn Timeline (Weeks 1-3):**
| Time | Enemies Spawning | Spawn Rate |
| --------- | ---------------- | ------------------- |
| 0:00-8:00 | Green Duwende | 1 per 2s → 1 per 1s |
| 8:00+ | Green + Red | 1 per 1s → 0.8s |

**Spawn Rate Formula:**

```gdscript
# Exponential difficulty scaling - spawns increase 5% per minute
var base_spawn_interval = 2.0  # seconds between spawns at 0:00
var difficulty_scale = 1.05    # 5% faster spawns per minute

func get_spawn_interval(elapsed_minutes: float) -> float:
    return base_spawn_interval / pow(difficulty_scale, elapsed_minutes)

# Examples:
# 0:00  = 2.0s between spawns
# 5:00  = 1.57s between spawns
# 10:00 = 1.23s between spawns
```

## Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |

## Technical Requirements

- Enemy scene with **Area2D** (NOT CharacterBody2D - see note below)
- Simple pathfinding (just move toward player)
- Spawn manager that tracks time and spawn rates
- Object pooling for performance (reuse enemy instances)
- Death: Play particle effect, drop XP gem + Gold coin, return to pool

**Why Area2D instead of CharacterBody2D:** Enemies only need to move toward the player (simple vector math) and detect overlap for damage. CharacterBody2D includes physics overhead (collision response, move_and_slide) that tanks FPS with 200+ enemies on screen. Area2D is lightweight and sufficient for our needs.

## Placeholder Art (Week 1-3)

- Green Duwende: ColorRect, green, 32x32
- Red Duwende: ColorRect, red, 32x32

---

**Related Files:**

- [Core Foundation](prd-core-foundation.md) - Player Character (Feature 1)
- [Weapon System](prd-core-weapons.md) - Feature 3
- [Progression Systems](prd-core-progression.md) - Features 4-6, Week 1-3 tasks
