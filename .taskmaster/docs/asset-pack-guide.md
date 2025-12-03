# Asset Pack Purchasing Guide

> Complete this week (Dec 3-8) to have assets ready for development.

---

## What You Need

| Asset Type                           | Budget                   | Priority |
| ------------------------------------ | ------------------------ | -------- |
| UI Kit (buttons, panels, HP/XP bars) | $10-15                   | HIGH     |
| Tileset (grass, dirt, trees, fences) | $10-20                   | HIGH     |
| SFX Pack (fantasy/RPG sounds)        | $15-30                   | MEDIUM   |
| Pickups (gems, coins)                | Often included in UI kit | LOW      |

**Total Budget: ~$30-50**

---

## Recommended Sources

### UI Asset Packs

**itch.io** (Best for pixel art indie games)

- Search: https://itch.io/game-assets/tag-pixel-art/tag-ui
- Look for: "Fantasy UI", "RPG UI Kit", "Pixel UI"
- Price range: $5-20

**Recommended packs to check:**

- "Pixel Art GUI Elements" type packs
- Look for: HP bars, XP bars, buttons, panels, frames
- Ensure it matches 16x16 or 32x32 pixel scale

### Tileset Asset Packs

**itch.io**

- Search: https://itch.io/game-assets/tag-tileset/tag-pixel-art
- Look for: "Farm tileset", "Grass tileset", "Fantasy outdoor"
- Ensure 32x32 tile size (matches your sprites)

**Kenney.nl** (FREE, high quality)

- https://kenney.nl/assets
- Look for: "Roguelike/RPG Pack", "Tiny Town", "Pixel Platformer"
- All CC0 license (free to use commercially)

### SFX Packs

**Gamedev Market**

- https://www.gamedevmarket.net/category/audio/
- Search: "Fantasy SFX", "RPG Sound Effects"
- Price: $15-30 for comprehensive packs

**Humble Bundle** (check for current audio bundles)

- https://www.humblebundle.com/
- Great value if timing works

**Free Options:**

- Sonniss GDC Audio: https://sonniss.com/gameaudiogdc (30GB+ free sounds)
- Freesound.org (requires curation time)

---

## What to Look For

### UI Pack Checklist

- [ ] HP bar (filled/empty states)
- [ ] XP bar (filled/empty states)
- [ ] Button sprites (normal, hover, pressed)
- [ ] Panel/frame backgrounds
- [ ] Consistent pixel scale (16x16 or 32x32)
- [ ] Commercial license included

### Tileset Checklist

- [ ] Grass variations (2-3 types)
- [ ] Dirt/path tiles
- [ ] Fence pieces (left, middle, right, post)
- [ ] Tree/bush decorations
- [ ] Rock/grass tuft details
- [ ] 32x32 tile size
- [ ] Commercial license included

### SFX Pack Checklist

- [ ] Hit/impact sounds (varied)
- [ ] Pickup sounds (coins, gems)
- [ ] UI click sounds
- [ ] Death/defeat sounds
- [ ] Attack whoosh sounds
- [ ] WAV format (16-bit, 44.1kHz)

---

## License Notes

**Always verify commercial use is allowed!**

- **CC0**: Free for commercial use, no attribution
- **CC-BY**: Free for commercial use, requires attribution
- **Personal use only**: DO NOT USE for Steam release

Most paid asset packs include commercial licenses, but double-check before purchase.

---

## Quick Action Plan

1. **Today**: Browse itch.io for UI and tileset packs
2. **Purchase**: Buy 1 UI pack + 1 tileset pack (~$25-35)
3. **Download**: Organize in `game/assets/purchased/` folder
4. **Verify**: Check licenses allow commercial Steam release
5. **SFX**: Can wait until Week 2, but browsing now saves time

---

## Import to Godot

After purchasing:

```
game/
├── assets/
│   ├── purchased/
│   │   ├── ui/           # UI pack files
│   │   ├── tileset/      # Tileset files
│   │   └── sfx/          # SFX files
│   └── original/         # Ericka's art (later)
```

Godot will automatically import PNG files. Configure import settings as needed (pixel art filter: Nearest).

---

_Guide created: December 2025_
