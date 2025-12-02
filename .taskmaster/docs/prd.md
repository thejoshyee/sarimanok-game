# Sarimanok Survivor

## Product Requirements Document - MVP (Early Access)

**Version:** 1.3  
**Platform:** Windows via Steam Early Access (Mac/Linux in future update)  
**Engine:** Godot 4.x  
**Art Style:** Top-down pixel art (32x32 sprites, 48x48 boss)  
**Camera/Perspective:** Fixed top-down view, camera follows player, bounded arena  
**Reference Games:** Vampire Survivors, Void Miner, Brotato  
**Team Size:** 1-2 first-time developers (husband/wife team)  
**Target Playtime:** 30 minutes per run  
**Timeline:** 16 weeks (4 months)  
**Target Launch:** Mid-March 2026  
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
| Scope minimal   | 3 characters, 5 enemies, 4 weapons = achievable in 4 months |
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

| Character               | Colors           | HP  | Speed | Damage | Playstyle                        | Unlock                      |
| ----------------------- | ---------------- | --- | ----- | ------ | -------------------------------- | --------------------------- |
| **Sarimanok (Classic)** | Rainbow/vibrant  | 100 | 100%  | 100%   | Balanced, good for learning      | Default                     |
| **Sarimanok (Shadow)**  | Dark purple/blue | 80  | 100%  | 125%   | Glass cannon, high risk/reward   | Survive 15:00 in Story Mode |
| **Sarimanok (Golden)**  | Gold/red         | 130 | 85%   | 100%   | Tank, slower but survives longer | Beat Story Mode (30:00)     |

**Unlock Progression:**

- Shadow at 15:00 is achievable in 3-5 attempts - proves you can handle mid-game
- Golden as "beat the game" reward - you've proven you can win
- Both require Story Mode specifically (no gaming it via Endless)

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
- [ ] Locked characters show unlock requirements
- [ ] Unlocks trigger correctly (15 min survive, beat story)
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

### Enemy Roster (5 Total)

| Enemy                  | HP  | Damage | Speed | Spawns At | Behavior                   |
| ---------------------- | --- | ------ | ----- | --------- | -------------------------- |
| **Green Duwende**      | 10  | 5      | 80    | 0:00+     | Walks toward player        |
| **Red Duwende**        | 25  | 10     | 100   | 8:00+     | Faster, stronger           |
| **Black Duwende**      | 50  | 15     | 120   | 16:00+    | Tanky, fast                |
| **Santelmo**           | 15  | 8      | 60    | 10:00+    | Floats, shoots fireballs   |
| **Manananggal (Boss)** | 500 | 25     | 90    | 20:00     | Boss, flying torso vampire |

### Duwende Color Variants (Cultural Note)

Ericka confirmed: In Filipino folklore, duwendes have different ranks/types indicated by color:

- **Green:** Common, mischievous
- **Red:** More aggressive, territorial
- **Black:** Most powerful, dangerous

This is culturally authentic AND saves art time (recolor same sprite).

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

Every 2 seconds:
  Shoot fireball projectile toward player

On contact with player:
  player.take_damage(damage)
```

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

**Cultural Note - Manananggal:**
The Manananggal is a type of Aswang from Filipino folklore. It's a self-segmenting vampire—a woman whose upper torso detaches from her lower body, sprouting bat-like wings to fly through the night hunting prey. More iconic and visually striking than a generic shapeshifter.

### Spawn System

**Spawn Location:** Random point on screen edge (just outside visible area)

**Spawn Timeline:**

| Time        | Enemies Spawning        | Spawn Rate          |
| ----------- | ----------------------- | ------------------- |
| 0:00-8:00   | Green Duwende           | 1 per 2s → 1 per 1s |
| 8:00-10:00  | Green + Red Duwende     | 1 per 1s            |
| 10:00-16:00 | All Duwendes + Santelmo | 1 per 0.8s          |
| 16:00-20:00 | All enemies             | 1 per 0.5s          |
| 20:00       | **MANANANGGAL SPAWNS**  | One-time            |
| 20:00-30:00 | All + Manananggal       | 1 per 0.3s (chaos!) |

**Spawn Rate Scaling:**

- Base rate decreases (faster spawns) as time progresses
- Harder enemies are added to the pool over time
- Never remove earlier enemies (Green Duwendes spawn all game)

### Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |
| Black Duwende | 5       | 5         |
| Santelmo      | 4       | 3         |
| Manananggal   | 50      | 100       |

**Technical Requirements:**

- Enemy scene with CharacterBody2D
- Simple pathfinding (just move toward player)
- Spawn manager that tracks time and spawn rates
- Object pooling for performance (reuse enemy instances)
- Death: Play particle effect, drop XP gem + Gold coin, queue_free()

**Definition of Done:**

- [ ] All 5 enemy types implemented
- [ ] Enemies spawn at screen edges
- [ ] Enemies walk toward player
- [ ] Enemies damage player on contact
- [ ] Enemies die when HP reaches 0
- [ ] Enemies drop XP + Gold on death
- [ ] Spawn timeline works correctly
- [ ] Aswang boss spawns at 20:00
- [ ] Spawn rate increases over time
- [ ] Game handles 100+ enemies without lag
- [ ] No console errors

---

## Feature 3: Weapon System

**What It Does:**
Weapons attack automatically on a cooldown. Player collects weapons through level-up choices. Each weapon has different behavior and can be upgraded.

**Why It's Important:**
Weapons are your primary way to kill enemies. Different weapons create different playstyles.

### Weapon Roster (3 Total)

| Weapon              | Type       | Behavior                        | Cooldown | Base Damage |
| ------------------- | ---------- | ------------------------------- | -------- | ----------- |
| **Peck**            | Melee      | Quick jab in facing direction   | 0.5s     | 10          |
| **Wing Slap**       | AOE        | Circle around player            | 1.5s     | 8           |
| **Feather Shot**    | Projectile | Shoots feather at nearest enemy | 1.0s     | 12          |
| **Spiral Feathers** | Orbiting   | Feathers orbit around player    | Passive  | 8           |

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

- Feathers constantly orbit around player
- Damages any enemy that touches them
- No cooldown—always active while equipped
- Similar to King Bible in Vampire Survivors
- Reuses Feather Shot sprite (just rotated while orbiting)
- Great for passive defense

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

| Level | Damage | Effect                          |
| ----- | ------ | ------------------------------- |
| 1     | 8      | 2 feathers orbiting             |
| 2     | 10     | 3 feathers orbiting             |
| 3     | 12     | 4 feathers orbiting             |
| 4     | 14     | 5 feathers, faster orbit        |
| 5     | 18     | 6 feathers, larger orbit radius |

### Maximum Weapons

Player can hold up to **3 weapons** at once.

If you have 3 weapons and level up, you'll only see upgrade options for existing weapons ("+1" options), not new weapons.

**Technical Requirements:**

- Weapon base class with cooldown timer
- Each weapon type extends base class
- Weapon manager tracks equipped weapons
- Weapons fire automatically when cooldown ready
- Visual effects for each weapon attack
- Damage detection using Area2D

**Definition of Done:**

- [ ] Peck attack works (melee cone)
- [ ] Wing Slap attack works (AOE circle)
- [ ] Feather Shot works (projectile)
- [ ] Spiral Feathers works (orbiting)
- [ ] All weapons auto-fire on cooldown (or passive for Spiral)
- [ ] Weapons can be upgraded to level 5
- [ ] Max 3 weapons enforced
- [ ] Weapon effects visible and satisfying
- [ ] Damage numbers show on hit (nice-to-have)
- [ ] No console errors

---

## Feature 4: Passive System

**What It Does:**
Passives are stat boosts that stack. Collect them through level-up choices. No animation or visual effect—just numbers.

**Why It's Important:**
Passives add build variety without art burden. They're "free content."

### Passive Roster (4 Total)

| Passive           | Per Level        | Max Level | At Max              |
| ----------------- | ---------------- | --------- | ------------------- |
| **Iron Beak**     | +10% Damage      | 5         | +50% total damage   |
| **Thick Plumage** | +15 Max HP       | 5         | +75 HP              |
| **Racing Legs**   | +10% Move Speed  | 5         | +50% move speed     |
| **Magnetic Aura** | +30 Pickup Range | 5         | +150 range (50→200) |

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

**Example: Magnetic Aura**

- Level 1: Pickup range 80px (base 50 + 30)
- Level 2: Pickup range 110px
- Level 3: Pickup range 140px
- Level 4: Pickup range 170px
- Level 5: Pickup range 200px (vacuum effect!)

Quality of life passive—lets you collect XP and Gold without running directly over them.

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

## Feature 9: Endless Mode

**What It Does:**
Unlocks after beating Story Mode. No time limit—survive as long as possible. Enemies keep spawning faster and stronger.

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

### Endless Mode Rules

- Timer counts UP forever (no 30:00 win)
- Enemy spawn rate keeps increasing
- Enemy HP scales up over time (+5% per minute after 30:00)
- You WILL eventually die
- Goal: Survive as long as possible

### Endless Mode Scaling (After 30:00)

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

**Definition of Done:**

- [ ] Endless Mode locked initially
- [ ] Unlocks after Story Mode victory
- [ ] No win condition (play until death)
- [ ] Enemies scale after 30:00
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
| Kill Black Duwende      | 50     |
| Kill Santelmo           | 40     |
| Kill Aswang             | 500    |
| Survive to dawn (bonus) | 1,000  |

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
| Black Duwende       | ColorRect            | Black              | 32x32      |
| Santelmo            | ColorRect            | Orange             | 32x32      |
| Manananggal         | ColorRect            | Dark red           | 48x48      |
| XP Gem              | ColorRect            | Blue               | 16x16      |
| Gold Coin           | ColorRect            | Yellow             | 16x16      |
| Feather projectile  | ColorRect            | White              | 16x16      |
| Tileset (all tiles) | Simple colored tiles | Green/brown/gray   | 32x32 each |
| All icons           | ColorRect            | Gray               | 16x16      |

## Parallel Development Timeline

```
JOSH (Code)                    ERICKA (Art)
───────────────────────────────────────────────────
Week 1-2: Core gameplay        Week 1-2: Sarimanok (all 3 variants)
Week 3-4: Weapons, enemies     Week 3-4: Duwendes + Santelmo
Week 5-6: Progression, shop    Week 5-6: Manananggal + Icons
Week 7: Art integration        Week 7: Tileset + UI elements
Week 8+: Polish together       Week 8+: Polish together
```

## Sprite Swap Process (Week 7)

**Step 1: Ericka exports final sprites**

```
/art/
├── sarimanok_classic.png (32x32, 2 frames horizontal)
├── sarimanok_shadow.png
├── sarimanok_golden.png
├── duwende_green.png
├── duwende_red.png
├── duwende_black.png
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

**Primary Plan:** Ericka creates all art (target: complete by Week 8)

**Backup Plans:**

1. Josh creates simplified pixel art (basic shapes, strong silhouettes)
2. Purchase asset packs from itch.io (Filipino-themed if possible)
3. Use free assets from OpenGameArt.org

**Minimum Viable Art (if backup needed):**

- Player: Must have recognizable shape (even refined placeholder acceptable for EA)
- Enemies: Can use simple shapes with color coding
- UI: Can use Godot's default theme with custom colors
- Tileset: Can use free tileset assets

**Art Checkpoints:**
| Week | Check | Action if Not Ready |
|------|-------|---------------------|
| Week 5 | Sarimanok + Duwendes done? | If no, Josh starts backup art |
| Week 7 | Boss done? | If no, use larger placeholder |
| Week 8 | All art ready? | Ship whatever is ready, refine placeholders for rest |

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

### Player Characters (3 Variants)

| Asset               | Frames | Est. Time      |
| ------------------- | ------ | -------------- |
| Sarimanok (Classic) | 2      | 3-4 hrs        |
| Sarimanok (Shadow)  | 2      | 1 hr (recolor) |
| Sarimanok (Golden)  | 2      | 1 hr (recolor) |

**Total player time: ~5-6 hrs**

**Note:** Classic Sarimanok requires more time due to elaborate, colorful design. Keep details minimal at 32x32 but capture the iconic silhouette (decorative tail, distinctive head crest). Reference traditional Maranao art for color palette. Shadow and Golden variants are recolors with adjusted palettes.

### Enemies (5)

| Asset            | Size  | Frames | Est. Time        |
| ---------------- | ----- | ------ | ---------------- |
| Green Duwende    | 32x32 | 2      | 2-3 hrs          |
| Red Duwende      | 32x32 | 2      | 20 min (recolor) |
| Black Duwende    | 32x32 | 2      | 20 min (recolor) |
| Santelmo         | 32x32 | 2      | 2-3 hrs          |
| Manananggal Boss | 48x48 | 4      | 5-7 hrs          |

**Total enemy time: ~10-14 hrs**

**Note:** Manananggal is 48x48 to emphasize boss status. Flying torso with bat-like wings, grotesque but readable silhouette.

### Weapon Icons (4)

| Asset                | Size  | Est. Time |
| -------------------- | ----- | --------- |
| Peck icon            | 16x16 | 30 min    |
| Wing Slap icon       | 16x16 | 30 min    |
| Feather Shot icon    | 16x16 | 30 min    |
| Spiral Feathers icon | 16x16 | 30 min    |

**Total icon time: ~2 hrs**

### Weapon Effects (4)

| Asset              | Size  | Est. Time                              |
| ------------------ | ----- | -------------------------------------- |
| Peck hit effect    | 32x32 | 1 hr                                   |
| Wing Slap circle   | 64x64 | 1-2 hrs                                |
| Feather projectile | 16x16 | 30 min                                 |
| Spiral Feathers    | —     | 0 (reuses Feather projectile, rotated) |

**Total effect time: ~2.5-3.5 hrs**

### Passive Icons (4)

| Asset         | Size  | Est. Time |
| ------------- | ----- | --------- |
| Iron Beak     | 16x16 | 30 min    |
| Thick Plumage | 16x16 | 30 min    |
| Racing Legs   | 16x16 | 30 min    |
| Magnetic Aura | 16x16 | 30 min    |

**Total passive time: ~2 hrs**

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

### UI Elements

| Asset                 | Est. Time |
| --------------------- | --------- |
| HP Bar                | 1 hr      |
| XP Bar                | 1 hr      |
| Weapon slots          | 1 hr      |
| Button sprites        | 2 hrs     |
| Menu backgrounds      | 2 hrs     |
| Level up frame        | 1 hr      |
| Results screen layout | 1 hr      |

**Total UI time: ~9 hrs**

## Total Art Summary

| Category              | Time          |
| --------------------- | ------------- |
| Player (3 variants)   | 5-6 hrs       |
| Enemies               | 10-14 hrs     |
| Weapon icons          | 2 hrs         |
| Weapon effects        | 2.5-3.5 hrs   |
| Passive icons         | 2 hrs         |
| Pickups               | 1 hr          |
| Environment (tileset) | 5-8 hrs       |
| UI                    | 9 hrs         |
| **TOTAL**             | **36-46 hrs** |

At 10 hrs/week art = **4-5 weeks** of art (parallel to coding)

---

# Audio Requirements

## Music (4 tracks)

| Track          | Purpose                 | Notes                      |
| -------------- | ----------------------- | -------------------------- |
| Menu theme     | Main menu               | Calm, Filipino-inspired    |
| Night theme    | Main gameplay           | Tense, action              |
| Boss theme     | When Manananggal spawns | Intense, dramatic          |
| Victory jingle | Dawn/win                | Triumphant, Sarimanok crow |

## Sound Effects (15)

| Sound          | Trigger            |
| -------------- | ------------------ |
| Peck attack    | Weapon fires       |
| Wing Slap      | Weapon fires       |
| Feather Shot   | Weapon fires       |
| Enemy hit      | Damage dealt       |
| Enemy death    | Enemy killed       |
| Player hurt    | Take damage        |
| Player death   | HP = 0             |
| XP pickup      | Collect gem        |
| Gold pickup    | Collect coin       |
| Level up       | XP bar fills       |
| Menu click     | Button press       |
| Menu hover     | Mouse over button  |
| Cockadoodledoo | Victory            |
| Aswang roar    | Boss spawn         |
| Dawn ambience  | Victory transition |

## Audio Sources (Free)

- freesound.org (CC0 sound effects)
- opengameart.org (free game audio)
- Friend/family musician (if available)
- AI-generated music (with care)

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

# Development Roadmap (13 Weeks - Vertical Slices)

**Start:** December 1, 2025  
**Launch:** First week of March 2026  
**Baby Due:** March 21, 2026  
**Buffer:** 3 weeks before baby

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

## Week 1: The Core Loop

**End State: "I can play a survivor game"**

What's playable at end of week:

- Sarimanok moves with WASD in a bounded arena
- Peck attack fires automatically
- Green Duwendes spawn and walk toward player
- Duwendes die when hit, drop XP gem (placeholder)
- Player dies when HP = 0
- Game over screen shows "You died"

**Tasks:**

- [ ] Create project structure
- [ ] Set up project settings (640×360 viewport, canvas_items stretch)
- [ ] Create TileMap with placeholder tileset (simple colored squares)
- [ ] Paint basic 60×34 arena with placeholder tiles
- [ ] Set up Camera2D with limits (0,0 to 1920,1088)
- [ ] Add invisible boundary collision (StaticBody2D)
- [ ] Implement player movement (WASD)
- [ ] Create placeholder Sarimanok sprite (colored rectangle 32x32)
- [ ] Implement Peck attack (auto-fire, cooldown)
- [ ] Create placeholder Duwende (green rectangle 32x32)
- [ ] Duwende walks toward player
- [ ] Duwende takes damage from Peck
- [ ] Duwende dies and drops placeholder XP gem
- [ ] Player takes damage from enemy contact
- [ ] Player dies at 0 HP, shows game over

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
- Red and Black Duwendes spawn (recolors, higher stats)
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
- [ ] Add Black Duwende (recolor, different stats)
- [ ] Timer displays on screen

**Integration Test:** Can you reach level 10 with 2 weapons + 1 passive?

---

## Week 3: Full Arsenal

**End State: "I can build different weapon combos"**

Builds on Week 2, adds:

- Feather Shot weapon (projectile toward nearest enemy)
- Spiral Feathers weapon (orbiting)
- All 4 passives working
- All weapons/passives upgrade to level 5
- Max 3 weapons enforced

**Tasks:**

- [ ] Feather Shot weapon (projectile)
- [ ] Spiral Feathers weapon (orbiting)
- [ ] Thick Plumage passive (+HP)
- [ ] Racing Legs passive (+speed)
- [ ] Magnetic Aura passive (+pickup range)
- [ ] Weapon upgrades to level 5 work
- [ ] Passive upgrades to level 5 work
- [ ] Max 3 weapons enforced in level-up pool
- [ ] Level-up pool includes all weapons/passives correctly

**Integration Test:** Can you max out 3 weapons and 4 passives in one run?

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

_Note: This is a holiday week (late December) - scope is appropriate_

---

## Week 5: Meta Progression

**End State: "Dying makes me stronger for next run"**

Builds on Week 4, adds:

- Main menu (Story Mode, Shop, Quit)
- Shop screen with 3 upgrades (Damage, HP, Speed)
- Shop upgrades apply at run start
- Shop upgrades persist in save file
- Gold deducts on purchase

**PARALLEL TASK: Pay $100 Steam Direct fee, start Steamworks account verification**

**Tasks:**

- [ ] Main menu screen (Story Mode, Shop, Quit)
- [ ] Shop screen UI
- [ ] Buy Damage upgrade (+2% per purchase)
- [ ] Buy HP upgrade (+5 per purchase)
- [ ] Buy Speed upgrade (+1% per purchase)
- [ ] Upgrades save to file
- [ ] Upgrades apply at run start
- [ ] Gold deducts correctly on purchase
- [ ] BUY button disabled when insufficient gold
- [ ] **STEAM:** Pay Steam Direct fee
- [ ] **STEAM:** Start Steamworks verification process

**Integration Test:** Die, buy upgrade, start new run - are you stronger?

---

## Week 6: Characters & Endless

**End State: "I can pick characters and play forever"**

Builds on Week 5, adds:

- Character select screen (3 Sarimanoks with different stats)
- Shadow Sarimanok unlocks at 15:00 survived (Story Mode)
- Golden Sarimanok unlocks when Story Mode beaten
- Endless Mode unlocks when Story Mode beaten
- Endless Mode: no win, enemies scale after 30:00
- High score tracking (separate for Story/Endless)

**PARALLEL TASK: Submit Steam store page for review (verification should be done by now)**

**Tasks:**

- [ ] Character select screen before run
- [ ] Classic Sarimanok (default, balanced stats)
- [ ] Shadow Sarimanok (80 HP, 125% damage - glass cannon)
- [ ] Golden Sarimanok (130 HP, 85% speed - tank)
- [ ] Lock/unlock display with requirements shown
- [ ] Shadow unlocks: survive 15:00 in Story Mode (single run)
- [ ] Golden unlocks: beat Story Mode (survive to 30:00)
- [ ] Endless Mode button (locked initially)
- [ ] Endless Mode: no win condition, play until death
- [ ] Enemy scaling after 30:00 in Endless (+5% HP per minute)
- [ ] High score tracking (Story and Endless separate)
- [ ] Best time tracking for Endless
- [ ] **STEAM:** Submit store page for review

**Integration Test:** Beat Story Mode, unlock Golden + Endless, play Endless to 45:00

**MINIMUM VIABLE PRODUCT CHECKPOINT:**

```
At the end of Week 6, you have a SHIPPABLE game:
- Complete survivor game with core loop
- 3 characters, 5 enemies, 4 weapons, 4 passives
- Story Mode + Endless Mode
- Shop progression
- Save system
- This is SHIPPABLE as Early Access if needed!
```

---

## Week 7: Polish Pass 1

**End State: "The game FEELS good"**

Builds on Week 6, adds:

- Settings menu (Music volume, SFX volume, Fullscreen, Screen Shake toggle)
- Controller support (D-pad/stick movement, button navigation)
- Basic tutorial overlays (first run only)
- Screen shake on hits
- Invincibility flash when damaged
- Enemy death particles
- Pickup magnet visual

**Tasks:**

- [ ] Settings menu accessible from main menu and pause
- [ ] Music volume slider
- [ ] SFX volume slider
- [ ] Fullscreen toggle
- [ ] Screen shake toggle (accessibility)
- [ ] Settings persist in save file
- [ ] Controller support: D-pad/left stick movement
- [ ] Controller support: A/B buttons for select/back
- [ ] Controller navigation for all menus
- [ ] Tutorial: "WASD to move" on first run (disappears after movement)
- [ ] Tutorial: "Weapons attack automatically!" text
- [ ] "Survive until dawn" goal visible
- [ ] Tutorial flags saved (don't repeat)
- [ ] Screen shake on enemy hits
- [ ] Flash effect when player takes damage
- [ ] Particle effect on enemy death
- [ ] Visual feedback for pickup magnet range

**Integration Test:** Play entire run with controller, adjust volume mid-game

---

## Week 8: Art Integration

**End State: "The game LOOKS good"**

This week focuses on swapping placeholders for real sprites:

- Import Sarimanok sprites (all 3 variants)
- Import Duwende sprites (all 3 colors)
- Import Santelmo sprite
- Import Manananggal sprite
- Import tileset, paint arena
- Import weapon/passive icons
- Import pickup sprites
- Adjust hitboxes if needed

**Tasks:**

- [ ] Import and set up Sarimanok Classic sprite
- [ ] Import and set up Sarimanok Shadow sprite
- [ ] Import and set up Sarimanok Golden sprite
- [ ] Import and set up Green Duwende sprite
- [ ] Import and set up Red Duwende sprite
- [ ] Import and set up Black Duwende sprite
- [ ] Import and set up Santelmo sprite
- [ ] Import and set up Manananggal boss sprite
- [ ] Import tileset PNG
- [ ] Set up TileMap with tileset
- [ ] Paint arena with final tiles
- [ ] Import all weapon icons
- [ ] Import all passive icons
- [ ] Import XP gem sprite
- [ ] Import Gold coin sprite
- [ ] Adjust hitboxes if sprite shapes differ from placeholders
- [ ] Test all animations work correctly

**Fallback:** If art not ready, continue with refined placeholders. Game is still SHIPPABLE.

**Art Checkpoint:**

- If Ericka's art is ready: swap everything
- If partially ready: swap what's done, keep placeholders for rest
- If not ready: refine placeholders (add outlines, better colors)

---

## Week 9: Audio & Juice

**End State: "The game SOUNDS good"**

Adds:

- Menu music track
- Gameplay music track
- Boss music track
- Sound effects (attack, hit, death, pickup, level up)
- COCKADOODLEDOO victory sound
- Audio manager (respects volume settings)
- More particle polish
- Damage numbers (if time)

**Tasks:**

- [ ] Source/create menu music
- [ ] Source/create gameplay music
- [ ] Source/create boss music (triggers at 20:00)
- [ ] Peck attack sound
- [ ] Wing Slap sound
- [ ] Feather Shot sound
- [ ] Enemy hit sound
- [ ] Enemy death sound
- [ ] Player hurt sound
- [ ] XP pickup sound
- [ ] Gold pickup sound
- [ ] Level up sound
- [ ] Menu click sound
- [ ] COCKADOODLEDOO victory sound!
- [ ] Manananggal roar on spawn
- [ ] Audio manager respects volume settings
- [ ] Polish particle effects
- [ ] (Optional) Damage numbers on hit

**Integration Test:** Play full run with eyes closed - can you tell what's happening by sound?

---

## Week 10: Steam Integration

**End State: "Ready for Steam"**

Adds:

- Steam achievements (8 achievements for tracking metrics)
- Build exports correctly for Windows
- Test on different Windows machines if possible
- Record trailer footage
- Take screenshots

**Tasks:**

- [ ] Implement Steam achievements:
  - [ ] First Blood: Kill 100 enemies in one run
  - [ ] Survivor: Reach 10:00
  - [ ] Night Owl: Reach 20:00
  - [ ] Dawn Bringer: Beat Story Mode
  - [ ] Endless Night: Survive 45:00 in Endless
  - [ ] Shopaholic: Buy 10 shop upgrades
  - [ ] Full Arsenal: Equip 3 weapons in one run
  - [ ] Glass Cannon: Beat Story Mode as Shadow
- [ ] Export Windows build
- [ ] Test Windows build on different machine (if available)
- [ ] Record 30-60 second trailer footage
- [ ] Take 5-10 screenshots for store page
- [ ] Upload screenshots to Steam page
- [ ] Upload trailer to Steam page

**Integration Test:** Achievements unlock correctly, build runs standalone

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

## Week 13: LAUNCH

**End State: "GAME IS LIVE"**

- Launch on Steam Early Access
- Monitor for critical bugs
- Hotfix if needed
- Respond to community feedback
- Celebrate!

**Tasks:**

- [ ] Press the LAUNCH button!
- [ ] Post launch announcement to r/Philippines
- [ ] Post to Filipino gaming communities
- [ ] Monitor Steam discussions for bug reports
- [ ] Monitor reviews
- [ ] Hotfix critical bugs immediately
- [ ] Respond to player feedback
- [ ] CELEBRATE! 🎉

---

## Buffer: 3 Weeks Before Baby (March 1-21)

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
- [ ] Character select works for 3 variants
- [ ] Peck attack damages enemies
- [ ] Wing Slap damages nearby enemies
- [ ] Feather Shot fires projectiles
- [ ] Spiral Feathers orbit player
- [ ] All weapons auto-fire correctly
- [ ] Weapons upgrade through level-ups
- [ ] Passives boost stats correctly
- [ ] Magnetic Aura increases pickup range

## Enemies

- [ ] Green Duwende spawns and walks toward player
- [ ] Red Duwende is stronger than Green
- [ ] Black Duwende is strongest
- [ ] Santelmo floats and shoots fireballs
- [ ] Manananggal spawns at 20:00
- [ ] All enemies drop XP and Gold
- [ ] Spawn rate increases over time

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
- [ ] No time limit
- [ ] Enemies scale after 30:00
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
- [ ] All 3 character variants implemented
- [ ] All 5 enemies implemented
- [ ] All 4 weapons implemented
- [ ] All 4 passives implemented
- [ ] Shop system works
- [ ] Endless mode works
- [ ] Save system works
- [ ] No game-breaking bugs
- [ ] 60 FPS performance

## Should Have (Polish)

- [ ] All art is original (no placeholders)
- [ ] Sound effects for all actions
- [ ] Background music
- [ ] Screen shake and juice
- [ ] Particle effects
- [ ] Settings menu (volume, fullscreen, screen shake toggle)
- [ ] Controller support (Steam Deck compatibility)
- [ ] Basic tutorial overlays (first run)
- [ ] Steam achievements (8 total for metrics tracking)

## Nice to Have (If Time)

- [ ] Damage numbers floating
- [ ] More detailed animations

---

# Post-Launch Roadmap

## Update 1: More Enemies (Month 1)

Add new creatures from Filipino mythology:

- Tikbalang (horse-headed creature, fast charger)
- Mambabarang (voodoo witch with paralyze)
- Kapre (tree giant, slow but tanky)

## Update 2: More Character (Month 2)

- Inahin (hen) with sisiw minion mechanic

## Update 3: More Weapons (Month 2-3)

- Cockadoodle Blast (beam weapon)
- Poop Bomb (area denial)

## Update 4: Evolutions (If Validated)

- Weapon + Passive = Evolved form
- Peck + Iron Beak = Drill Beak
- Etc.

## Update 5: Localization (Month 3-4)

- Tagalog language support for Filipino diaspora
- Design UI with Godot's TranslationServer from start (even if shipping English-only)
- Community translations welcome

## Update 6: Mac/Linux Support

- Export and test Mac build
- Export and test Linux build
- Address platform-specific issues

---

# Budget Estimate

## MVP Costs

| Item             | Cost                  |
| ---------------- | --------------------- |
| Aseprite license | $20                   |
| Steam Direct fee | $100                  |
| Sound effects    | $0 (free sources)     |
| Music            | $0-50 (free or cheap) |
| Marketing        | $0 (organic)          |
| **Total**        | **~$120-170**         |

## Time Investment

| Task            | Hours           |
| --------------- | --------------- |
| Programming     | 150-200 hrs     |
| Art             | 40-50 hrs       |
| Audio           | 10-15 hrs       |
| Testing/Polish  | 30-40 hrs       |
| Marketing/Steam | 20-30 hrs       |
| **Total**       | **250-335 hrs** |

At 20 hrs/week = 12-17 weeks (4 months timeline has buffer)

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

**MVP Scope:**

- 3 characters (Sarimanok color variants)
- 5 enemies (3 Duwendes, Santelmo, Manananggal boss)
- 4 weapons (Peck, Wing Slap, Feather Shot, Spiral Feathers)
- 4 passives (Damage, HP, Speed, Pickup Range)
- 3 shop upgrades
- 1 stage (bounded farm arena)
- 2 modes (Story + Endless)

**Timeline:** 16 weeks (4 months)
**Target Launch:** Mid-March 2026
**Price:** $2.99-4.99

**If successful:** Update with more content post-launch
**If not:** Valuable learning experience, minimal financial risk

**The goal:** Ship a complete, polished game before baby arrives. Everything else is future updates.

---

**Version:** 1.3  
**Created:** December 2025  
**Authors:** Josh & Ericka  
**Cultural Consultant:** Ericka

**Version History:**

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
│ CHARACTERS: 3 (Sarimanok variants)              │
│ ENEMIES: 5 (3 Duwendes, Santelmo, Manananggal)  │
│ WEAPONS: 4 (Peck, Wing, Feather, Spiral)        │
│ PASSIVES: 4 (Damage, HP, Speed, Range)          │
│ SHOP: 3 upgrades (Damage, HP, Speed)            │
│ MODES: 2 (Story 30min, Endless)                 │
│ STAGE: 1 (Bounded farm arena)                   │
├─────────────────────────────────────────────────┤
│ PLATFORM: Windows (Mac/Linux post-launch)       │
│ SPRITES: 32x32, 48x48 boss, 16x16 icons         │
│ TIMELINE: 13 weeks (vertical slices)            │
│ LAUNCH: First week of March 2026                │
│ BABY DUE: March 21, 2026 (3 week buffer)        │
│ PRICE: $2.99-4.99                               │
├─────────────────────────────────────────────────┤
│ MINIMUM SHIPPABLE: Week 6                       │
│ STEAM SETUP: Week 5 (parallel)                  │
│ STORE PAGE: Week 6 (submit for review)          │
└─────────────────────────────────────────────────┘
```
