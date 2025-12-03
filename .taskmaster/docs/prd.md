# Sarimanok Survivor

## Product Requirements Document - MVP (Early Access)

**Version:** 2.0 FINAL  
**Platform:** Windows via Steam Early Access (Mac/Linux in future update)  
**Engine:** Godot 4.x  
**Art Style:** Top-down pixel art (32x32 sprites, 48x48 boss)  
**Camera/Perspective:** Fixed top-down view, camera follows player, bounded arena  
**Reference Games:** Vampire Survivors, Void Miner, Brotato  
**Team Size:** 1-2 first-time developers (husband/wife team)  
**Target Playtime:** 30 minutes per run  
**Timeline:** 14 weeks (includes Next Fest week)  
**Next Fest:** February 23 - March 2, 2026 (Demo live!)  
**Target Launch:** ~March 8, 2026 (Right after Next Fest)  
**Price:** $2.99-4.99 USD

**Title Alternatives Under Consideration:**

- Sarimanok: Aswang Survivor
- Sarimanok: Night of the Aswang
- Sarimanok Rising

---

# Overview

## Problem Statement

Filipino mythology and folklore are vastly underrepresented in video games. The rich creatures of Philippine mythology—duwendes, aswang, manananggal, santelmo—have never starred in an action roguelite. Meanwhile, the "bullet heaven" survivor genre is proven to sell well on Steam, even for solo developers (Void Miner: $40k+ in first 2 weeks, 6 months dev time).

## Solution

A Filipino folklore-themed survivor roguelite where you play as **Sarimanok**, the legendary bird of Maranao mythology, defending the land from mythological creatures through the night. Survive until dawn (30 minutes), and Sarimanok crows in victory—balance is restored. Die, and try again with permanent upgrades earned from collected gold.

**What is Sarimanok?**
The Sarimanok is a legendary bird from the folklore of the Maranao people of Mindanao, Philippines. It symbolizes good fortune, prosperity, and royalty. Depicted as a colorful bird with elaborate, intricate designs, it's often shown with a fish in its beak—representing offerings to the spirit world. The Sarimanok serves as a spiritual link between the seen and unseen worlds, making it the perfect guardian against creatures of darkness.

The game combines:

- **Proven gameplay loop:** Vampire Survivors-style auto-attacking survivor mechanics
- **Unique cultural hook:** Authentic Filipino mythological creatures AND protagonist
- **Clear win condition:** Survive to dawn (unlike VS where you always die)
- **Roguelite progression:** Gold persists between runs for permanent upgrades

## Why This Will Work

| Factor          | Evidence                                                    |
| --------------- | ----------------------------------------------------------- |
| Genre proven    | Vampire Survivors: 5M+ copies, countless successful clones  |
| Solo dev viable | Void Miner: 1 dev, 6 months, $40k+ revenue                  |
| Niche untapped  | Zero Filipino folklore games in survivor genre              |
| Scope minimal   | 3 characters, 4 enemies, 4 weapons = achievable in 3 months |
| Cultural hook   | Filipino diaspora is large and underserved                  |

## Target Audience

- Filipino gamers worldwide (diaspora + locals)
- Survivor/roguelite genre fans
- Players seeking unique cultural experiences
- Casual gamers who enjoy short sessions (30 min runs)
- Fans of Vampire Survivors looking for similar games

## Core Validation Questions

1. **Is the gameplay loop fun?** (Does auto-attacking + dodging feel satisfying?)
2. **Do Filipino creatures add appeal?** (Does the cultural hook resonate?)
3. **Is 30 minutes the right length?** (Not too short, not too long?)
4. **Does the progression feel rewarding?** (Shop upgrades + level-up choices)
5. **Is the difficulty balanced?** (Challenging but beatable)

## Success Metrics

**Launch targets (first 2 weeks):**

- 500+ copies sold
- 70%+ positive reviews
- 50%+ of players reach 10:00 mark
- 20%+ of players beat Story Mode
- Players request more content (characters, enemies, weapons)

**Stretch targets:**

- 2,000+ copies sold first month
- Featured in "New and Trending" on Steam
- Coverage from Filipino gaming communities

---

# Core Concept: What is a Survivor Roguelite?

## The Genre

**Survivor games** (also called "bullet heaven") feature:

- Top-down arena gameplay
- Weapons attack AUTOMATICALLY (no attack button)
- Enemies swarm toward you constantly
- You move to dodge, weapons fire on their own
- XP from kills → level up → pick upgrades
- Runs last 15-30 minutes
- Death = start over, but keep some progress

**Roguelite elements:**

- Permanent progression between runs (gold → shop upgrades)
- Random upgrade choices each level-up
- Different builds each run based on RNG

## Your Game's Twist

**Standard survivor:** You always die eventually (VS has unkillable Death at 30:00)

**Manok Survivor:** You can WIN by surviving to dawn (30:00)!

| Time       | What Happens                        |
| ---------- | ----------------------------------- |
| 0:00       | Night falls on the farm             |
| 0:00-30:00 | Survive waves of Filipino creatures |
| 20:00      | Aswang boss appears                 |
| 30:00      | **DAWN! COCKADOODLEDOO!** You win!  |

This creates a satisfying narrative: the legendary Sarimanok guards the land through the night and crows at sunrise. Balance between worlds is restored.

---

# Game Flow

## Main Menu

```
┌─────────────────────────────────────┐
│         MANOK SURVIVOR              │
│                                     │
│   🐓 [STORY MODE]                   │
│   ∞  [ENDLESS MODE] (locked)        │
│   🛒 [SHOP]                         │
│   ⚙️  [SETTINGS]                    │
│   🚪 [QUIT]                         │
│                                     │
│   Gold: 350                         │
│   High Score: 12,450                │
│   Best Time: 23:47                  │
└─────────────────────────────────────┘
```

**Endless Mode unlocks after beating Story Mode once.**

## One Run (30 Minutes)

```
START RUN
    ↓
Night falls on the farm
    ↓
Enemies spawn, walk toward you
    ↓
Your weapons auto-attack
    ↓
Enemies die → drop XP gems + Gold coins
    ↓
Collect XP → bar fills → LEVEL UP!
    ↓
Pick 1 of 3 random upgrades (weapon or passive)
    ↓
Keep surviving, keep leveling
    ↓
20:00 - MANANANGGAL BOSS appears!
    ↓
30:00 - DAWN! COCKADOODLEDOO! Victory!
    ↓
Results screen (score, gold earned, stats)
    ↓
Return to Main Menu with gold
```

## Between Runs

```
Run ends (win or die)
    ↓
See results: "You earned 250 gold!"
    ↓
Return to Main Menu
    ↓
Visit SHOP
    ↓
Spend gold on permanent upgrades
    ↓
Start new run (slightly stronger)
```

## The Roguelite Loop

```
RUN → DIE → SHOP → RUN → DIE → SHOP → RUN → WIN!
         ↑                                    |
         └────────────────────────────────────┘
                    (try again!)
```

**The hook:** "One more run... I almost beat the boss! Let me buy +2% damage and try again..."

---

# Two Currencies

| Currency | Symbol   | From        | After Death?     | Used For                   |
| -------- | -------- | ----------- | ---------------- | -------------------------- |
| **XP**   | 💎 Gems  | Enemy kills | ❌ RESETS to 0   | Level ups DURING run       |
| **GOLD** | 🪙 Coins | Enemy kills | ✅ KEEPS forever | Shop upgrades BETWEEN runs |

**Simple version:**

- XP = temporary power (this run only)
- Gold = permanent power (forever)

**All enemies drop BOTH XP and Gold when killed.**

---

# What Resets vs. What Stays

| After Each Run              | Status                   |
| --------------------------- | ------------------------ |
| XP                          | ❌ Back to 0             |
| Level                       | ❌ Back to 1             |
| Weapons found during run    | ❌ Gone                  |
| Passives found during run   | ❌ Gone                  |
| **GOLD earned**             | ✅ **Adds to total**     |
| **Shop upgrades purchased** | ✅ **Permanent forever** |
| **High score**              | ✅ **Saved**             |
| **Endless Mode unlock**     | ✅ **Permanent**         |

---

# Core Features (MVP)

## Feature 1: Player Characters - Sarimanok Variants (3)

**What It Does:**
You control one of three Sarimanok variants, each with different stats. All move with WASD/arrow keys. Weapons attack automatically—you just focus on positioning and dodging.

**Why It's Important:**
Multiple characters add replayability. Each variant encourages a different playstyle without requiring completely new art (just recolors).

**Cultural Significance:**
The Sarimanok symbolizes good fortune, prosperity, and royalty. As a spiritual link between the seen and unseen worlds, it's the perfect guardian against creatures of darkness. The color variants can represent different aspects: classic (balance), shadow (aggression), golden (protection).

### Character Roster (3 Variants)

| Character               | Colors           | HP  | Speed | Damage | Playstyle                      | Unlock                      |
| ----------------------- | ---------------- | --- | ----- | ------ | ------------------------------ | --------------------------- |
| **Sarimanok (Classic)** | Rainbow/vibrant  | 100 | 100%  | 100%   | Balanced, good for learning    | Default                     |
| **Sarimanok (Shadow)**  | Dark purple/blue | 80  | 100%  | 125%   | Glass cannon, high risk/reward | Survive 15:00 in Story Mode |
| **Sarimanok (Golden)**  | Gold/red/bronze  | 130 | 85%   | 100%   | Tank, sustained survival       | Beat Story Mode (30:00)     |

**Unlock Progression:**

- Shadow at 15:00 is achievable in 3-5 attempts - proves you can handle mid-game
- Requires Story Mode specifically

### Base Stats (Before Character Modifiers)

| Stat         | Base Value | Notes                                    |
| ------------ | ---------- | ---------------------------------------- |
| Max HP       | 100        | Modified by character choice             |
| Move Speed   | 200        | Pixels per second, modified by character |
| Damage       | 100%       | Multiplier for all weapons               |
| Attack Speed | 100%       | Multiplier for weapon cooldowns          |
| Pickup Range | 50         | Pixels, for XP/Gold collection           |

**Controls:**

- WASD or Arrow Keys: Move
- Mouse: Aim (weapons fire toward cursor) OR auto-aim to nearest enemy
- ESC: Pause menu
- NO attack button (weapons are automatic)

**Animation:**

- 2 frames: idle/walk (bob animation)
- Flip sprite based on movement direction (code handles this)
- 32x32 pixel sprite

**Technical Requirements:**

- CharacterBody2D with 8-directional movement
- Sprite flips horizontally based on velocity.x
- 2-frame animation (frame 1 ↔ frame 2 every 0.2s while moving)
- Collision shape for enemy damage detection
- Invincibility frames (0.5s) after taking damage
- Character select screen before run starts
- Unlock system checks conditions before showing locked characters

**Definition of Done:**

- [ ] All 3 Sarimanok variants implemented with correct stats
- [ ] Character select screen works
- [ ] Shadow shows unlock requirement (locked until 15:00 survived)
- [ ] Shadow unlocks correctly after surviving 15:00
- [ ] Golden shows unlock requirement (locked until Story Mode beaten)
- [ ] Golden unlocks correctly after beating Story Mode
- [ ] Sarimanok moves in 8 directions smoothly
- [ ] Movement speed matches character's value
- [ ] Sprite flips correctly left/right
- [ ] 2-frame animation plays while moving
- [ ] Each variant visually distinct (different colors)
- [ ] Takes damage from enemy contact
- [ ] Invincibility frames work after damage
- [ ] Death triggers when HP reaches 0
- [ ] No console errors

---

## Feature 2: Enemy System

**What It Does:**
Enemies spawn at screen edges, walk toward the player, and deal damage on contact. Killing enemies drops XP and Gold.

**Why It's Important:**
Enemies ARE the game. Their behavior, variety, and spawn rates create the challenge.

### Enemy Roster (4 Total for EA)

| Enemy                  | HP  | Damage | Speed | Spawns At | Behavior                   |
| ---------------------- | --- | ------ | ----- | --------- | -------------------------- |
| **Green Duwende**      | 10  | 5      | 80    | 0:00+     | Walks toward player        |
| **Red Duwende**        | 25  | 10     | 100   | 8:00+     | Faster, stronger           |
| **Santelmo**           | 15  | 8      | 60    | 10:00+    | Floats, shoots fireballs   |
| **Manananggal (Boss)** | 500 | 25     | 90    | 20:00     | Boss, flying torso vampire |

**Note:** Black Duwende deferred to Update 1.

### Duwende Color Variants (Cultural Note)

Ericka confirmed: In Filipino folklore, duwendes have different ranks/types indicated by color:

- **Green:** Common, mischievous
- **Red:** More aggressive, territorial
- **Black:** Most powerful, dangerous (deferred to Update 1)

This is culturally authentic AND saves art time (recolor same sprite).

### Difficulty Scaling (Replaces Black Duwende for Late-Game)

Instead of a third Duwende variant at 16:00+, enemy stats scale over time to create late-game challenge:

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

| Time  | Green HP | Green Dmg | Red HP | Red Dmg | Santelmo HP |
| ----- | -------- | --------- | ------ | ------- | ----------- |
| 0:00  | 10       | 5         | -      | -       | -           |
| 10:00 | 11       | 5         | 27     | 10      | 16          |
| 20:00 | 12       | 6         | 30     | 11      | 18          |
| 30:00 | 13       | 6         | 32     | 12      | 19          |

This creates escalating challenge without requiring extra enemy art.

### Enemy Behaviors

**Duwende (All Colors):**

```
Every frame:
  direction = (player.position - self.position).normalized()
  velocity = direction * speed
  move_and_slide()

On contact with player:
  player.take_damage(damage)
```

**Santelmo:**

```
Every frame:
  Float toward player (slower, erratic movement)
  Add slight sine wave to path for "floating" feel

Every 2 seconds:
  Shoot fireball projectile toward player

On contact with player:
  player.take_damage(damage)
```

**Santelmo Fireball Specs:**

| Property | Value                         |
| -------- | ----------------------------- |
| Speed    | 150 pixels/second             |
| Damage   | 8                             |
| Cooldown | 2.0 seconds                   |
| Size     | 16x16 pixels                  |
| Lifetime | 5 seconds (despawn if no hit) |

**Manananggal (Boss):**

```
On spawn:
  Play dramatic entrance (screen shake, screech sound)
  48x48 sprite (larger than normal enemies)

Behavior:
  Fly toward player (medium speed, ignores terrain)
  Every 5 seconds: Dive attack (burst of speed toward player)
  Leaves blood trail visual effect

On death:
  Bonus gold drop (100g)
  Does NOT end game (still must survive to 30:00)
```

**Manananggal Dive Attack Specs:**

| Property      | Value                                                  |
| ------------- | ------------------------------------------------------ |
| Telegraph     | 1.0 second warning (sprite flashes red, screech sound) |
| Dive Speed    | 3x normal speed (270 pixels/second)                    |
| Dive Duration | 0.5 seconds                                            |
| Cooldown      | 5.0 seconds between dives                              |
| Damage        | 25 (same as contact damage)                            |

**Enemy Collision Rules:**

- Enemies pass through each other (no inter-enemy collision)
- This is intentional for performance and gameplay (allows swarming)
- Enemies DO collide with player (deal damage on overlap)
- Enemies DO NOT collide with arena boundaries (spawn outside, walk in)

**Cultural Note - Manananggal:**
The Manananggal is a type of Aswang from Filipino folklore. It's a self-segmenting vampire—a woman whose upper torso detaches from her lower body, sprouting bat-like wings to fly through the night hunting prey. More iconic and visually striking than a generic shapeshifter.

### Spawn System

**Spawn Location:** Random point on screen edge (just outside visible area)

**Spawn Timeline:**

| Time        | Enemies Spawning               | Spawn Rate          |
| ----------- | ------------------------------ | ------------------- |
| 0:00-8:00   | Green Duwende                  | 1 per 2s → 1 per 1s |
| 8:00-10:00  | Green + Red Duwende            | 1 per 1s            |
| 10:00-20:00 | Green + Red Duwende + Santelmo | 1 per 0.8s → 0.5s   |
| 20:00       | **MANANANGGAL SPAWNS**         | One-time            |
| 20:00-30:00 | All enemies + Manananggal      | 1 per 0.3s (chaos!) |

**Note:** Difficulty scaling (HP/damage increase over time) replaces Black Duwende for late-game challenge.

**Spawn Rate Scaling:**

- Base rate decreases (faster spawns) as time progresses
- Harder enemies are added to the pool over time
- Never remove earlier enemies (Green Duwendes spawn all game)

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
# 20:00 = 0.75s between spawns
# 30:00 = 0.46s between spawns
```

This creates smooth difficulty progression rather than hard jumps at time thresholds.

### Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |
| Santelmo      | 4       | 3         |
| Manananggal   | 50      | 100       |

**Note:** Black Duwende (5 XP, 5 Gold) will be added in Update 1.

**Technical Requirements:**

- Enemy scene with **Area2D** (NOT CharacterBody2D - see note below)
- Simple pathfinding (just move toward player)
- Spawn manager that tracks time and spawn rates
- Object pooling for performance (reuse enemy instances)
- Death: Play particle effect, drop XP gem + Gold coin, return to pool

**Why Area2D instead of CharacterBody2D:** Enemies only need to move toward the player (simple vector math) and detect overlap for damage. CharacterBody2D includes physics overhead (collision response, move_and_slide) that tanks FPS with 200+ enemies on screen. Area2D is lightweight and sufficient for our needs.

**Definition of Done:**

- [ ] All 4 enemy types implemented (Green Duwende, Red Duwende, Santelmo, Manananggal)
- [ ] Enemies spawn at screen edges
- [ ] Enemies walk toward player
- [ ] Enemies damage player on contact
- [ ] Enemies die when HP reaches 0
- [ ] Enemies drop XP + Gold on death
- [ ] Spawn timeline works correctly
- [ ] Manananggal boss spawns at 20:00
- [ ] Spawn rate increases over time
- [ ] Enemy stat scaling works (HP/damage increase over time)
- [ ] Game handles 100+ enemies without lag
- [ ] No console errors

---

## Feature 3: Weapon System

**What It Does:**
Weapons attack automatically on a cooldown. Player collects weapons through level-up choices. Each weapon has different behavior and can be upgraded.

**Why It's Important:**
Weapons are your primary way to kill enemies. Different weapons create different playstyles.

### Weapon Roster (6 Total: 4 Unique + 2 Clones)

| Weapon              | Type       | Behavior                         | Cooldown | Base Damage |
| ------------------- | ---------- | -------------------------------- | -------- | ----------- |
| **Peck**            | Melee      | Quick jab in facing direction    | 0.5s     | 10          |
| **Wing Slap**       | AOE        | Circle around player             | 1.5s     | 8           |
| **Feather Shot**    | Projectile | Shoots feather at nearest enemy  | 1.0s     | 12          |
| **Spiral Feathers** | Orbital    | 4 feathers orbit player          | Passive  | 6           |
| **Ice Shard**       | Projectile | Slow feather + enemy slow debuff | 1.2s     | 10          |
| **Flame Wing**      | AOE        | Smaller, stronger AOE circle     | 1.5s     | 10          |

### Weapon Descriptions

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
- Good for ranged threats (Santelmo)

**Spiral Feathers:**

- 4 feathers orbit the player constantly
- Damages enemies on contact
- No cooldown (always active)
- Great for close-range protection
- Reuses Feather Shot projectile sprite (rotated)

### Weapon Levels

Each weapon can be upgraded to Level 5 through level-up choices:

**Peck Upgrades:**

| Level | Damage | Effect                 |
| ----- | ------ | ---------------------- |
| 1     | 10     | Base                   |
| 2     | 15     | +50% damage            |
| 3     | 20     | +100% damage           |
| 4     | 25     | Faster cooldown (0.4s) |
| 5     | 35     | Hits in wider arc      |

**Wing Slap Upgrades:**

| Level | Damage | Effect             |
| ----- | ------ | ------------------ |
| 1     | 8      | Base               |
| 2     | 12     | +50% damage        |
| 3     | 16     | Larger radius      |
| 4     | 20     | +150% damage       |
| 5     | 28     | Even larger radius |

**Feather Shot Upgrades:**

| Level | Damage | Effect                    |
| ----- | ------ | ------------------------- |
| 1     | 12     | 1 feather                 |
| 2     | 14     | 2 feathers                |
| 3     | 16     | 3 feathers                |
| 4     | 18     | Feathers pierce 2 enemies |
| 5     | 24     | 4 feathers, pierce 3      |

**Spiral Feathers Upgrades:**

| Level | Damage | Effect                   |
| ----- | ------ | ------------------------ |
| 1     | 6      | 4 orbiting feathers      |
| 2     | 8      | +33% damage              |
| 3     | 10     | Faster rotation speed    |
| 4     | 12     | 6 orbiting feathers      |
| 5     | 16     | 8 feathers, larger orbit |

### Maximum Weapons

Player can hold up to **4 weapons** at once.

If you have 4 weapons and level up, you'll only see upgrade options for existing weapons ("+1" options), not new weapons.

### Clone Weapons (2 Additional - Low-Cost Variety)

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

**Clone Weapon Upgrades follow same pattern as base weapons.**

### Data-Driven Weapon Architecture

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

**Technical Requirements:**

- Weapon base class with cooldown timer
- Each weapon type extends base class
- Weapon manager tracks equipped weapons
- Weapons fire automatically when cooldown ready
- Visual effects for each weapon attack
- Damage detection using Area2D
- **WeaponData Resource for data-driven definitions**
- **Debuff system for slow/burn effects (used by clone weapons)**

**Definition of Done:**

- [ ] Peck attack works (melee cone)
- [ ] Wing Slap attack works (AOE circle)
- [ ] Feather Shot works (projectile)
- [ ] Spiral Feathers works (orbiting feathers)
- [ ] Ice Shard works (slow projectile + slow debuff)
- [ ] Flame Wing works (smaller AOE, higher damage)
- [ ] All weapons auto-fire on cooldown
- [ ] Weapons can be upgraded to level 5
- [ ] Max 6 weapons enforced
- [ ] Weapon effects visible and satisfying
- [ ] Damage numbers show on hit
- [ ] WeaponData Resource system implemented
- [ ] Debuff system works (slow effect)
- [ ] No console errors

---

## Feature 4: Passive System

**What It Does:**
Passives are stat boosts that stack. Collect them through level-up choices. No animation or visual effect—just numbers.

**Why It's Important:**
Passives add build variety without art burden. They're "free content."

### Passive Roster (4 Total)

| Passive           | Per Level         | Max Level | At Max             |
| ----------------- | ----------------- | --------- | ------------------ |
| **Iron Beak**     | +10% Damage       | 5         | +50% total damage  |
| **Thick Plumage** | +15 Max HP        | 5         | +75 HP             |
| **Racing Legs**   | +10% Move Speed   | 5         | +50% move speed    |
| **Magnetic Aura** | +20% Pickup Range | 5         | +100% pickup range |

### How Passives Stack

**Example: Iron Beak**

- Level 1: All weapons deal 110% damage
- Level 2: All weapons deal 120% damage
- Level 3: All weapons deal 130% damage
- Level 4: All weapons deal 140% damage
- Level 5: All weapons deal 150% damage

**These multiply with weapon upgrades!**

Peck Level 5 (35 damage) + Iron Beak Level 5 (150%):

```
35 × 1.50 = 52.5 damage per hit
```

**Technical Requirements:**

- Simple stat modifiers in player script
- Passive manager tracks levels
- Apply modifiers to relevant calculations
- Only needs icon art (16x16)

**Definition of Done:**

- [ ] Iron Beak increases damage correctly
- [ ] Thick Plumage increases max HP correctly
- [ ] Racing Legs increases move speed correctly
- [ ] Magnetic Aura increases pickup range correctly
- [ ] Passives stack additively
- [ ] Passives appear in level-up choices
- [ ] Passives can be upgraded to level 5
- [ ] No console errors

---

## Feature 5: Level-Up System

**What It Does:**
Collecting XP fills a bar. When full, game pauses and presents 3 random upgrade choices. Player picks one, game resumes.

**Why It's Important:**
This is where build variety comes from. Random choices + player decisions = different builds each run.

### XP Curve

| Level | XP Required  | Cumulative |
| ----- | ------------ | ---------- |
| 1→2   | 5            | 5          |
| 2→3   | 10           | 15         |
| 3→4   | 15           | 30         |
| 4→5   | 20           | 50         |
| 5→6   | 25           | 75         |
| ...   | +5 per level | ...        |

Formula: `xp_needed = 5 + (level - 1) * 5`

### Level-Up Screen

```
┌─────────────────────────────────────────────┐
│              LEVEL UP!                      │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │  PECK   │  │  WING   │  │  IRON   │     │
│  │   +1    │  │  SLAP   │  │  BEAK   │     │
│  │ Lv.1→2  │  │  NEW!   │  │  NEW!   │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
│         Click to choose one                 │
└─────────────────────────────────────────────┘
```

### Choice Pool Logic

The pool contains:

- All weapons not yet at max level (or not owned + slot available)
- All passives not yet at max level (or not owned)

**Example scenarios:**

_Early game (Level 2, only have Peck):_

- Pool: Peck+1, Wing Slap (NEW), Feather Shot (NEW), Iron Beak, Thick Plumage, Racing Legs
- Show 3 random from pool

_Mid game (Have all 3 weapons):_

- Pool: Peck+1, Wing Slap+1, Feather Shot+1, Iron Beak+1, Thick Plumage+1, Racing Legs+1
- No "NEW" weapons (slots full)

_Late game (Peck maxed):_

- Pool excludes Peck entirely
- Only shows upgradeable items

### Technical Requirements

```gdscript
func _on_xp_collected(amount):
    current_xp += amount
    if current_xp >= xp_to_next_level:
        current_xp -= xp_to_next_level
        level += 1
        xp_to_next_level = calculate_xp_needed(level)
        show_level_up_screen()

func show_level_up_screen():
    get_tree().paused = true
    var choices = get_random_choices(3)
    level_up_ui.display(choices)

func _on_choice_selected(choice):
    apply_upgrade(choice)
    get_tree().paused = false
```

**Definition of Done:**

- [ ] XP bar fills when collecting gems
- [ ] Level up triggers at correct XP amounts
- [ ] Game pauses during level-up screen
- [ ] 3 random choices displayed
- [ ] Clicking choice applies upgrade
- [ ] Game resumes after choice
- [ ] Choices respect max levels
- [ ] Choices respect weapon slot limit
- [ ] No console errors

---

## Feature 6: Pickup System

**What It Does:**
Enemies drop XP gems and Gold coins. Player walks over them to collect.

**Why It's Important:**
Pickups are the reward for killing enemies. They must feel satisfying to collect.

### Pickup Types

| Pickup        | Visual                | Effect                 |
| ------------- | --------------------- | ---------------------- |
| **XP Gem**    | Blue diamond (16x16)  | Adds to XP bar         |
| **Gold Coin** | Yellow circle (16x16) | Adds to permanent gold |

### Pickup Behavior

- Spawns at enemy death location
- Sits still for 0.5s (brief pause)
- Then slowly drifts toward player (magnetic effect)
- Collected when touching player hitbox
- Collection range increased by passives (future expansion)

### Magnet Effect

```gdscript
func _process(delta):
    var distance = global_position.distance_to(player.global_position)
    if distance < player.pickup_range:
        var direction = (player.global_position - global_position).normalized()
        global_position += direction * magnet_speed * delta
```

### Technical Requirements

- Pickup scene (Area2D with sprite)
- Spawned by enemy on death
- Magnetic drift toward player when close
- Collected on overlap with player
- Play collect sound
- Show "+1" floating text (nice-to-have)

**Definition of Done:**

- [ ] XP gems spawn on enemy death
- [ ] Gold coins spawn on enemy death
- [ ] Pickups drift toward player when close
- [ ] XP adds to XP bar
- [ ] Gold adds to permanent gold counter
- [ ] Collect sound plays
- [ ] No console errors

---

## Feature 7: Shop System

**What It Does:**
Between runs, player can spend gold on permanent stat upgrades that apply to ALL future runs.

**Why It's Important:**
This is the roguelite progression. It's why dying doesn't feel pointless—you always make progress.

### Shop Screen

```
┌─────────────────────────────────────┐
│              SHOP                   │
│                                     │
│   Your Gold: 350                    │
│                                     │
├─────────────────────────────────────┤
│                                     │
│   Damage +2%         100g    [BUY]  │
│   Current: +6%                      │
│                                     │
│   Max HP +5          100g    [BUY]  │
│   Current: +15                      │
│                                     │
│   Move Speed +1%     100g    [BUY]  │
│   Current: +3%                      │
│                                     │
├─────────────────────────────────────┤
│                                     │
│           [BACK TO MENU]            │
│                                     │
└─────────────────────────────────────┘
```

### Permanent Upgrades

| Upgrade    | Cost | Effect          | Repeatable? |
| ---------- | ---- | --------------- | ----------- |
| Damage     | 100g | +2% base damage | ∞ (forever) |
| Max HP     | 100g | +5 max HP       | ∞           |
| Move Speed | 100g | +1% move speed  | ∞           |

**These are SMALL bonuses that stack over many purchases.**

Example: Buy "Damage +2%" 10 times = +20% damage on ALL runs forever.

### Saving Shop Upgrades

Shop purchases persist in save file:

```
{
    "gold": 350,
    "shop_damage": 6,    // +6% damage bought
    "shop_hp": 15,       // +15 HP bought
    "shop_speed": 3,     // +3% speed bought
    "endless_unlocked": true,
    "high_score": 12450,
    "best_time": "23:47"
}
```

### Technical Requirements

- Shop UI scene
- Load/save shop data to file
- Apply shop bonuses at run start
- Disable BUY button if not enough gold
- Update display after purchase

**Definition of Done:**

- [ ] Shop screen displays correctly
- [ ] Can purchase upgrades with gold
- [ ] Gold deducted on purchase
- [ ] Upgrades apply to next run
- [ ] Upgrades persist when game closed
- [ ] BUY button disabled when broke
- [ ] Current bonus displayed
- [ ] No console errors

---

## Feature 8: Game Timer & Win Condition

**What It Does:**
30-minute timer counts up. Surviving to 30:00 = VICTORY (dawn, rooster crows). HP reaching 0 = DEFEAT.

**Why It's Important:**
This is what makes the game a game. Clear win/lose conditions.

### Timer Display

```
┌──────────────┐
│    12:47     │
└──────────────┘
```

Position: Top center of screen
Format: MM:SS
Counts UP from 0:00

### Win Condition (Story Mode)

```
Timer reaches 30:00
    ↓
Freeze gameplay
    ↓
Screen brightens (dawn effect)
    ↓
"COCKADOODLEDOO!" text appears
    ↓
Sarimanok crow sound effect
    ↓
"VICTORY! Balance is restored!"
    ↓
Show results screen
```

### Lose Condition

```
Player HP reaches 0
    ↓
Death animation (Sarimanok falls)
    ↓
"You survived 12:47"
    ↓
Show results screen (same as win, different header)
```

### Results Screen

```
┌─────────────────────────────────────┐
│   VICTORY! / DEFEATED               │
│                                     │
│   Time Survived: 30:00 / 12:47      │
│   Enemies Killed: 847               │
│   Score: 15,420                     │
│   Gold Earned: 312                  │
│                                     │
│   [SHOP]   [RETRY]   [MENU]         │
└─────────────────────────────────────┘
```

**Definition of Done:**

- [ ] Timer displays and counts up
- [ ] Victory triggers at 30:00
- [ ] Dawn visual effect plays
- [ ] Sarimanok crow sound plays
- [ ] Defeat triggers at 0 HP
- [ ] Results screen shows stats
- [ ] Gold earned adds to total
- [ ] Can retry, shop, or menu from results
- [ ] No console errors

---

## Feature 9: Endless Mode (SIMPLIFIED FOR EA)

> **Note:** Simplified Endless Mode is included in EA. Same gameplay as Story Mode but with no 30:00 win condition - just survive as long as possible. Advanced scaling deferred to Update 1.

**What It Does:**
Unlocks after beating Story Mode. No time limit—survive as long as possible. Uses same difficulty scaling as Story Mode (spawn rate + stat scaling already implemented).

**Why It's Important:**
Replayability after beating Story Mode. Leaderboard appeal.

### Unlock Condition

```
Beat Story Mode (survive to 30:00)
    ↓
"ENDLESS MODE UNLOCKED!"
    ↓
Endless Mode button appears on main menu
```

### Endless Mode Rules (EA - Simplified)

- Timer counts UP forever (no 30:00 win)
- Same spawn rate scaling as Story Mode (continues past 30:00)
- Same HP/damage scaling as Story Mode (continues past 30:00)
- You WILL eventually die
- Goal: Survive as long as possible

### Endless Mode Scaling (Update 1 - Enhanced)

Additional scaling after 30:00 will be added in Update 1:

| Time   | Spawn Rate  | Enemy HP |
| ------ | ----------- | -------- |
| 30:00  | 1 per 0.3s  | 100%     |
| 35:00  | 1 per 0.25s | 125%     |
| 40:00  | 1 per 0.2s  | 150%     |
| 45:00  | 1 per 0.15s | 175%     |
| 50:00+ | 1 per 0.1s  | 200%+    |

### Leaderboards

| Mode         | Leaderboard   |
| ------------ | ------------- |
| Story Mode   | High Score    |
| Endless Mode | Time Survived |

**Definition of Done (EA):**

- [ ] Endless Mode locked initially
- [ ] Unlocks after Story Mode victory
- [ ] No win condition (play until death)
- [ ] Same scaling as Story Mode (continues past 30:00)
- [ ] Best time saved
- [ ] No console errors

---

## Feature 10: Score System

**What It Does:**
Tracks score based on enemies killed. Creates leaderboard competition.

**Why It's Important:**
Gives reason to replay even after winning.

### Scoring

| Action                  | Points |
| ----------------------- | ------ |
| Kill Green Duwende      | 10     |
| Kill Red Duwende        | 25     |
| Kill Santelmo           | 40     |
| Kill Manananggal        | 500    |
| Survive to dawn (bonus) | 1,000  |

**Note:** Black Duwende (50 points) will be added in Update 1.

### Display

Score shows in top-right corner during gameplay:

```
Score: 12,450
```

### High Score

- Saved to file
- Displayed on main menu
- Displayed on results screen
- Separate high scores for Story vs Endless

**Definition of Done:**

- [ ] Score tracks during run
- [ ] Score displays on screen
- [ ] High score saved
- [ ] High score displayed on menu
- [ ] Bonus points for winning
- [ ] No console errors

---

# User Interface Screens

## Screen List

| Screen       | Purpose                          |
| ------------ | -------------------------------- |
| Main Menu    | Start game, access shop/settings |
| Shop         | Buy permanent upgrades           |
| Settings     | Audio, controls                  |
| Gameplay HUD | HP, XP, timer, score, weapons    |
| Pause Menu   | Resume, settings, quit           |
| Level Up     | Choose upgrade                   |
| Victory      | Win stats                        |
| Defeat       | Loss stats                       |

## Main Menu Layout

```
┌─────────────────────────────────────────────┐
│                                             │
│            MANOK SURVIVOR                   │
│               🐓                            │
│                                             │
│            [STORY MODE]                     │
│            [ENDLESS MODE] 🔒               │
│            [SHOP]                           │
│            [SETTINGS]                       │
│            [QUIT]                           │
│                                             │
│   Gold: 350    High Score: 12,450           │
│                                             │
│                              v0.1.0         │
└─────────────────────────────────────────────┘
```

**Loading Screen Text:**

> "The Sarimanok guards the land through the night. Survive until dawn."

Displayed briefly when starting a run (during scene transition).

## Gameplay HUD Layout

```
┌─────────────────────────────────────────────┐
│  ❤️ ████████░░  [12:47]     Score: 12,450  │
│  ⭐ ████░░░░░░                              │
│                                             │
│                                             │
│               (gameplay)                     │
│                                             │
│                                             │
│                                             │
│  🗡️ Peck Lv.3  💨 Wing Slap Lv.2           │
└─────────────────────────────────────────────┘
```

- Top left: HP bar, XP bar
- Top center: Timer
- Top right: Score
- Bottom: Equipped weapons with levels

## Pause Menu

```
┌─────────────────────────────────────────────┐
│                                             │
│               PAUSED                        │
│                                             │
│             [RESUME]                        │
│             [SETTINGS]                      │
│             [QUIT TO MENU]                  │
│                                             │
└─────────────────────────────────────────────┘
```

---

# Placeholder Art Workflow

## Development Philosophy: Code First, Art Parallel

**The Approach:**

- Josh codes with placeholder art (colored rectangles)
- Ericka creates real art in Aseprite simultaneously
- Once art is done, swap placeholders → real sprites
- No blocking—both can work at the same time

## Placeholder Specifications

All placeholders are simple colored rectangles matching final sprite sizes:

| Asset               | Placeholder          | Color              | Size       |
| ------------------- | -------------------- | ------------------ | ---------- |
| Sarimanok (Classic) | ColorRect            | Rainbow/multicolor | 32x32      |
| Sarimanok (Shadow)  | ColorRect            | Dark purple        | 32x32      |
| Sarimanok (Golden)  | ColorRect            | Gold               | 32x32      |
| Green Duwende       | ColorRect            | Green              | 32x32      |
| Red Duwende         | ColorRect            | Red                | 32x32      |
| Santelmo            | ColorRect            | Orange             | 32x32      |
| Manananggal         | ColorRect            | Dark red           | 48x48      |
| XP Gem              | ColorRect            | Blue               | 16x16      |
| Gold Coin           | ColorRect            | Yellow             | 16x16      |
| Feather projectile  | ColorRect            | White              | 16x16      |
| Tileset (all tiles) | Simple colored tiles | Green/brown/gray   | 32x32 each |
| All icons           | ColorRect            | Gray               | 16x16      |

## Parallel Development Timeline (Accelerated for Baby Buffer)

```
JOSH (Code)                    ERICKA (Art)
───────────────────────────────────────────────────
Week 1-2: Core gameplay        Week 1-2: Sarimanok (all 3 variants)
Week 3-4: Weapons, enemies     Week 3-4: Duwendes + Santelmo
Week 5: Progression, shop      Week 5: Manananggal Boss
Week 6: Characters, Endless    Week 6: All Icons + Pickups ← ART COMPLETE
Week 7: Art integration        Week 7: Tileset + UI elements (if time)
Week 8+: Polish together       Week 8+: Rest before baby / polish if able
```

**Why accelerated:** Baby due March 21. Completing core art by Week 6 gives 5+ weeks buffer instead of 3.

## Sprite Swap Process (Week 7)

**Step 1: Ericka exports final sprites**

```
/art/
├── sarimanok_classic.png (32x32, 2 frames horizontal)
├── sarimanok_shadow.png
├── duwende_green.png
├── duwende_red.png
├── santelmo.png
├── manananggal.png (48x48, 4 frames)
├── tileset_farm.png (256x128, all tiles in grid)
├── icons/
│   ├── peck.png
│   ├── wing_slap.png
│   └── ...
└── ui/
    ├── hp_bar.png
    └── ...

# Update 1 will add:
# ├── sarimanok_golden.png
# ├── duwende_black.png
```

**Step 2: Josh imports to Godot**

```
1. Drag PNG files into res://sprites/
2. Update sprite references in scenes
3. Configure animation frames
4. Import tileset into TileMap (set up tile regions)
5. Repaint arena with final tiles (or keep same layout)
6. Test hitboxes still work
7. Adjust if sprite shapes differ from rectangles
```

**Step 3: Test everything**

```
- All sprites display correctly
- Animations play at right speed
- Hitboxes match visual sprites
- No visual glitches
```

## Why This Works

| Benefit             | Explanation                                |
| ------------------- | ------------------------------------------ |
| No blocking         | Josh doesn't wait for art to code          |
| Parallel progress   | Both working = 2x productivity             |
| Easy swap           | Godot makes sprite replacement simple      |
| Test gameplay first | Prove mechanics work before art investment |
| Art flexibility     | Ericka can iterate without breaking code   |

## Placeholder Code Pattern

```gdscript
# Player.gd - works with placeholder OR real sprite
@onready var sprite = $Sprite2D

func _ready():
    # Sprite can be placeholder (ColorRect) or real (AnimatedSprite2D)
    # Code doesn't care which—just moves the parent node
    pass
```

**Important:** Build scenes so sprite is a child node. Swap the child, parent logic stays the same.

---

## Art Contingency Plan

Given that Ericka is pregnant with baby due March 21, 2026, there is risk of art delays.

**Primary Plan:** Ericka creates all art (target: complete by Week 6 for baby buffer)

**Backup Plans:**

1. Josh creates simplified pixel art (basic shapes, strong silhouettes)
2. Purchase asset packs from itch.io (Filipino-themed if possible)
3. Use free assets from OpenGameArt.org
4. **16x16 Filipino Mythology Asset Pack** (see below)

**16x16 Asset Pack Fallback Strategy:**

We have access to a 16x16 Filipino mythology creature asset pack that can serve as emergency fallback:

- **Upscaling approach:** Use [Lospec Pixel Art Scaler](https://lospec.com/pixel-art-scaler/) to scale 16x16 → 32x32 (2x)
- **Result:** Maintains chunky pixel aesthetic, zero code changes needed
- **Code approach:** All code assumes 32x32 display size; art scales to fit
- **Can mix sources:** Some custom 32x32 + some upscaled 16x16 works fine

**Workflow if using asset pack:**

1. Export 16x16 sprites from asset pack
2. Upload to Lospec Pixel Art Scaler
3. Scale 2x (maintains pixel-perfect edges)
4. Download 32x32 result
5. Import to Godot as normal

**Minimum Viable Art (if backup needed):**

- Player: Must have recognizable shape (even refined placeholder acceptable for EA)
- Enemies: Can use simple shapes with color coding OR upscaled 16x16 pack
- UI: Can use Godot's default theme with custom colors
- Tileset: Can use free tileset assets

**Art Checkpoints (Accelerated):**

| Week   | Required Art                     | Action if Not Ready                     |
| ------ | -------------------------------- | --------------------------------------- |
| Week 4 | Sarimanok (both) + Green Duwende | Josh starts backup art immediately      |
| Week 5 | Red Duwende + Santelmo           | Use recolors OR upscaled 16x16 pack     |
| Week 6 | Manananggal + All Icons          | See Manananggal fallback below          |
| Week 7 | Tileset + UI (nice-to-have)      | Use placeholder tiles, default UI theme |

**Manananggal Boss Fallback:**

The 48x48 animated Manananggal is the highest-risk art asset (5-7 hours, complex design). If it blocks progress:

- **Fallback option:** Use static 48x48 sprite (no animation) that just moves
- **Implementation:** Single frame, bob up/down in code (simple tween)
- **Visual impact:** Still reads as "big scary boss" - animation is nice-to-have
- **Time saved:** 4-5 hours (just need 1 frame instead of 4)

Do NOT let one asset block the entire launch.

**Note:** Black Duwende art deferred to Update 1.

**Why Week 6 deadline:** Baby due March 21. Completing essential art by Week 6 (mid-January) gives 8+ weeks buffer before due date. Tileset and UI polish can happen in Weeks 7-8 if Ericka is able, but are NOT blockers.

**The game is SHIPPABLE with placeholders.** Real art is "Should Have," not "Must Have" for Early Access.

---

# Art Requirements

## Sprite Sizes

| Asset Type               | Size         | Notes                  |
| ------------------------ | ------------ | ---------------------- |
| Characters               | 32x32        | All Sarimanok variants |
| Regular Enemies          | 32x32        | Duwendes, Santelmo     |
| Boss (Manananggal)       | 48x48        | Larger, more detail    |
| Icons (weapons/passives) | 16x16        | Level-up UI            |
| Pickups                  | 16x16        | Small, readable        |
| Projectiles              | 16x16 or 8x8 | Varies by weapon       |

## Complete Asset List

### Player Characters (3 for EA)

| Asset               | Frames | Est. Time      | Priority |
| ------------------- | ------ | -------------- | -------- |
| Sarimanok (Classic) | 2      | 3-4 hrs        | EA       |
| Sarimanok (Shadow)  | 2      | 1 hr (recolor) | EA       |
| Sarimanok (Golden)  | 2      | 1 hr (recolor) | EA       |

**Total EA player time: ~5-6 hrs**

**Note:** Classic Sarimanok requires more time due to elaborate, colorful design. Keep details minimal at 32x32 but capture the iconic silhouette (decorative tail, distinctive head crest). Reference traditional Maranao art for color palette. Shadow and Golden variants are recolors with adjusted palettes.

### Enemies (4 for EA, 1 for Update 1)

| Asset            | Size  | Frames | Est. Time        | Priority |
| ---------------- | ----- | ------ | ---------------- | -------- |
| Green Duwende    | 32x32 | 2      | 2-3 hrs          | EA       |
| Red Duwende      | 32x32 | 2      | 20 min (recolor) | EA       |
| Santelmo         | 32x32 | 2      | 2-3 hrs          | EA       |
| Manananggal Boss | 48x48 | 4      | 5-7 hrs          | EA       |
| Black Duwende    | 32x32 | 2      | 20 min (recolor) | Update 1 |

**Total EA enemy time: ~9.5-13.5 hrs**

**Note:** Manananggal is 48x48 to emphasize boss status. Flying torso with bat-like wings, grotesque but readable silhouette.

### Weapon Icons (6 for EA: 4 Unique + 2 Clone Recolors)

| Asset                | Size  | Est. Time                        | Priority |
| -------------------- | ----- | -------------------------------- | -------- |
| Peck icon            | 16x16 | 30 min                           | EA       |
| Wing Slap icon       | 16x16 | 30 min                           | EA       |
| Feather Shot icon    | 16x16 | 30 min                           | EA       |
| Spiral Feathers icon | 16x16 | 30 min                           | EA       |
| Ice Shard icon       | 16x16 | 15 min (blue recolor of Feather) | EA       |
| Flame Wing icon      | 16x16 | 15 min (orange recolor of Wing)  | EA       |

**Total EA icon time: ~2.5 hrs**

### Weapon Effects (6 for EA: 4 Unique + 2 Clone Recolors)

| Asset              | Size  | Est. Time                              | Priority |
| ------------------ | ----- | -------------------------------------- | -------- |
| Peck hit effect    | 32x32 | 1 hr                                   | EA       |
| Wing Slap circle   | 64x64 | 1-2 hrs                                | EA       |
| Feather projectile | 16x16 | 30 min                                 | EA       |
| Spiral Feathers    | —     | 0 (reuses Feather projectile, rotated) | EA       |
| Ice Shard proj     | 16x16 | 15 min (blue recolor of Feather)       | EA       |
| Flame Wing circle  | 64x64 | 15 min (orange recolor of Wing Slap)   | EA       |

**Total EA effect time: ~3-4 hrs**

**Note:** Clone weapon art is just recoloring existing sprites. Ice Shard = blue Feather, Flame Wing = orange Wing Slap. This adds build variety with minimal art investment (~1 hour total for both clones).

### Passive Icons (4 for EA)

| Asset         | Size  | Est. Time | Priority |
| ------------- | ----- | --------- | -------- |
| Iron Beak     | 16x16 | 30 min    | EA       |
| Thick Plumage | 16x16 | 30 min    | EA       |
| Racing Legs   | 16x16 | 30 min    | EA       |
| Magnetic Aura | 16x16 | 30 min    | EA       |

**Total EA passive time: ~2 hrs**

### Pickups (2)

| Asset     | Size  | Est. Time |
| --------- | ----- | --------- |
| XP Gem    | 16x16 | 30 min    |
| Gold Coin | 16x16 | 30 min    |

**Total pickup time: ~1 hr**

### Environment (Tilemap)

| Asset                         | Size                | Est. Time |
| ----------------------------- | ------------------- | --------- |
| Farm tileset (all tiles)      | 256×128 (8×4 tiles) | 4-6 hrs   |
| Edge decorations (in tileset) | included above      | —         |
| Dawn overlay/effect           | 640×360 gradient    | 1-2 hrs   |

**Total environment time: ~5-8 hrs**

**Tileset Contents (~20-25 tiles):**

- Ground: 6 tiles (grass dark/med/light, dirt dark/med/light)
- Decorations: 6 tiles (rice crop, vegetables, rocks, grass tufts)
- Edges: 8 tiles (fence left/mid/right/post, trees, bahay kubo pieces)
- Extra: 4-6 tiles for variety

**Godot Project Settings:**

```
Display → Window:
  Viewport Width: 640
  Viewport Height: 360
  Stretch Mode: canvas_items
  Stretch Aspect: keep
```

**Bounded Arena Design (60 × 34 tiles):**

```
┌────────────────────────────────────────────────────────────────┐
│ [tree][bahay kubo][fence][fence][fence][fence][tree][tree]     │ ← Row 0-1: Edge tiles
├────────────────────────────────────────────────────────────────┤
│                                                                │
│   [grass][grass][crop][grass][dirt][grass][crop][grass]        │
│                                                                │
│              OPEN PLAY AREA (60 × 30 tiles)                    │
│                    Ground layer: grass/dirt                    │
│                    Decoration layer: scattered crops, rocks    │
│                                                                │
│   [grass][rock][grass][grass][crop][grass][grass][tuft]        │
│                                                                │
├────────────────────────────────────────────────────────────────┤
│ [fence][fence][fence][fence][fence][fence][fence][fence]       │ ← Row 32-33: Edge tiles
└────────────────────────────────────────────────────────────────┘
         ↑ Col 0-1: Edge                    Col 58-59: Edge ↑
```

**Arena Rules:**

- Player cannot walk past arena boundaries (invisible collision walls)
- Enemies spawn just outside boundaries, walk in
- Arena size: 1920 × 1088 pixels (60 × 34 tiles)
- Camera follows player, stops at edges
- Decorations are visual only (no collision except boundaries)
- Edge tiles are decorative—collision is handled by invisible StaticBody2D

**Resolution & Map Specs:**

```
Viewport:      640 × 360 pixels (what camera shows)
Window:        Scales to player's monitor (3× for 1080p, 4× for 1440p)
Map:           1920 × 1088 pixels (60 × 34 tiles)
Tile size:     32 × 32 pixels (matches sprite size)
```

**Why These Numbers:**

- 640×360 viewport scales cleanly: ×3 = 1920×1080, ×4 = 2560×1440
- 32×32 tiles match our sprite size
- 60×34 grid = clean tile math (1920÷32=60, 1088÷32=34)
- Map is 3× viewport = player sees ~1/3 of arena at once

**Tilemap Implementation:**

```
Godot TileMap with 2 layers:
  - Layer 0: Ground (grass, dirt variations)
  - Layer 1: Decorations (crops, rocks, grass tufts) - no collision

Boundaries handled separately (StaticBody2D at map edges)
```

**What Ericka Creates: Tileset PNG**

One tileset image with all tile types (example 256×128 = 8×4 grid):

```
┌────┬────┬────┬────┬────┬────┬────┬────┐
│grass│grass│grass│dirt │dirt │dirt │    │    │  Ground
│dark │med  │light│dark │med  │light│    │    │  variations
├────┼────┼────┼────┼────┼────┼────┼────┤
│crop │crop │crop │rock │rock │grass│grass│    │  Decorations
│rice │veg1 │veg2 │ sm  │ lg  │tuft1│tuft2│    │  (no collision)
├────┼────┼────┼────┼────┼────┼────┼────┤
│fence│fence│fence│fence│tree │tree │bahay│bahay│  Edge pieces
│ L  │ mid │ R  │post │ 1  │ 2  │kubo1│kubo2│  (for boundaries)
├────┼────┼────┼────┼────┼────┼────┼────┤
│    │    │    │    │    │    │    │    │  Extra space
│    │    │    │    │    │    │    │    │  for future
└────┴────┴────┴────┴────┴────┴────┴────┘

Tileset size: 256 × 128 pixels (can be bigger if needed)
~20-25 unique tiles is plenty for MVP
```

**Scene Structure:**

```
Main
├── TileMap (painted using tileset)
│   ├── Layer 0: Ground
│   └── Layer 1: Decorations
├── Boundaries (StaticBody2D - invisible walls at edges)
├── Player (CharacterBody2D)
├── Enemies (Node2D container)
├── Pickups (Node2D container)
└── Camera2D (follows player, limited to map bounds)
```

**Camera Setup:**

```gdscript
# Camera2D settings
camera.limit_left = 0
camera.limit_top = 0
camera.limit_right = 1920
camera.limit_bottom = 1088
camera.position_smoothing_enabled = true
```

**Why Tilemap Over Single Image:**

- Memory efficient (reuse tiles vs one huge texture)
- Easy to edit (tweak layout without redrawing everything)
- Can create new maps easily for future updates
- Godot's TileMap has built-in optimizations

**Placeholder Tilemap:**

- Week 1-6: Simple colored tiles (green for grass, brown for dirt)
- Week 9: Replace tileset PNG with Ericka's finished art

### UI Elements - OUTSOURCED TO ASSET PACK

**Buy a UI asset pack (~$10-15) instead of custom art:**

| Asset                 | Source     | Est. Time |
| --------------------- | ---------- | --------- |
| HP Bar                | Asset pack | 0         |
| XP Bar                | Asset pack | 0         |
| Weapon slots          | Asset pack | 0         |
| Button sprites        | Asset pack | 0         |
| Menu backgrounds      | Asset pack | 0         |
| Level up frame        | Asset pack | 0         |
| Results screen layout | Asset pack | 0         |

**Total UI time: ~0 hrs** (purchased asset pack)

### Pickups - OUTSOURCED TO ASSET PACK

| Asset     | Source     | Est. Time |
| --------- | ---------- | --------- |
| XP Gem    | Asset pack | 0         |
| Gold Coin | Asset pack | 0         |

**Total pickup time: ~0 hrs** (purchased asset pack or included in UI pack)

### Environment (Tilemap) - OUTSOURCED TO ASSET PACK

**Buy a tileset asset pack (~$10-20) instead of custom art:**

| Asset                         | Source                                 | Est. Time |
| ----------------------------- | -------------------------------------- | --------- |
| Farm tileset (all tiles)      | Asset pack                             | 0         |
| Edge decorations (in tileset) | Asset pack                             | 0         |
| Bahay kubo (optional)         | Ericka (1-2 Filipino elements if time) | 1-2 hrs   |
| Dawn overlay/effect           | Simple gradient in Godot               | 30 min    |

**Total environment time: ~0.5-2.5 hrs** (mostly purchased)

## Asset Pack Strategy

**Why outsource generic elements:**

- Filipino identity is in the CHARACTERS and ENEMIES, not the UI or grass tiles
- A farm is a farm - nothing uniquely Filipino about generic tileset
- Saves Ericka ~15-18 hours of work (critical with baby coming)
- Professional-looking assets for $20-40 total

**Buy from asset packs (~$30-50 total):**

- UI kit (buttons, panels, HP/XP bars) - $10-15 from itch.io
- Tileset (grass, dirt, trees, fences) - $10-20 from itch.io
- Pickups (gems, coins) - often included in UI kit

**Ericka creates (cultural identity - this is what makes the game FILIPINO):**

- Sarimanok (all 3 variants) - **Classic FIRST for demo**
- All enemies (Duwendes, Santelmo, Manananggal)
- Weapon icons (bird-themed)
- 1-2 Filipino tileset elements (bahay kubo, rice crops) - optional

## Total Art Summary (Updated with Outsourcing)

| Category                  | Source     | Ericka Time   | Update 1        |
| ------------------------- | ---------- | ------------- | --------------- |
| Player (3 variants)       | Ericka     | 5-6 hrs       | —               |
| Enemies (4 for EA)        | Ericka     | 9.5-13.5 hrs  | +20 min (Black) |
| Weapon icons              | Ericka     | 2 hrs         | —               |
| Weapon effects            | Ericka     | 2.5-3.5 hrs   | —               |
| Passive icons             | Asset pack | 0             | —               |
| Pickups                   | Asset pack | 0             | —               |
| Environment (tileset)     | Asset pack | 0             | —               |
| Filipino tiles (optional) | Ericka     | 1-2 hrs       | —               |
| UI                        | Asset pack | 0             | —               |
| **ERICKA TOTAL**          | —          | **18-24 hrs** |                 |
| **ASSET PACK COST**       | —          | **$30-50**    |                 |

**Previous total: 36-46 hrs → New total: 18-24 hrs (HALVED!)**

At 10 hrs/week art = **2-2.5 weeks** of art (parallel to coding) - much more achievable with baby timeline!

---

## Steam Marketing Art (Capsule Images)

> **Critical for Next Fest:** Your Steam capsule art is the single most important marketing asset. It determines click-through rates and wishlist conversions. Bad capsule = no clicks = no wishlists.

**Required Steam Assets:**

| Asset          | Size      | Priority     | Notes                                       |
| -------------- | --------- | ------------ | ------------------------------------------- |
| Main Capsule   | 616×353   | **CRITICAL** | Shows in search, browse, Next Fest listings |
| Small Capsule  | 231×87    | Required     | Shows in wishlists, library                 |
| Header Capsule | 460×215   | Required     | Shows on store page header                  |
| Library Hero   | 3840×1240 | Nice-to-have | Shows in Steam library (big mode)           |
| Library Logo   | 1280×720  | Nice-to-have | Shows in Steam library                      |

**Recommendation:** Do NOT use scaled pixel art for the main capsule—it usually looks amateur at Steam's display sizes. Options:

1. **Commission illustration** (~$200-400 from Fiverr/ArtStation) - Professional, eye-catching - **RECOMMENDED**
2. **Ericka creates high-res illustration** (10-15 hrs) - Custom, matches game vision
3. **Last resort:** Composite of upscaled sprites with strong typography and effects

### Artist Sourcing Timeline

| Week     | Action                                              | Time Investment |
| -------- | --------------------------------------------------- | --------------- |
| Week 4-5 | Browse artists, save 5-10 candidates                | 2-3 hours total |
| Week 6   | Review portfolios, contact top 3, commission winner | 1-2 hours       |
| Week 6-7 | Artist works (5-10 business days typical)           | -               |
| Week 8   | Receive final art, request revisions if needed      | 30 min          |
| Week 8   | Upload to Steam store page                          | 15 min          |

### Where to Find Artists

| Platform                 | Price Range | How to Search                                             |
| ------------------------ | ----------- | --------------------------------------------------------- |
| **Fiverr**               | $100-300    | Search "Steam capsule art" or "game key art illustration" |
| **ArtStation**           | $200-500    | Browse "Games" category, filter by style                  |
| **Twitter/X**            | $150-400    | Search #commissionsopen #gameart                          |
| **r/gameDevClassifieds** | $100-300    | Post your brief with budget                               |
| **r/HungryArtists**      | $80-250     | Post commission request                                   |

### What to Look For in Portfolio

- Previous game art or key art (not just character art)
- Dynamic compositions with action/energy
- Filipino or Southeast Asian cultural art experience (bonus)
- Clean typography integration in existing work
- Pixel art stylization OR painterly game art style

### Commission Brief Template (Save for Week 6)

```
PROJECT: Steam Capsule Art for "Sarimanok Survivor"
SIZE: 616x353 pixels (can work larger, will scale down)
STYLE: Painterly/stylized (NOT pixel art)
DEADLINE: 10 business days

SUBJECT: The Sarimanok (legendary Filipino bird) in heroic pose,
facing off against shadowy creatures (duwendes/aswang) at night.
Moon or mystical light in background. Filipino folklore aesthetic.

MUST INCLUDE:
- Sarimanok as central focus (colorful, vibrant)
- Night/dusk atmosphere
- Space for game title text (top or bottom)
- Action/energy feel (this is a survivor game)

REFERENCE IMAGES: [Attach Sarimanok reference art + similar game capsules]

BUDGET: $XXX (include 1 revision round)
```

### Backup Plan

If commission falls through or quality is poor:

1. Request full refund (Fiverr has buyer protection)
2. Ericka creates simplified illustration (4-6 hours emergency sprint)
3. Use high-quality composite: upscaled Sarimanok sprite + professional typography + gradient background (serviceable, not ideal)

**Tip:** Look at successful survivor games on Steam for capsule art inspiration. Notice how few use raw pixel art.

---

# Audio Requirements

## Music (4 tracks)

| Track          | Purpose                 | Notes                      |
| -------------- | ----------------------- | -------------------------- |
| Menu theme     | Main menu               | Calm, Filipino-inspired    |
| Night theme    | Main gameplay           | Tense, action              |
| Boss theme     | When Manananggal spawns | Intense, dramatic          |
| Victory jingle | Dawn/win                | Triumphant, Sarimanok crow |

## Sound Effects (16)

| Sound           | Trigger            |
| --------------- | ------------------ |
| Peck attack     | Weapon fires       |
| Wing Slap       | Weapon fires       |
| Feather Shot    | Weapon fires       |
| Spiral Feathers | Orbiting feathers  |
| Enemy hit       | Damage dealt       |
| Enemy death     | Enemy killed       |
| Player hurt     | Take damage        |
| Player death    | HP = 0             |
| XP pickup       | Collect gem        |
| Gold pickup     | Collect coin       |
| Level up        | XP bar fills       |
| Menu click      | Button press       |
| Menu hover      | Mouse over button  |
| Cockadoodledoo  | Victory            |
| Aswang roar     | Boss spawn         |
| Dawn ambience   | Victory transition |

## Audio Specifications

**Music:**

| Property       | Value                                   |
| -------------- | --------------------------------------- |
| Loop Length    | 1-2 minutes per track                   |
| Format         | OGG Vorbis (smaller file size than WAV) |
| Transitions    | 0.5 second crossfade between tracks     |
| Volume Default | 80% (allow headroom for SFX)            |

**Sound Effects:**

| Property                     | Value                                            |
| ---------------------------- | ------------------------------------------------ |
| Format                       | WAV (16-bit, 44.1kHz)                            |
| Max Simultaneous             | 8 sounds playing at once                         |
| Priority (highest to lowest) | Player hurt > Pickup > Level up > Weapon > Enemy |
| Polyphony Limit              | 3 instances of same sound simultaneously         |

**Pitch Randomization (CRITICAL for repetitive sounds):**

Repetitive sounds (enemy hit, enemy death, pickups) will play 10,000+ times per run. Without pitch variation, they become annoying and fatiguing. Apply pitch randomization to all high-frequency sounds:

```gdscript
# AudioManager.gd - Pitch randomization for repetitive sounds
func play_sfx(sound_name: String, pitch_variance: float = 0.1):
    var player = get_available_audio_player()
    player.stream = sfx_library[sound_name]
    player.pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
    player.play()

# Usage:
# play_sfx("enemy_hit", 0.1)  # Plays at 0.9x to 1.1x pitch
# play_sfx("enemy_death", 0.15)  # Wider variance for death sounds
# play_sfx("pickup_xp", 0.1)
```

**Priority SFX (must feel satisfying - test these 100+ times!):**

| Sound       | Priority | Pitch Variance | Notes                              |
| ----------- | -------- | -------------- | ---------------------------------- |
| Enemy hit   | HIGH     | ±10%           | Most frequent - must not annoy     |
| Enemy death | HIGH     | ±15%           | Satisfying "pop" feel              |
| XP pickup   | HIGH     | ±10%           | Subtle, rewarding                  |
| Gold pickup | MEDIUM   | ±10%           | Slightly different from XP         |
| Player hurt | HIGH     | ±5%            | Less variance - should feel urgent |

**Music Triggers:**

| Event                      | Action                                |
| -------------------------- | ------------------------------------- |
| Enter Main Menu            | Play Menu theme (loop)                |
| Start Run                  | Crossfade to Night theme              |
| Manananggal Spawns (20:00) | Crossfade to Boss theme               |
| Victory (30:00)            | Cut to Victory jingle + Dawn ambience |
| Player Death               | Fade out music over 1 second          |

## Audio Sources

**START BROWSING MUSIC NOW!** Finding the right vibe takes time. Don't wait until Week 9.

**Sound Effects (Free):**

- freesound.org (CC0 sound effects)
- opengameart.org (free game audio)
- BFXR (generate retro sound effects)

**Music Options (Pick ONE approach):**

| Option            | Cost      | Pros                               | Cons                               |
| ----------------- | --------- | ---------------------------------- | ---------------------------------- |
| Pixabay Music     | Free      | No attribution, large library      | Generic, may not fit Filipino vibe |
| Epidemic Sound    | $15/month | High quality, huge library         | Subscription model                 |
| Fiverr Commission | $50-150   | Custom, can request Filipino style | Takes time, variable quality       |
| OpenGameArt       | Free      | Game-focused                       | Limited selection                  |

**Recommendation:** Start with free sources (Pixabay, OpenGameArt). If nothing fits, commission from Fiverr with specific direction: "Filipino-inspired chiptune/pixel art game music, night survival theme, boss battle intensity"

## Audio Sourcing Strategy (Do in Week 1-2!)

### Sound Effects Pack (Buy Early - Don't Hunt Individual Sounds!)

**Recommendation**: Purchase a cohesive SFX pack rather than hunting 20+ individual sounds. This saves HOURS of curation time.

| Source                                                | Cost   | Contents                    | Pros                        |
| ----------------------------------------------------- | ------ | --------------------------- | --------------------------- |
| [Gamedev Market](https://www.gamedevmarket.net)       | $15-30 | Fantasy RPG SFX bundles     | Cohesive, game-ready        |
| [Humble Bundle Audio](https://humblebundle.com)       | $15-25 | Periodic game audio bundles | Great value if timing works |
| [Sonniss GDC Audio](https://sonniss.com/gameaudiogdc) | Free   | 30GB+ professional sounds   | Requires curation time      |

**Action**: Browse and purchase a Fantasy/RPG SFX pack in Week 1. Having cohesive audio assets ready prevents the "hunting for sounds" time sink in Week 9.

### Music Strategy

1. **First choice**: Pixabay Music (free, no attribution)
2. **Backup**: Fiverr commission ($50-150 for 4 tracks)
3. **Browse NOW** - Finding the right vibe takes time. Don't wait until Week 9!

### Pitch Randomization (Already specified in Weeks 2-3)

The PRD correctly specifies pitch randomization for repetitive sounds. This is CRITICAL - without it, hearing the same "enemy hit" sound 10,000 times per run causes ear fatigue.

---

# Technical Specifications

## Engine & Version

- **Godot 4.x** (latest stable)
- GDScript (not C#)

## Target Performance

| Metric            | Target           |
| ----------------- | ---------------- |
| FPS               | 60 stable        |
| Enemies on screen | 200+ without lag |
| Load time         | < 3 seconds      |
| File size         | < 200 MB         |

## Resolution

- **Target:** 1920x1080
- **Minimum:** 1280x720
- **Scaling:** Viewport stretch mode

## Controls

| Input         | Action          |
| ------------- | --------------- |
| WASD / Arrows | Move            |
| ESC           | Pause           |
| Mouse         | Menu navigation |
| Click         | Select          |

## Input Action Mapping (Godot Project Settings)

Configure these in Project Settings > Input Map before coding begins:

| Action Name | Primary Key | Secondary Key | Controller                     |
| ----------- | ----------- | ------------- | ------------------------------ |
| move_up     | W           | Up Arrow      | D-pad Up / Left Stick Up       |
| move_down   | S           | Down Arrow    | D-pad Down / Left Stick Down   |
| move_left   | A           | Left Arrow    | D-pad Left / Left Stick Left   |
| move_right  | D           | Right Arrow   | D-pad Right / Left Stick Right |
| pause       | Escape      | —             | Start Button                   |
| ui_accept   | Enter       | Space         | A Button (Xbox) / Cross (PS)   |
| ui_cancel   | Escape      | —             | B Button (Xbox) / Circle (PS)  |

**Usage in code:**

```gdscript
func _process(delta):
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    input_vector = input_vector.normalized()

    velocity = input_vector * move_speed
    move_and_slide()
```

**Note:** Using `get_action_strength()` instead of `is_action_pressed()` allows analog stick support for smooth movement.

## Performance Architecture

### Object Pooling

Pre-allocate pools at game start to avoid runtime instantiation:

| Pool            | Size         | Purpose                    |
| --------------- | ------------ | -------------------------- |
| Enemy pool      | 300          | Reuse enemy instances      |
| Projectile pool | 200          | Feathers, fireballs        |
| Pickup pool     | 500          | XP gems + Gold coins       |
| Particle pool   | 100 per type | Death effects, hit effects |

**Rules:**

- Never use `queue_free()` during gameplay - return to pool instead
- Never instantiate during gameplay - pull from pool
- Pre-warm pools in `_ready()` of main scene

```gdscript
# Example pool pattern
var enemy_pool: Array[Enemy] = []
const POOL_SIZE = 300

func _ready():
    for i in POOL_SIZE:
        var enemy = enemy_scene.instantiate()
        enemy.set_process(false)
        enemy.visible = false
        enemy_pool.append(enemy)
        add_child(enemy)

func spawn_enemy() -> Enemy:
    for enemy in enemy_pool:
        if not enemy.active:
            enemy.activate()
            return enemy
    return null  # Pool exhausted
```

### Spatial Partitioning

With 200+ enemies, naive collision checks become O(n²). Use grid-based spatial hashing:

- Grid cell size: 64x64 pixels (2x enemy size)
- Only check collisions between entities in same/adjacent cells
- Update entity grid position when they move cells, not every frame

```gdscript
# Grid-based spatial hash
var spatial_grid: Dictionary = {}  # Vector2i -> Array[Enemy]
const CELL_SIZE = 64

func get_cell(pos: Vector2) -> Vector2i:
    return Vector2i(int(pos.x / CELL_SIZE), int(pos.y / CELL_SIZE))

func get_nearby_enemies(pos: Vector2) -> Array[Enemy]:
    var cell = get_cell(pos)
    var nearby: Array[Enemy] = []
    for dx in range(-1, 2):
        for dy in range(-1, 2):
            var check_cell = cell + Vector2i(dx, dy)
            if spatial_grid.has(check_cell):
                nearby.append_array(spatial_grid[check_cell])
    return nearby
```

### Rendering Optimization

- Use sprite atlases (single texture for all enemies)
- Limit particle count per weapon (max 50 particles active per weapon)
- Use CanvasGroup for batching similar sprites
- Disable processing for off-screen enemies (VisibleOnScreenNotifier2D)

### Performance Milestones

| Week    | Test            | Target                |
| ------- | --------------- | --------------------- |
| Week 3  | 100 enemies     | 60 FPS stable         |
| Week 6  | 200 enemies     | 60 FPS stable         |
| Week 11 | Full 30-min run | No drops below 45 FPS |

**If performance issues occur:**

1. Profile with Godot's built-in profiler
2. Check if GPU or CPU bound
3. Reduce particle counts first
4. Simplify collision checks
5. Reduce spawn rate as last resort

---

## Save Data

Save file location: `user://save_data.json`

```json
{
  "gold": 350,
  "shop_damage": 6,
  "shop_hp": 15,
  "shop_speed": 3,
  "endless_unlocked": true,
  "high_score_story": 12450,
  "high_score_endless": 8200,
  "best_time_story": "30:00",
  "best_time_endless": "47:23",
  "settings": {
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "fullscreen": false
  }
}
```

### Save File Safety

**Always backup before writing** to prevent data loss from crashes or power failures:

```gdscript
func save_game():
    # Backup existing save before overwriting
    if FileAccess.file_exists("user://save_data.json"):
        var backup_path = OS.get_user_data_dir() + "/save_data.backup.json"
        var source_path = OS.get_user_data_dir() + "/save_data.json"
        DirAccess.copy_absolute(source_path, backup_path)

    # Then write new save...
    var save_data = { ... }
    var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(save_data))
```

**Why this matters**: If save write fails mid-operation (crash, power loss), the backup ensures the player doesn't lose ALL progress - just the most recent run.

## GameState Singleton

```gdscript
# GameState.gd - Autoload Singleton
extends Node

# ═══════════════════════════════════════════════
# SAVE FILE VERSIONING
# ═══════════════════════════════════════════════
const SAVE_VERSION = 1  # Increment when save format changes

# ═══════════════════════════════════════════════
# PERSISTENT DATA (Saved to file)
# ═══════════════════════════════════════════════
var gold: int = 0
var shop_damage: int = 0      # Times bought
var shop_hp: int = 0          # Times bought
var shop_speed: int = 0       # Times bought
var endless_unlocked: bool = false
var shadow_unlocked: bool = false   # Unlock: survive 15:00 in Story Mode
var golden_unlocked: bool = false   # Unlock: beat Story Mode (30:00)
var high_score_story: int = 0
var high_score_endless: int = 0
var best_time_endless: float = 0.0
var best_time_story: float = 0.0    # Track best survival time in Story Mode

# ═══════════════════════════════════════════════
# RUN DATA (Resets each run)
# ═══════════════════════════════════════════════
var current_hp: int = 100
var max_hp: int = 100
var current_xp: int = 0
var xp_to_next_level: int = 5
var level: int = 1
var score: int = 0
var gold_this_run: int = 0
var time_survived: float = 0.0
var enemies_killed: int = 0

# Weapons: Array of {id, level}
var weapons: Array = []
const MAX_WEAPONS = 3

# Passives: Dictionary of {id: level}
var passives: Dictionary = {}

# ═══════════════════════════════════════════════
# COMPUTED STATS (Base + Shop + Passives)
# ═══════════════════════════════════════════════
func get_damage_multiplier() -> float:
    var shop_bonus = shop_damage * 0.02  # +2% per purchase
    var passive_bonus = passives.get("iron_beak", 0) * 0.10  # +10% per level
    return 1.0 + shop_bonus + passive_bonus

func get_max_hp() -> int:
    var shop_bonus = shop_hp * 5  # +5 per purchase
    var passive_bonus = passives.get("thick_plumage", 0) * 15  # +15 per level
    return 100 + shop_bonus + passive_bonus

func get_move_speed() -> float:
    var base = 200.0
    var shop_bonus = shop_speed * 0.01  # +1% per purchase
    var passive_bonus = passives.get("racing_legs", 0) * 0.10  # +10% per level
    return base * (1.0 + shop_bonus + passive_bonus)

func get_pickup_range() -> float:
    var base = 50.0  # Base pickup range in pixels
    var passive_bonus = passives.get("magnetic_aura", 0) * 0.20  # +20% per level
    return base * (1.0 + passive_bonus)

# ═══════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════
func reset_run():
    """Call at start of each run."""
    current_xp = 0
    xp_to_next_level = 5
    level = 1
    score = 0
    gold_this_run = 0
    time_survived = 0.0
    enemies_killed = 0
    weapons = [{id = "peck", level = 1}]  # Start with Peck
    passives = {}
    max_hp = get_max_hp()
    current_hp = max_hp

func end_run(won: bool):
    """Call when run ends."""
    gold += gold_this_run
    if won:
        score += 1000  # Victory bonus
        endless_unlocked = true
    if score > high_score_story:
        high_score_story = score
    save_game()

func add_weapon(weapon_id: String):
    if weapons.size() < MAX_WEAPONS:
        weapons.append({id = weapon_id, level = 1})

func upgrade_weapon(weapon_id: String):
    for w in weapons:
        if w.id == weapon_id:
            w.level += 1

func add_passive(passive_id: String):
    if not passives.has(passive_id):
        passives[passive_id] = 1
    else:
        passives[passive_id] += 1

func save_game():
    var save_data = {
        "save_version": SAVE_VERSION,  # Always include version
        "gold": gold,
        "shop_damage": shop_damage,
        "shop_hp": shop_hp,
        "shop_speed": shop_speed,
        "endless_unlocked": endless_unlocked,
        "high_score_story": high_score_story,
        "high_score_endless": high_score_endless,
        "best_time_endless": best_time_endless,
        "shadow_unlocked": shadow_unlocked,
        "golden_unlocked": golden_unlocked
    }
    var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(save_data))

func load_game():
    if FileAccess.file_exists("user://save_data.json"):
        var file = FileAccess.open("user://save_data.json", FileAccess.READ)
        var data = JSON.parse_string(file.get_as_text())

        # Check save version and migrate if needed
        var version = data.get("save_version", 0)
        if version < SAVE_VERSION:
            data = migrate_save(data, version)

        gold = data.get("gold", 0)
        shop_damage = data.get("shop_damage", 0)
        shop_hp = data.get("shop_hp", 0)
        shop_speed = data.get("shop_speed", 0)
        endless_unlocked = data.get("endless_unlocked", false)
        high_score_story = data.get("high_score_story", 0)
        high_score_endless = data.get("high_score_endless", 0)
        best_time_endless = data.get("best_time_endless", 0.0)
        shadow_unlocked = data.get("shadow_unlocked", false)
        golden_unlocked = data.get("golden_unlocked", false)

func migrate_save(data: Dictionary, from_version: int) -> Dictionary:
    """Migrate old save files to current version."""
    # Example: if from_version < 1, add new fields with defaults
    # Add migration logic here as save format evolves
    return data
```

---

# Development Roadmap (14 Weeks - Vertical Slices + Next Fest)

**Start:** December 1, 2025  
**Next Fest:** February 23 - March 2, 2026 (Demo live!)  
**Launch:** ~March 8, 2026 (Right after Next Fest)  
**Baby Due:** March 21, 2026  
**Buffer:** ~2 weeks before baby

## Time Model

**"Week" = ~40 hours of focused work, roughly aligned with calendar weeks**

- Each "week" targets 40 hours of development
- If you finish early, move to the next week
- If you need more time, extend into the next calendar week
- You're working full-time on this, so you have buffer built in
- The 13-week timeline is conservative for full-time work

**Pace warning:** Don't burn out before launch. Rest days are productive days. You need energy for launch week AND for when the baby comes.

**Key Principle:** Every week ends with a PLAYABLE GAME. You can hit F5 and play. It just does MORE each week.

---

## ⚠️ BEFORE WEEK 1 - DO TODAY (Not Week 1!)

> **URGENT:** Steam verification can take 1-4 weeks. You MUST start this process IMMEDIATELY to meet the January 5, 2026 Next Fest registration deadline. You cannot register for Next Fest without a LIVE "Coming Soon" store page, and you cannot have a store page without completed verification.

**Do these TODAY (December 3, 2025):**

- [ ] **Pay $100 Steam Direct fee** - [partner.steamgames.com](https://partner.steamgames.com)
- [ ] **Start Steamworks account verification** - Submit ID, tax info, bank details
- [ ] **Monitor verification status daily** - Follow up if no progress after 5 business days

**Why this can't wait:** If verification stalls over the holidays (Dec 23 - Jan 1), you risk missing the Jan 5 deadline entirely. Starting today gives you 4+ weeks buffer.

### Steam Verification Timeline (Detailed)

| Day           | Action                        | Notes                             |
| ------------- | ----------------------------- | --------------------------------- |
| Day 1 (Today) | Pay $100 Steam Direct fee     | Creates Steamworks account        |
| Day 1         | Submit identity verification  | Government ID required            |
| Day 2-7       | Identity verification pending | Typically 2-5 business days       |
| Day 7-14      | Submit bank/tax info          | Only available after ID verified  |
| Day 14-28     | Bank/tax verification         | Can take 1-3 weeks                |
| Day 28+       | 30-day waiting period starts  | Cannot release until this expires |

**CRITICAL**: You cannot create a store page until verification completes.
**Risk**: If verification stalls over holidays (Dec 23 - Jan 1), you risk missing Jan 5 Next Fest deadline.
**Mitigation**: Start TODAY. Follow up with Steam Support if no progress after 5 business days.

---

## Week 1: The Core Loop

**End State: "I can play a survivor game"**

What's playable at end of week:

- Sarimanok moves with WASD in a bounded arena
- Peck attack fires automatically
- Green Duwendes spawn and walk toward player
- Duwendes die when hit, drop XP gem (placeholder)
- Player dies when HP = 0
- Game over screen shows "You died"

**CRITICAL PARALLEL TASKS (Steam Setup for Next Fest):**

- [ ] **STEAM:** Pay $100 Steam Direct fee (do this Day 1!)
- [ ] **STEAM:** Start Steamworks account verification (ID, tax info - takes 3-7 days)
- [ ] **ASSETS:** Buy UI asset pack (buttons, panels, HP/XP bars) - ~$10-15
- [ ] **ASSETS:** Buy tileset asset pack (grass, dirt, trees, fences) - ~$10-20

**Tasks:**

- [ ] Create project structure
- [ ] Set up project settings (640×360 viewport, canvas_items stretch)
- [ ] **Configure Input Map in Project Settings with controller bindings from Day 1**
- [ ] Create TileMap with placeholder tileset (simple colored squares)
- [ ] Paint basic 60×34 arena with placeholder tiles
- [ ] Set up Camera2D with limits (0,0 to 1920,1088)
- [ ] Add invisible boundary collision (StaticBody2D)
- [ ] Implement player movement (WASD) using `Input.get_action_strength()` for analog support
- [ ] Create placeholder Sarimanok sprite (colored rectangle 32x32)
- [ ] Implement Peck attack (auto-fire, cooldown)
- [ ] Create placeholder Duwende (green rectangle 32x32)
- [ ] Duwende walks toward player
- [ ] Duwende takes damage from Peck
- [ ] Duwende dies and drops placeholder XP gem
- [ ] Player takes damage from enemy contact
- [ ] Player dies at 0 HP, shows game over
- [ ] **Use `tr()` function for all UI text strings (localization prep - costs nothing now)**

**Integration Test:** Can you survive for 60 seconds dodging and pecking?

---

## Week 2: Progression Loop

**End State: "I can level up and get stronger"**

Builds on Week 1, adds:

- XP gems are collected and fill XP bar
- Level up pauses game, shows 3 choices
- Choices: Peck +1, Wing Slap (new), Iron Beak (new)
- Wing Slap weapon works (AOE circle)
- Iron Beak passive increases damage
- Red Duwende spawns (recolor, higher stats)
- Timer shows on screen (counts up)

**Tasks:**

- [ ] XP gem pickup works
- [ ] XP bar UI displays
- [ ] Level up triggers at threshold
- [ ] Level up screen pauses game
- [ ] Display 3 random choices (placeholder buttons)
- [ ] Clicking choice applies upgrade and resumes game
- [ ] Wing Slap weapon (AOE circle around player)
- [ ] Iron Beak passive (damage boost)
- [ ] Add Red Duwende (recolor, different stats)
- [ ] Timer displays on screen
- [ ] Enemy stat scaling (HP/damage increase over time)
- [ ] **Placeholder SFX: Peck attack sound (use BFXR or free sound pack)**
- [ ] **Placeholder SFX: Enemy hit sound**
- [ ] **Placeholder SFX: XP pickup sound**

**Integration Test:** Can you reach level 10 with 2 weapons + 1 passive?

---

## Week 3: Full Arsenal + Data-Driven Architecture

**End State: "I can build different weapon combos with scalable architecture"**

Builds on Week 2, adds:

- Feather Shot weapon (projectile toward nearest enemy)
- All 4 passives working (Thick Plumage, Racing Legs, Magnetic Aura)
- All weapons/passives upgrade to level 5
- **Data-driven WeaponData Resource system**
- **2 Clone weapons (Ice Shard, Flame Wing) for build variety**
- **Damage numbers on enemy hit (debugging tool)**
- **Enemy damage flash (white flash on hit)**

**Tasks:**

- [ ] Feather Shot weapon (projectile)
- [ ] Thick Plumage passive (+HP)
- [ ] Racing Legs passive (+speed)
- [ ] **Spiral Feathers weapon (4 feathers orbit player, damage on contact)**
- [ ] **Magnetic Aura passive (+20% pickup range per level, max 5 = +100%)**
- [ ] **WeaponData Resource class (data-driven weapon definitions)**
- [ ] **Debuff system (slow effect for Ice Shard)**
- [ ] **Ice Shard clone weapon (blue Feather Shot + 0.5s slow debuff)**
- [ ] **Flame Wing clone weapon (orange Wing Slap, +20% damage, smaller radius)**
- [ ] Weapon upgrades to level 5 work
- [ ] Passive upgrades to level 5 work
- [ ] Max 6 weapons enforced in level-up pool
- [ ] Level-up pool includes all weapons/passives correctly
- [ ] **Damage numbers (floating text on enemy hit - CRITICAL for balance testing)**
- [ ] **Enemy damage flash (white flash on hit - game feel)**
- [ ] **Placeholder SFX: Wing Slap sound**
- [ ] **Placeholder SFX: Feather Shot sound**
- [ ] **Placeholder SFX: Spiral Feathers sound**
- [ ] **Placeholder SFX: Enemy death sound**
- [ ] **Placeholder SFX: Gold pickup sound**

**Integration Test:** Can you max out 6 weapons and 4 passives in one run? Do damage numbers appear on hits?

---

## Week 4: Win Condition

**End State: "I can WIN the game"**

Builds on Week 3, adds:

- Santelmo enemy (floats, shoots fireballs)
- Manananggal boss spawns at 20:00
- Victory at 30:00 (COCKADOODLEDOO!)
- Results screen (time, kills, score)
- Gold drops from enemies
- Gold persists after run (saved to file)

**CRITICAL PARALLEL TASKS (Steam Store Page):**

- [ ] **STEAM:** Steamworks verification should be complete by now
- [ ] **STEAM:** Create "Coming Soon" store page draft (description, placeholder screenshots)
- [ ] **STEAM:** Submit store page for review (allow holiday buffer! Review takes 2-5 business days)

**Tasks:**

- [ ] Santelmo enemy (floats, shoots fireballs)
- [ ] Fireball projectile damages player
- [ ] Manananggal boss (spawns at 20:00)
- [ ] Boss has visible HP bar
- [ ] Timer triggers victory at 30:00
- [ ] Victory screen with dawn effect
- [ ] Defeat screen at 0 HP
- [ ] Results screen shows time, kills, score, gold
- [ ] Gold coins drop from enemies
- [ ] Gold persists in save file between runs

**Integration Test:** Can you beat the game (survive to 30:00)?

_Note: This is a holiday week (late December) - scope is appropriate. Submit store page BEFORE Christmas break!_

---

## Week 5: Meta Progression

**End State: "Dying makes me stronger for next run"**

Builds on Week 4, adds:

- Main menu (Story Mode, Shop, Quit)
- Shop screen with 3 upgrades (Damage, HP, Speed)
- Shop upgrades apply at run start
- Shop upgrades persist in save file
- Gold deducts on purchase

**CRITICAL PARALLEL TASKS (Next Fest Registration - DEADLINE JAN 5!):**

- [ ] **STEAM:** Store page should be LIVE after review approval
- [ ] **STEAM:** Register for Steam Next Fest February 2026 by January 5 deadline!
- [ ] **STEAM:** Update store page with any new screenshots from gameplay

**Tasks:**

- [ ] Main menu screen (Story Mode, Shop, Quit)
- [ ] Add loading screen tagline ("The Sarimanok guards the land through the night...")
- [ ] Shop screen UI (use purchased UI asset pack)
- [ ] Buy Damage upgrade (+2% per purchase)
- [ ] Buy HP upgrade (+5 per purchase)
- [ ] Buy Speed upgrade (+1% per purchase)
- [ ] Upgrades save to file
- [ ] Upgrades apply at run start
- [ ] Gold deducts correctly on purchase
- [ ] BUY button disabled when insufficient gold

**Integration Test:** Die, buy upgrade, start new run - are you stronger?

---

## Week 6: Character Select & Endless Mode

**End State: "I can pick characters and play Endless Mode"**

Builds on Week 5, adds:

- Character select screen (2 Sarimanoks with different stats)
- Shadow Sarimanok unlocks at 15:00 survived (Story Mode)
- High score tracking for Story Mode
- Simplified Endless Mode (unlocks after beating Story Mode)

**PARALLEL TASK: Submit Steam store page for review (verification should be done by now)**

**Tasks:**

- [ ] Character select screen before run
- [ ] Classic Sarimanok (default, balanced stats)
- [ ] Shadow Sarimanok (80 HP, 125% damage - glass cannon)
- [ ] **Golden Sarimanok (130 HP, 85% speed, 100% damage - tank build)**
- [ ] Lock/unlock display with requirements shown
- [ ] Shadow unlocks: survive 15:00 in Story Mode (single run)
- [ ] **Golden unlocks: beat Story Mode (survive to 30:00)**
- [ ] High score tracking for Story Mode
- [ ] Simplified Endless Mode (disable 30:00 win condition, keep everything else)
- [ ] Endless Mode unlocks after beating Story Mode
- [ ] Endless Mode best time tracking
- [ ] **STEAM:** Submit store page for review

**Integration Test:** Survive 15:00, unlock Shadow, beat Story Mode, unlock Golden and Endless Mode

**MINIMUM VIABLE PRODUCT CHECKPOINT:**

```
At the end of Week 6, you have a SHIPPABLE game:
- Complete survivor game with core loop
- 3 characters, 4 enemies, 4 weapons, 4 passives
- Story Mode + Endless Mode
- Shop progression
- Save system
- Placeholder SFX for game feel
- This is SHIPPABLE as Early Access!
```

---

## Week 7: Polish Pass 1 + Controller UX Polish

**End State: "The game FEELS good and controller experience is polished"**

> **IMPORTANT DISTINCTION:**
>
> - **Week 1**: Core controller INPUT was set up using `Input.get_action_strength()` - the game WORKS with controllers from Day 1
> - **Week 7**: Controller UX POLISH - making the experience feel native:
>   - UI navigation with D-pad/stick (menu navigation)
>   - Dynamic button prompt icons (Xbox vs PlayStation vs keyboard icons)
>   - Input device switching detection (prompts update when player switches from keyboard to controller mid-game)
>   - Dead zone tuning and stick sensitivity adjustments

Builds on Week 6, adds:

- Settings menu (Music volume, SFX volume, Fullscreen, Screen Shake toggle)
- Integrated tutorial through level design (NOT overlay system)
- Screen shake on hits
- Invincibility flash when damaged
- Enemy death particles
- Pickup magnet visual
- Controller UX polish (UI navigation + button prompts + device switching)

**Tasks:**

- [ ] Settings menu accessible from main menu and pause
- [ ] Music volume slider
- [ ] SFX volume slider
- [ ] Fullscreen toggle
- [ ] Screen shake toggle (accessibility)
- [ ] **Reduced motion option (disable particles for motion-sensitive players)**
- [ ] **Colorblind mode consideration (Green/Red Duwende distinction - add shape/size difference)**
- [ ] Settings persist in save file
- [ ] **Tutorial through level design (NOT overlays):**
  - [ ] First 30 seconds: spawn pattern forces player to discover movement
  - [ ] First weapon pickup placed in obvious path (learn by doing)
  - [ ] First level-up is semi-scripted to demonstrate system
  - [ ] Minimal text - icon-based learning where possible
  - [ ] Brief "Survive until dawn" goal text at run start (fades after 3s)
- [ ] Screen shake on enemy hits
- [ ] Flash effect when player takes damage
- [ ] Particle effect on enemy death
- [ ] Visual feedback for pickup magnet range
- [ ] **Level-up screen juice (particle burst, scale animation)**
- [ ] **In-game bug report button (links to Google Form or Discord)**
- [ ] Controller UI navigation (D-pad/stick for menus - core input already works from Week 1)
- [ ] Controller button prompts (show controller icons if controller detected)
- [ ] **Input device switching detection (3-5 hrs):**
  - [ ] Track last input method (keyboard vs controller)
  - [ ] Swap UI prompt icons dynamically when device changes
  - [ ] Test switching mid-game (should update prompts immediately)
- [ ] **Test controller gameplay feel (stick sensitivity, dead zones)**
- [ ] **Test text legibility at 1280x720 window (Steam Deck resolution)**

**Integration Test:** Play entire run with controller, switch to keyboard mid-game (prompts should update), verify tutorial teaches without blocking gameplay

---

## Week 8: Art Integration

**End State: "The game LOOKS good"**

This week focuses on swapping placeholders for real sprites:

- Import Sarimanok sprites (all variants)
- Import Duwende sprites (Green + Red)
- Import Santelmo sprite
- Import Manananggal sprite
- Import purchased tileset asset pack, paint arena
- Import weapon/passive icons
- Import purchased pickup sprites (or asset pack)
- Adjust hitboxes if needed

**PRIORITY ORDER (Sarimanok first for demo!):**

1. **Sarimanok Classic** - FIRST priority (needed for Next Fest demo)
2. Sarimanok Shadow & Golden
3. All enemies
4. Everything else

**Tasks:**

- [ ] **Import and set up Sarimanok Classic sprite (PRIORITY - demo character)**
- [ ] Import and set up Sarimanok Shadow sprite
- [ ] Import and set up Sarimanok Golden sprite
- [ ] Import and set up Green Duwende sprite
- [ ] Import and set up Red Duwende sprite
- [ ] Import and set up Santelmo sprite
- [ ] Import and set up Manananggal boss sprite
- [ ] Import purchased tileset asset pack
- [ ] Set up TileMap with tileset
- [ ] Paint arena with final tiles
- [ ] Import all weapon icons (Ericka creates)
- [ ] Import all passive icons (can use asset pack)
- [ ] Import XP gem sprite (asset pack)
- [ ] Import Gold coin sprite (asset pack)
- [ ] Adjust hitboxes if sprite shapes differ from placeholders
- [ ] Test all animations work correctly

**Note:** Black Duwende sprite deferred to Update 1.

**Fallback:** If art not ready, continue with refined placeholders + asset packs. Game is still SHIPPABLE.

**Art Checkpoint:**

- If Ericka's art is ready: swap everything
- If partially ready: swap what's done, use asset packs for generic elements
- If not ready: use asset packs + refined placeholders

---

## Week 9: Audio Polish & Final Juice

**End State: "The game SOUNDS polished and professional"**

> **Note:** Placeholder SFX were added in Weeks 2-3 for game feel testing. This week focuses on replacing placeholders with final audio and adding music.

Adds:

- Menu music track
- Gameplay music track
- Boss music track
- Replace placeholder SFX with final, polished sounds
- COCKADOODLEDOO victory sound
- Audio manager (respects volume settings)
- More particle polish

**Tasks:**

- [ ] Source/create menu music
- [ ] Source/create gameplay music
- [ ] Source/create boss music (triggers at 20:00)
- [ ] **Replace placeholder Peck sound with final version**
- [ ] **Replace placeholder Wing Slap sound with final version**
- [ ] **Replace placeholder Feather Shot sound with final version**
- [ ] **Replace placeholder Spiral Feathers sound with final version**
- [ ] **Replace placeholder enemy hit sound with final version**
- [ ] **Replace placeholder enemy death sound with final version**
- [ ] Player hurt sound
- [ ] **Replace placeholder XP pickup sound with final version**
- [ ] **Replace placeholder Gold pickup sound with final version**
- [ ] Level up sound
- [ ] Menu click sound
- [ ] COCKADOODLEDOO victory sound!
- [ ] Manananggal roar on spawn
- [ ] Audio manager respects volume settings
- [ ] Polish particle effects

**Integration Test:** Play full run with eyes closed - can you tell what's happening by sound?

---

## Week 10: Steam Build, Demo & Achievements

**End State: "Ready for Steam with demo and achievements"**

**🎯 CODE COMPLETE MILESTONE (February 2-8, 2026)**

This is the critical "feature freeze" milestone. By end of Week 10:

- All features implemented and working
- All art integrated (or refined placeholders)
- Demo submitted for Next Fest review (Feb 9 deadline)
- Weeks 11-14 are ONLY for bugs, balance, and launch logistics
- **This gives 6 weeks buffer before baby (due March 21)**

If baby arrives early or complications occur, the game is SHIPPABLE from this point.

Adds:

- Build exports correctly for Windows
- **Demo build ready for Next Fest (10-minute time limit)**
- Test on different Windows machines if possible
- Record trailer footage
- Take screenshots
- Steam achievements (5-8 for EA)

**CRITICAL: Next Fest Demo Deadline is February 9!**

**Tasks:**

- [ ] Export Windows build
- [ ] **Build demo version (10-minute time limit)**
- [ ] **Demo end screen with "Survive to dawn..." teaser and wishlist CTA**
- [ ] **Demo has no shop access (removes meta-progression hook)**
- [ ] **Submit demo for Next Fest review by February 9 deadline**
- [ ] Test Windows build on different machine (if available)
- [ ] Record 30-60 second trailer footage
- [ ] Take 5-10 screenshots for store page
- [ ] Upload screenshots to Steam page
- [ ] Upload trailer to Steam page
- [ ] **GodotSteam Integration (2-4 hrs - easier than expected!):**
  - [ ] Install GodotSteam GDExtension from Godot Asset Library (2-3 min)
  - [ ] Create Steam autoload with initialization code (15-30 min)
  - [ ] Test Steam overlay appears in-game (Shift+Tab)
  - [ ] Verify Steam username displays correctly
  - [ ] **IMPORTANT**: Use Compatibility rendering mode (Forward+ breaks Steam overlay)
  - [ ] **IMPORTANT**: Set `SteamAppId` environment variable BEFORE `Steam.steamInit()`
- [ ] Implement Steam achievements (5-8 total) - 1-2 hrs
- [ ] Hook achievement triggers to gameplay events
- [ ] Test achievement unlocks via Steam API - 30-60 min
- [ ] **Fallback if issues occur:** Ship WITHOUT achievements on Day 1, add in Day 1-3 hotfix. Achievements are not launch blockers for EA.

**Steam Achievements (EA):**

| Achievement     | Condition                                            | Type        |
| --------------- | ---------------------------------------------------- | ----------- |
| First Dawn      | Beat Story Mode                                      | Progression |
| Night Owl       | Survive 15:00 in Story Mode                          | Progression |
| Shadow Unlocked | Unlock Shadow Sarimanok                              | Unlock      |
| Century         | Kill 100 enemies in one run                          | Combat      |
| Maxed Out       | Get any weapon to Level 5                            | Build       |
| Shopaholic      | Buy 10 shop upgrades total                           | Meta        |
| Perfectionist   | Beat Story Mode without taking damage in final 5 min | Challenge   |
| Endless Night   | Survive 45:00 in Endless Mode                        | Endurance   |

**Integration Test:** Build runs standalone, no crashes in 30-minute run, demo cuts off at 10:00, achievements trigger correctly

---

## Week 11: Balance & Bugs

**End State: "The game is FUN and STABLE"**

Focus on:

- Playtest full runs (10+ times)
- Adjust enemy HP/damage/spawn rates
- Adjust XP curve
- Adjust weapon damage
- Fix all known bugs
- Performance test (200+ enemies)
- Get feedback from 3-5 people

**Note:** Press Preview starts February 12 (yours won't be in it since we skipped Jan 26 deadline - that's fine)

**Tasks:**

- [ ] Playtest 10+ full runs
- [ ] Document all bugs found
- [ ] Fix all bugs found
- [ ] Adjust enemy HP if too easy/hard
- [ ] Adjust enemy damage if too easy/hard
- [ ] Adjust spawn rates if too easy/hard
- [ ] Adjust XP curve if leveling too fast/slow
- [ ] Adjust weapon damage for balance
- [ ] Performance test: 200+ enemies at 60 FPS
- [ ] Send build to 3-5 friends/family for feedback
- [ ] Document and address feedback
- [ ] Finalize trailer (add music, titles)
- [ ] **Add basic analytics logging to local file (death location, weapon picks, run length, time survived)**
- [ ] **Add error logging/crash reporting to file for player bug reports**
- [ ] **Wrap critical systems in error handling**

**Integration Test:** Can a first-time player beat Story Mode in 3-5 attempts?

---

## Week 12: Final Prep

**End State: "Ready to launch"**

Focus on:

- Final bug fixes from feedback
- Submit build to Steam for review
- Prepare launch announcement
- Write Steam description
- Set up community hub
- Prepare Day 1 patch notes

**Tasks:**

- [ ] Fix any remaining bugs from Week 11 feedback
- [ ] Final playtest - one complete run
- [ ] Submit build to Steam for review
- [ ] Write Steam store description
- [ ] Set up Steam community hub
- [ ] Prepare launch announcement post
- [ ] Prepare Day 1 patch notes (even if just "Launch version!")
- [ ] Set launch date on Steam
- [ ] Test store page looks correct

**Integration Test:** Fresh install from Steam, full playthrough, no crashes

---

## Week 13: NEXT FEST (February 23 - March 2)

**End State: "Demo is LIVE, collecting wishlists!"**

**Steam Next Fest runs February 23 - March 2, 2026**

- Demo goes live on Steam Next Fest
- Monitor demo feedback
- Collect wishlists
- Engage with players trying the demo
- Prepare for EA launch

**Tasks:**

- [ ] **Set demo LIVE on February 23 (Next Fest start)**
- [ ] Monitor demo feedback and bug reports
- [ ] Engage in Steam discussions
- [ ] Post about Next Fest participation to Filipino gaming communities
- [ ] Track wishlist growth during Next Fest
- [ ] Fix any critical bugs found in demo
- [ ] Prepare EA launch announcement
- [ ] Final polish based on Next Fest feedback

**Integration Test:** Demo works for thousands of players, wishlist count growing

---

## Week 14: EARLY ACCESS LAUNCH (~March 8)

**End State: "GAME IS LIVE ON STEAM!"**

- Launch on Steam Early Access (right after Next Fest ends)
- Convert wishlists to sales
- Monitor for critical bugs
- Hotfix if needed
- Respond to community feedback
- Celebrate!

**Tasks:**

- [ ] Press the LAUNCH button! (~March 8)
- [ ] Post launch announcement to r/Philippines
- [ ] Post to Filipino gaming communities
- [ ] Monitor Steam discussions for bug reports
- [ ] Monitor reviews
- [ ] Hotfix critical bugs immediately
- [ ] Respond to player feedback
- [ ] CELEBRATE! 🎉

---

## Buffer: ~2 Weeks Before Baby (March 8-21)

**Purpose:** Rest and handle any emergencies before baby arrives

**Use for:**

- Critical bug fixes
- Balance patches
- Responding to player feedback
- REST before baby!

**Note on Demo:** No separate demo needed for Early Access at $2.99-4.99 price point. The low price IS the demo. Can add demo post-launch if needed to boost wishlists.

---

# Testing Checklist

## Core Gameplay

- [ ] Player moves in all 8 directions
- [ ] Player takes damage from enemies
- [ ] Player dies at 0 HP
- [ ] Character select works for all 3 variants (Classic, Shadow, Golden)
- [ ] Peck attack damages enemies
- [ ] Wing Slap damages nearby enemies
- [ ] Feather Shot fires projectiles
- [ ] Spiral Feathers orbit and damage enemies
- [ ] All weapons auto-fire correctly
- [ ] Weapons upgrade through level-ups
- [ ] Passives boost stats correctly (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)

## Enemies

- [ ] Green Duwende spawns and walks toward player
- [ ] Red Duwende is stronger than Green
- [ ] Santelmo floats and shoots fireballs
- [ ] Manananggal spawns at 20:00
- [ ] All enemies drop XP and Gold
- [ ] Spawn rate increases over time
- [ ] Enemy stat scaling works (HP/damage increase over time)

## Progression

- [ ] XP collected fills bar
- [ ] Level up pauses game
- [ ] 3 choices displayed
- [ ] Choice applies correctly
- [ ] Game resumes after choice
- [ ] Gold persists after run ends
- [ ] Shop upgrades purchasable
- [ ] Shop upgrades apply next run

## Win/Lose

- [ ] Timer counts to 30:00
- [ ] Victory triggers at 30:00
- [ ] Cockadoodledoo plays
- [ ] Defeat triggers at 0 HP
- [ ] Results screen shows stats
- [ ] Can retry from results
- [ ] Gold earned adds to total

## Endless Mode

- [ ] Locked initially
- [ ] Unlocks after Story victory
- [ ] No time limit (no 30:00 win condition)
- [ ] Same scaling as Story Mode (continues past 30:00)
- [ ] Best time saved

## Technical

- [ ] 60 FPS with 100+ enemies
- [ ] 60 FPS with 200+ enemies (Week 6+)
- [ ] No memory leaks (long runs)
- [ ] Save/load works correctly
- [ ] Save file versioning works
- [ ] No console errors
- [ ] Works on Windows (Mac/Linux in future update)

---

# Success Criteria

## Must Have (Launch Blockers)

- [ ] Core gameplay loop works (move, attack, level up, win/lose)
- [ ] All 3 character variants implemented (Classic, Shadow, Golden)
- [ ] All 4 enemies implemented (Green Duwende, Red Duwende, Santelmo, Manananggal)
- [ ] All 4 weapons implemented (Peck, Wing Slap, Feather Shot, Spiral Feathers)
- [ ] All 4 passives implemented (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)
- [ ] Shop system works
- [ ] Story Mode works (30-minute survival)
- [ ] Endless Mode works (unlocks after Story Mode)
- [ ] Save system works
- [ ] Damage numbers on enemy hit
- [ ] No game-breaking bugs
- [ ] 60 FPS performance
- [ ] Basic controller support
- [ ] Steam achievements (5-8)

## Should Have (Polish)

- [ ] All art is original (no placeholders)
- [ ] Sound effects for all actions
- [ ] Background music
- [ ] Screen shake and juice
- [ ] Particle effects
- [ ] Settings menu (volume, fullscreen, screen shake toggle)
- [ ] Basic tutorial overlays (first run)

## Deferred to Update 1

- [ ] Black Duwende (5th enemy - tanky, fast, spawns 16:00+)
- [ ] Enhanced Endless Mode scaling (accelerated spawn/HP after 30:00)
- [ ] Additional achievements (expand to 15+)
- [ ] Steam Cloud Saves
- [ ] Mac/Linux builds

## Nice to Have (If Time)

- [ ] More detailed animations
- [ ] Additional visual polish

---

# Post-Launch Roadmap

## Update 1: Expand the Experience (When Ready Post-Baby)

Features deferred from EA launch:

- Black Duwende (5th enemy - HP 50, Damage 15, Speed 120, spawns 16:00+)
- Enhanced Endless Mode scaling (accelerated difficulty after 30:00)
- Additional achievements (expand from 8 to 15+)
- Steam Cloud Saves

**Note:** Golden Sarimanok, Spiral Feathers, and Magnetic Aura were moved to EA launch for stronger initial content. Update 1 is now focused on expanding rather than completing.

## Update 2: More Enemies (Month 1)

Add new creatures from Filipino mythology:

- Tikbalang (horse-headed creature, fast charger)
- Mambabarang (voodoo witch with paralyze)
- Kapre (tree giant, slow but tanky)

## Update 3: More Character (Month 2)

- Inahin (hen) with sisiw minion mechanic

## Update 4: More Weapons (Month 2-3)

- Cockadoodle Blast (beam weapon)
- Poop Bomb (area denial)

## Update 5: Evolutions (If Validated)

- Weapon + Passive = Evolved form
- Peck + Iron Beak = Drill Beak
- Etc.

## Update 6: Localization (Month 3-4)

- Tagalog language support for Filipino diaspora
- Design UI with Godot's TranslationServer from start (even if shipping English-only)
- Community translations welcome

## Update 7: Mac/Linux Support

- Export and test Mac build
- Export and test Linux build
- Address platform-specific issues

---

# Steam Next Fest Strategy

## Target Event: Steam Next Fest February 2026

**Dates:** February 23 - March 2, 2026

Steam Next Fest is a week-long event where players try demos of upcoming games. This is a massive visibility opportunity - thousands of players browse new demos during the event.

## Critical Deadlines

| Date       | Deadline                            | Action Required                                 |
| ---------- | ----------------------------------- | ----------------------------------------------- |
| **Jan 5**  | Registration deadline               | Register with live "Coming Soon" store page     |
| Jan 11     | Trailer pull for official marketing | SKIP - won't have polished trailer by then      |
| Jan 26     | Press Preview demo deadline         | SKIP - too tight, not critical                  |
| **Feb 9**  | Final submission deadline           | Demo + store page must be ready for review      |
| Feb 12     | Press Preview starts                | (We won't be in it - that's fine)               |
| **Feb 23** | Next Fest begins                    | Set demo LIVE at 10am PDT                       |
| Mar 2      | Next Fest ends                      | Wrap-up featuring most-played demos             |
| **~Mar 8** | EA Launch                           | Right after Next Fest - ride the wishlist wave! |

## Why This Timing is Perfect

1. **Maximum exposure:** Thousands of players browse Next Fest demos
2. **Wishlist conversion:** Players try demo → wishlist → get notified on launch → buy
3. **Immediate launch:** EA launches right after Next Fest while wishlists are hot
4. **Filipino community:** Share demo in communities during Next Fest week
5. **Streamer coverage:** More likely to try free demos than paid games

---

# Wishlist Building Strategy (Pre-Next Fest)

> **Critical Insight:** Visibility during Steam Next Fest scales directly with the number of wishlists you accumulate BEFORE the festival begins. More pre-fest wishlists = better algorithmic placement = more wishlists during fest.

## Target

**7,000+ wishlists before February 23, 2026**

This is the minimum threshold for meaningful algorithmic visibility during Next Fest.

### Wishlist Target Reality Check

**Context:**

- This is an **ASPIRATIONAL goal**, not a launch blocker
- Many successful EA games launch with 2,000-5,000 wishlists
- Filipino community is underserved = potential viral spread
- Cultural hook may outperform generic survivor games

**If you hit 3,000-5,000 wishlists**: Launch anyway. The low price point ($2.99-4.99) makes impulse purchases viable regardless of wishlist count.

**Do NOT delay launch to hit wishlist targets.** The primary goal is shipping before the baby arrives, not hitting a viral metric.

## Timeline

| Week              | Milestone            | Action                       |
| ----------------- | -------------------- | ---------------------------- |
| Week 5 (Jan 6-12) | Store page goes LIVE | Start all wishlist campaigns |
| Week 6-9          | Active marketing     | Execute channels below       |
| Week 10-12        | Pre-fest push        | Increase posting frequency   |
| Week 13 (Feb 23)  | Next Fest begins     | Reap the wishlist wave       |

## Marketing Channels

**Filipino Community (Primary - Unique Cultural Hook):**

| Channel                         | Action                                                         | Frequency |
| ------------------------------- | -------------------------------------------------------------- | --------- |
| r/Philippines                   | Dev updates, cultural context posts, "Filipino game dev" angle | Weekly    |
| r/PHGamers                      | Gameplay clips, demo announcements                             | Weekly    |
| Filipino Gaming Discord servers | Behind-the-scenes, dev Q&A                                     | 2x/week   |
| Filipino Facebook gaming groups | Shareable GIF clips, cultural creature spotlights              | 2x/week   |

**General Gaming:**

| Channel                       | Action                                                | Frequency      |
| ----------------------------- | ----------------------------------------------------- | -------------- |
| Twitter/X                     | GIF gameplay clips, dev progress, creature reveals    | Daily          |
| TikTok                        | 30-sec gameplay clips, "Filipino mythology explained" | 3x/week        |
| r/roguelites, r/survivorgames | Demo announcements, gameplay clips                    | Key milestones |
| itch.io DevLog                | Development diary with screenshots                    | Weekly         |

**Press & Influencers (Week 9-10):**

- Prepare press kit (screenshots, trailer, logo, description, key art)
- Identify 20-30 small/mid YouTubers and streamers who cover survivor games
- Send personalized emails with Steam keys before Next Fest

## Content Ideas

- "Meet the Duwende" creature spotlight posts (cultural education + marketing)
- "Why I'm making a Filipino mythology game" personal story post
- Side-by-side: Folklore art vs game sprite comparisons
- "30 seconds of chaos" gameplay GIFs
- Ericka's art process videos (if comfortable)

## Tracking

- Check Steam wishlist count weekly (visible in Steamworks)
- Goal: ~1,000 wishlists/week average from Week 5-13
- Adjust channel focus based on what's working

---

# Demo Strategy

## Demo Configuration

**Type:** Time-limited demo (same build as full game with timer check)

| Setting          | Value                                                  |
| ---------------- | ------------------------------------------------------ |
| Time Limit       | 10 minutes                                             |
| Cut-off Point    | Before Santelmo spawns (10:00) and before boss (20:00) |
| Shop Access      | DISABLED (removes meta-progression hook)               |
| Character Select | Classic Sarimanok only                                 |
| Save Data        | Does not persist                                       |

## What Players Experience in Demo

**They SEE:**

- Core gameplay loop (move, auto-attack, dodge)
- Green Duwende + Red Duwende (first 8 minutes of enemies)
- XP collection and level-up system
- 2-3 weapons and passives (depending on RNG)
- Timer counting up

**They DON'T SEE:**

- Santelmo (spawns at 10:00)
- Manananggal boss (spawns at 20:00)
- Victory/dawn sequence (30:00)
- Shop/meta-progression
- Shadow or Golden Sarimanok

## Demo End Screen

When timer hits 10:00:

```
┌─────────────────────────────────────────────┐
│                                             │
│     The night is far from over...           │
│                                             │
│     Survive to dawn to discover             │
│     the Sarimanok's true power.             │
│                                             │
│         [WISHLIST NOW]  [EXIT]              │
│                                             │
│     Full game: $2.99-4.99 Early Access      │
│                                             │
└─────────────────────────────────────────────┘
```

**Key elements:**

- Creates intrigue ("what happens at dawn?")
- Direct wishlist CTA button
- Shows price (impulse-buy territory)

### Demo End Screen Enhancement (Optional Polish)

When timer hits 10:00, add a brief "oh no" moment for stronger emotional hook:

1. Screen darkens slightly (0.5s fade)
2. Distant Manananggal screech plays (boss preview without showing boss)
3. Text fades in: "The night is far from over..."
4. Pause 2 seconds for tension
5. "Survive to dawn to discover the Sarimanok's true power."
6. [WISHLIST NOW] button appears

This teases the boss encounter without spoiling it, creating stronger desire to play the full game.

## Technical Implementation

The demo is the SAME build as the full game with these checks:

```gdscript
# In GameState.gd or main game scene
var is_demo: bool = true  # Set to false in full game build

func _process(delta):
    if is_demo and time_survived >= 600.0:  # 10 minutes = 600 seconds
        show_demo_end_screen()

func show_demo_end_screen():
    get_tree().paused = true
    # Show demo end UI with wishlist button
    # Wishlist button opens Steam store page in browser
```

**Demo build cost:** ~2-4 hours (timer check + end screen UI)

---

# Budget Estimate

## MVP Costs (Updated with Asset Pack Strategy)

| Item                   | Cost                        |
| ---------------------- | --------------------------- |
| Aseprite license       | $20                         |
| Steam Direct fee       | $100                        |
| **UI asset pack**      | **$10-15**                  |
| **Tileset asset pack** | **$10-20**                  |
| Sound effects          | $0 (free sources)           |
| Music                  | $0-150 (free or commission) |
| Marketing              | $0 (organic)                |
| **Total**              | **~$140-305**               |

**Asset Pack Sources:**

- itch.io (pixel art UI kits, tilesets) - $5-20 each
- Kenney.nl (free, professional quality)
- Game-icons.net (free icons, CC0)

**Music Sources:**

- Pixabay Music (free, no attribution required)
- Epidemic Sound ($15/month subscription)
- Fiverr commission ($50-150 for 4 tracks)

## Time Investment (Updated with Outsourcing)

| Task            | Hours                            |
| --------------- | -------------------------------- |
| Programming     | 150-200 hrs                      |
| Art (Ericka)    | **18-24 hrs** (down from 40-50!) |
| Audio           | 10-15 hrs                        |
| Testing/Polish  | 30-40 hrs                        |
| Marketing/Steam | 20-30 hrs                        |
| **Total**       | **228-309 hrs**                  |

At 20 hrs/week = 11-15 weeks (14-week timeline has buffer)

---

# Risk Mitigation

## Risk 1: Art Takes Too Long

**Mitigation:**

- Use 2-frame animations (minimal)
- Color variants instead of new sprites
- Simple shapes, strong silhouettes
- Accept "good enough" over perfect

## Risk 2: Scope Creep

**Mitigation:**

- This PRD is the scope. Period.
- No new features until MVP ships
- Post-launch updates for extras
- Say "that's Update 2" to new ideas

## Risk 3: Baby Timing

**Mitigation:**

- Launch late February (3 weeks buffer)
- Weeks 15-16 are emergency buffer
- "Good enough" is good enough
- Game can update post-launch

## Risk 4: Performance Issues

**Mitigation:**

- Object pooling for enemies
- Test with 200+ enemies early
- Profile in Week 11
- Reduce particle effects if needed

## Risk 5: No One Buys It

**Mitigation:**

- Price low ($2.99-4.99 is impulse-buy territory)
- Filipino community outreach
- Unique cultural hook (no other Sarimanok games exist!)
- It's a learning experience regardless

---

# Filipino Cultural Notes

## The Player Character

**Sarimanok:**

- Legendary bird from Maranao folklore (Mindanao, Philippines)
- Symbolizes good fortune, prosperity, and royalty
- Depicted with elaborate, intricate designs and vibrant colors
- Often shown with a fish in its beak (offering to spirit world)
- Serves as spiritual link between seen and unseen worlds
- Perfect guardian against creatures of darkness
- Iconic in Filipino art - appears in home decor, festivals, government seals
- Reference traditional Maranao art for authentic design

## The Creatures

**Duwende:**

- Small goblin/dwarf-like creatures
- Live in mounds, anthills, or trees
- Can be good (white) or evil (black/red)
- Colors indicate rank/power (per Ericka)
- Disturbing their home brings bad luck

**Santelmo:**

- "Saint Elmo's Fire" - ball of floating fire/light
- Appears in forests, swamps, open fields
- Sometimes souls of the dead
- Leads travelers astray

**Aswang:**

- Shapeshifter, most feared Filipino monster
- Can appear human by day
- Various forms: vampire, werewolf, witch
- Eats unborn children and the sick
- Weakness: Salt, garlic, holy water

## Visual References

- Bahay kubo (nipa hut) for background
- Rice paddies
- Carabao (water buffalo) - decorative
- Banana trees
- Coconut trees
- Provincial Philippine countryside at night
- Traditional Maranao patterns for Sarimanok design

## Sound References

- Sarimanok crow (similar to rooster but more dramatic/mystical)
- Provincial night ambience (crickets, frogs)
- Aswang sounds (tiktik = tongue clicking)

---

# Appendix: Art Style Guide

## Color Palette (Suggested)

| Use                 | Colors                                                  |
| ------------------- | ------------------------------------------------------- |
| Sarimanok (Classic) | Red, orange, yellow, gold, teal (vibrant, royal colors) |
| Sarimanok (Shadow)  | Dark purple, deep blue, black                           |
| Sarimanok (Golden)  | Gold, red, bronze                                       |
| Green Duwende       | Green, brown                                            |
| Red Duwende         | Red, dark red                                           |
| Black Duwende       | Black, dark purple                                      |
| Santelmo            | Orange, yellow, white (glow)                            |
| Manananggal         | Black, red, gray, pale skin                             |
| Background          | Dark blues, purples (night)                             |
| Dawn                | Orange, pink, yellow                                    |

**Sarimanok Design Notes:**

- Reference traditional Maranao okir (geometric/flowing patterns)
- Key features: decorative tail plumes, distinctive crest, proud posture
- Colors should be more vibrant than enemies (hero stands out)
- At 32x32, prioritize recognizable silhouette over intricate details

## Pixel Art Tips

- 32x32 is small - keep shapes simple
- Strong silhouettes over details
- 2-3 colors per sprite max
- Black outlines help readability
- Test sprites at actual game size

## Animation Reference

- Vampire Survivors (very simple 2-frame)
- Stardew Valley (clean, readable)
- Look at existing indie survivors on itch.io

---

# Conclusion

This PRD defines a **30-minute action roguelite** that combines:

- Proven Vampire Survivors-style gameplay
- Iconic Filipino protagonist (Sarimanok - legendary Maranao bird)
- Unique Filipino mythological creatures as enemies
- Clear win condition (survive to dawn)
- Roguelite progression (shop upgrades)

**EA Launch Scope:**

- 3 characters (Classic, Shadow, Golden Sarimanok)
- 4 enemies (Green Duwende, Red Duwende, Santelmo, Manananggal boss)
- 6 weapons (Peck, Wing Slap, Feather Shot, Spiral Feathers + Ice Shard, Flame Wing clones)
- 4 passives (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)
- 3 shop upgrades
- 1 stage (bounded farm arena)
- 2 modes (Story + Endless)
- 5-8 Steam achievements
- Controller support (input Week 1, polish Week 7)
- Damage numbers on hit (Week 3 for balance testing)
- Pitch-randomized SFX (placeholder Week 2-3, polished Week 9)
- Data-driven weapon architecture (trivial to add more weapons post-launch)

**Deferred to Update 1:** Black Duwende, Enhanced Endless Scaling, Additional Achievements, Steam Cloud Saves, Mac/Linux

**Timeline:** 14 weeks (includes Next Fest week)
**Next Fest:** February 23 - March 2, 2026 (Demo live!)
**Target Launch:** ~March 8, 2026 (Right after Next Fest)
**Price:** $2.99-4.99

**Marketing Strategy:**

- Demo available during Steam Next Fest (massive visibility!)
- Wishlist collection during Next Fest week
- EA launch immediately after Next Fest while wishlists are hot

**If successful:** Update 1 within 2 weeks to add deferred features
**If not:** Valuable learning experience, minimal financial risk

**The goal:** Ship a complete, playable game before baby arrives. Everything else is future updates.

---

**Version:** 2.0 FINAL  
**Created:** December 2025  
**Authors:** Josh & Ericka  
**Cultural Consultant:** Ericka

**Version History:**

- v2.0 FINAL: Production readiness & tracking sections - ADDED: URGENT "Before Week 1" Steam setup callout (verification takes 1-4 weeks, must start TODAY for Jan 5 deadline), Steam Marketing Art section (capsule art requirements for Next Fest visibility), Wishlist Building Strategy (7,000+ target, Filipino community channels, content calendar), 16x16 asset pack fallback with Lospec upscaler workflow, Manananggal static sprite fallback. UPDATED: Week 7 tutorial redesigned as "level design teaching" not overlays, added input device switching tasks. Week 10 added GodotSteam integration tasks. Quick Reference Card updated with new tracking items. Architecture is LOCKED - ready to start coding.
- v1.8: Build variety & polish timing improvements - ADDED: Data-driven WeaponData Resource architecture (trivial to add weapons post-launch), 2 clone weapons (Ice Shard, Flame Wing) for 6 total weapons with minimal art effort, debuff system (slow effect), pitch randomization for repetitive SFX (prevents ear fatigue), Week 10 "Code Complete" milestone (6-week baby buffer). MOVED EARLIER: Damage numbers and enemy flash moved from Week 7 to Week 3 (critical for balance testing). RENAMED: Week 7 "Controller Support" → "Controller Polish" (core input already in Week 1). EA now ships with 6 weapons instead of 4.
- v1.7: Steam Next Fest & Asset Strategy overhaul - ADDED: Steam Next Fest February 2026 strategy (demo live Feb 23 - Mar 2, EA launch ~Mar 8), 10-minute time-limited demo, asset pack outsourcing (UI, tileset, pickups bought; Ericka does characters/enemies only - reduces art from 36-46 hrs to 18-24 hrs), Steam setup moved to Week 1 (pay fee Day 1 for Jan 5 Next Fest registration deadline), Week 14 added for EA launch after Next Fest, Area2D for enemies (performance optimization), tr() localization prep, accessibility options (colorblind mode, reduced motion), analytics logging. Budget updated to $140-305.
- v1.6: Content depth increase for stronger EA launch - MOVED TO EA: Golden Sarimanok (3rd character), Spiral Feathers (4th weapon), Magnetic Aura (4th passive). ADDED: Placeholder SFX in Weeks 2-3 for game feel, Damage numbers promoted to Must Have (Week 7), Enemy damage flash, Level-up juice, In-game bug report button. EA now ships with 3 characters, 4 enemies, 4 weapons, 4 passives = 11 base items with 55 upgrade choices. DEFERRED to Update 1: Black Duwende, Enhanced Endless Scaling, Additional Achievements, Steam Cloud Saves, Mac/Linux.
- v1.5: Scope rebalance for EA launch - ADDED to EA: Simplified Endless Mode, Basic Controller Support, 5-8 Steam Achievements. DEFERRED to Update 1: Black Duwende (5th enemy), Golden Sarimanok (3rd character), Spiral Feathers (4th weapon), Magnetic Aura (4th passive), Enhanced Endless Scaling. EA now ships with 2 characters, 4 enemies, 3 weapons, 3 passives, Story + Endless Modes, controller support, and achievements. Enemy stat scaling replaces Black Duwende for late-game difficulty.
- v1.4: Scope reduction for EA launch - deferred to Update 1: Golden Sarimanok (3rd character), Endless Mode, Spiral Feathers (4th weapon), Magnetic Aura (4th passive), Steam achievements, Controller support. EA now ships with 2 characters, 3 weapons, 3 passives, Story Mode only, keyboard only. Based on Vampire Survivors EA launch comparison showing simpler scope is viable.
- v1.3: Restructured roadmap to 13-week vertical slices (each week = playable game), added Performance Architecture section, added art contingency plan, moved Settings/Controller/Tutorial to Should Have, added save file versioning, added Steam achievements for metrics, changed to Windows-only for EA (Mac/Linux post-launch), added character unlock conditions (Shadow: 15:00 Story, Golden: beat Story), moved Steamworks setup to Week 5
- v1.2: Added 3 character variants, 4th weapon (Spiral Feathers), 4th passive (Magnetic Aura), changed boss to Manananggal, added bounded arena specs, standardized sprite sizes (32x32, 48x48 boss, 16x16 icons)
- v1.1: Changed protagonist to Sarimanok, updated timeline to December 2025 - March 2026, removed demo week
- v1.0: Initial PRD

---

# Quick Reference Card

```
┌─────────────────────────────────────────────────┐
│           SARIMANOK SURVIVOR MVP                │
├─────────────────────────────────────────────────┤
│ CHARACTERS: 3 (Classic, Shadow, Golden)         │
│ ENEMIES: 4 (2 Duwendes, Santelmo, Manananggal)  │
│ WEAPONS: 6 (4 unique + 2 clones for variety)    │
│ PASSIVES: 4 (Damage, HP, Speed, Pickup Range)   │
│ SHOP: 3 upgrades (Damage, HP, Speed)            │
│ MODES: 2 (Story 30min + Endless)                │
│ STAGE: 1 (Bounded farm arena)                   │
│ ACHIEVEMENTS: 5-8 Steam achievements            │
│ CONTROLLER: Input Week 1, Polish Week 7         │
│ DEMO: 10-minute time-limited for Next Fest      │
├─────────────────────────────────────────────────┤
│ PLATFORM: Windows (Mac/Linux post-launch)       │
│ SPRITES: 32x32, 48x48 boss, 16x16 icons         │
│ ASSET PACKS: UI + Tileset (~$30-50)             │
│ ART FALLBACK: 16x16 pack → Lospec 2x upscale    │
│ TIMELINE: 14 weeks (includes Next Fest)         │
│ NEXT FEST: Feb 23 - Mar 2, 2026 (Demo live!)    │
│ LAUNCH: ~March 8, 2026 (after Next Fest)        │
│ BABY DUE: March 21, 2026 (~2 week buffer)       │
│ PRICE: $2.99-4.99                               │
├─────────────────────────────────────────────────┤
│ ⚠️ STEAM SETUP: DO TODAY (not Week 1!)          │
│ STORE PAGE: Week 4 (submit), Week 5 (live)      │
│ NEXT FEST REG: Jan 5 deadline (Week 5)          │
│ WISHLIST TARGET: 7,000+ before Feb 23           │
│ CAPSULE ART: Week 8-9 (commission or custom)    │
│ MINIMUM SHIPPABLE: Week 6 (MVP checkpoint)      │
│ CODE COMPLETE: Week 10 (Feb 2-8, 2026)          │
│ DEMO SUBMIT: Feb 9 deadline (end of Week 10)    │
└─────────────────────────────────────────────────┘
```
