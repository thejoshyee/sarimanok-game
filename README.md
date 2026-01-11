# Sarimanok Survivor

> *A Filipino folklore-themed bullet heaven where you play as a legendary bird defending the land until dawn*

<!-- TODO: Add gameplay GIF here -->
<!-- ![Gameplay](docs/gameplay.gif) -->

Play as the **Sarimanok**—a legendary bird from Maranao folklore—defending the land from mythological creatures through the night. Battle waves of duwendes, santelmo, and the dreaded manananggal. Survive 30 minutes until dawn breaks, and balance is restored.

## Features
- 🐓 **Unique Protagonist** - Play as the Sarimanok, an iconic Filipino legendary bird
- 👹 **Filipino Mythology** - Fight authentic creatures from Philippine folklore
- 🌅 **Clear Win Condition** - Survive 30 minutes until dawn breaks (unlike traditional survivors)
- 💰 **Roguelite Progression** - Earn gold to buy permanent upgrades between runs
- ⚔️ **Auto-Attack Combat** - Weapons fire automatically—focus on positioning and dodging

## Game Details

| | |
|---|---|
| **Genre** | Bullet Heaven / Survivor Roguelite |
| **Engine** | Godot 4.x |
| **Art Style** | Top-down pixel art (32x32 sprites) |
| **Run Length** | 30 minutes |
| **Platform** | Windows (Steam Early Access) |
| **Price** | $2.99-4.99 USD |

## Controls

| Action | Keyboard | Controller |
|--------|----------|------------|
| Move | WASD / Arrow Keys | Left Stick / D-Pad |
| Pause | Escape | Start |
| Confirm | Enter / Space | A / X |
| Cancel | Escape | B / O |

*Weapons fire automatically - focus on movement and positioning!*

## Creatures of Filipino Folklore

- **Sarimanok** - The legendary bird of Maranao mythology, a spiritual link between worlds
- **Duwende** - Mischievous earth spirits with color-based hierarchy (green, red, black)
- **Santelmo** - Floating fireballs, spirits of the departed
- **Manananggal** - A self-segmenting vampire whose upper torso detaches to hunt

## Development

**Team:** 2-person husband/wife indie dev team
**Timeline:** 14-week development cycle
**Target Launch:** March 2026 (Steam Early Access)

## Status

🚧 **In Development** - Active development (63% complete)

### Completed Systems
- ✅ Core Foundation (resolution, input, player controller, object pooling)
- ✅ Player Movement & Animation (Classic Sarimanok with 8-directional movement)
- ✅ Enemy System (Green/Red Duwende with scaling, spawning, death/drops)
- ✅ Spatial Partitioning (grid-based optimization for 200+ enemies)
- ✅ Progression Loop (XP collection, leveling, upgrade UI scaffolding)
- ✅ Performance Validation (60 FPS with 100+ enemies)
- ✅ Weapon Data Architecture (WeaponData Resource system)

### In Progress
- 🔨 Weapon System (base weapon, manager, Peck, Wing Slap, projectiles, orbitals)

## Roadmap

**Early Access Launch (v1.0)**
- 3 playable Sarimanok variants (Classic, Shadow, Golden)
- 5 enemy types including Manananggal boss
- 6 weapons + 4 passive items
- Story Mode (30 min) + Endless Mode
- Permanent shop upgrades

**Post-Launch (Free Updates)**
- Additional enemy types (Tikbalang, Kapre, Tiyanak)
- New weapons and passives
- Additional arenas beyond the Farm
- More Sarimanok variants
- Community-requested features

## Building from Source

Requires [Godot 4.5+](https://godotengine.org/download)

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/sarimanok-survivor.git
cd sarimanok-survivor

# Open in Godot
godot game/project.godot

# Or run directly
godot --path game
```

## Folklore References

The creatures in this game are based on authentic Filipino mythology:

- **Sarimanok** - Originates from Maranao culture in Mindanao, representing good fortune
- **Duwende** - Nature spirits found throughout Philippine folklore, with moral alignment often indicated by color
- **Santelmo** - Derived from "Santo Elmo" (St. Elmo's fire), these are spirits of the departed
- **Manananggal** - A viscera-sucking creature from Visayan folklore, distinct from Western vampires

## Acknowledgments

- Built with [Godot Engine](https://godotengine.org/) 4.5
- Pixel art created in [Aseprite](https://www.aseprite.org/)
- Inspired by Vampire Survivors and Filipino heritage

---

*The Sarimanok guards the land through the night. Survive until dawn.*
