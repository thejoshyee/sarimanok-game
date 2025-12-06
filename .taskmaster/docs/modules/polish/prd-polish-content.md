# Sarimanok Survivor - Art Integration & Audio Polish (Weeks 8-9)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Week 8: Art Integration

**End State: "The game LOOKS good"**

This week swaps placeholder ColorRect sprites with real pixel art (either from Ericka or asset packs).

## Art Integration Priority

1. **Sarimanok Classic** (FIRST - needed for demo)
2. Sarimanok Shadow & Golden
3. All enemies (Green/Red Duwende, Santelmo, Manananggal)
4. Weapon/passive icons
5. Tileset (purchased asset pack)
6. Pickups (XP gem, gold coin - purchased asset pack)

## Art Sources

| Asset Type               | Source               | Notes                                 |
| ------------------------ | -------------------- | ------------------------------------- |
| Sarimanok (all variants) | Ericka creates       | Cultural identity - MUST be authentic |
| Enemies (all 4)          | Ericka creates       | Filipino creatures - cultural hook    |
| Weapon icons             | Ericka creates       | Bird-themed                           |
| Passive icons            | Asset pack           | Generic stat icons acceptable         |
| Pickups (XP, gold)       | Asset pack           | Generic gems/coins acceptable         |
| Tileset (farm arena)     | Asset pack (~$10-20) | Generic farm tiles acceptable         |
| UI elements              | Asset pack (~$10-15) | Buttons, panels, HP/XP bars           |

## Sprite Specifications

| Asset Type      | Size  | Frames | Format |
| --------------- | ----- | ------ | ------ |
| Characters      | 32x32 | 2      | PNG    |
| Regular Enemies | 32x32 | 2      | PNG    |
| Boss            | 48x48 | 4      | PNG    |
| Icons           | 16x16 | 1      | PNG    |
| Pickups         | 16x16 | 1      | PNG    |

## Sprite Swap Process

1. **Export sprites from Aseprite** (if using Ericka's art)
2. **Import to Godot:** Drag PNG files into `res://sprites/`
3. **Update sprite references:** Change from ColorRect to Sprite2D/AnimatedSprite2D
4. **Configure animations:** Set frame count, speed (0.2s per frame)
5. **Adjust hitboxes:** If sprite shapes differ from placeholders
6. **Test:** Verify animations play correctly, hitboxes match visuals

## Art Fallback Plan

If custom art isn't ready:

- Continue with refined ColorRect placeholders
- Use purchased asset packs for generic elements (tiles, UI, pickups)
- Game is still SHIPPABLE with placeholders for EA launch

**Ericka's Art Priority:** Focus on Sarimanok and enemies (cultural identity). Everything else can use asset packs.

## Integration Test (Week 8)

**Critical: Art swap must not break gameplay!**

1. **Full Playthrough Test:**

   - Start new run with Classic Sarimanok (real sprite)
   - Survive 10:00 (encounter all enemy types with new sprites)
   - Level up 5+ times (test weapon/passive icons display)
   - Verify hitboxes match visuals (enemies take damage where expected)
   - Die intentionally - death animation plays correctly

2. **Character Comparison Test:**

   - Play 5 minutes as Classic, Shadow, Golden (all sprites work)
   - Verify each character's sprite is visually distinct
   - Check sprite flips correctly when moving left/right

3. **Visual Consistency Check:**

   - All sprites using correct size (32x32 for characters/enemies, 48x48 for boss)
   - No sprites appear stretched or distorted
   - Animations play at correct speed (0.2s per frame)
   - Pickup sprites visible and collect correctly

4. **Arena Integration:**
   - Tileset imported and painted correctly
   - Player collision works with new tiles
   - Camera bounds still correct (doesn't show edges)
   - Background doesn't cause performance drops

**Pass Criteria:** Complete 30:00 victory run with all new art, no visual glitches, hitboxes accurate, 60 FPS maintained.

---

# Week 9: Audio Polish

**End State: "The game SOUNDS polished and professional"**

> **Note:** Placeholder SFX were added in Weeks 2-3. Week 9 replaces them with final audio.

## Music Tracks (4 Total)

| Track          | Purpose                 | Length    | Notes                      |
| -------------- | ----------------------- | --------- | -------------------------- |
| Menu theme     | Main menu               | 1-2 min   | Calm, Filipino-inspired    |
| Night theme    | Main gameplay           | 1-2 min   | Tense, action              |
| Boss theme     | When Manananggal spawns | 1-2 min   | Intense, dramatic          |
| Victory jingle | Dawn/win                | 10-20 sec | Triumphant, Sarimanok crow |

## Sound Effects (Replace Placeholders)

**Placeholder SFX from Weeks 2-3:**

- Peck attack
- Wing Slap
- Feather Shot
- Spiral Feathers
- Enemy hit
- Enemy death
- XP pickup
- Gold pickup

**New SFX for Week 9:**

- Player hurt
- Level up
- Menu click
- Menu hover
- COCKADOODLEDOO (victory)
- Manananggal roar (boss spawn)
- Dawn ambience (victory transition)

## Pitch Randomization (CRITICAL)

Repetitive sounds will play 10,000+ times per run. Without pitch variation, they become fatiguing:

```gdscript
# AudioManager.gd
func play_sfx(sound_name: String, pitch_variance: float = 0.1):
    var player = get_available_audio_player()
    player.stream = sfx_library[sound_name]
    player.pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
    player.play()

# Usage:
# play_sfx("enemy_hit", 0.1)  # 0.9x to 1.1x pitch
# play_sfx("enemy_death", 0.15)  # Wider variance for death
```

## Audio Sources

**Music:**

- Free: Pixabay Music, OpenGameArt (game-focused)
- Paid: Epidemic Sound ($15/month), Fiverr commission ($50-150 for 4 tracks)

**Sound Effects:**

- Free: freesound.org (CC0), BFXR (generate retro SFX)
- Paid: Fantasy/RPG SFX pack ($15-30) - RECOMMENDED to avoid hunting individual sounds

## Music Triggers

```gdscript
func _ready():
    play_music("menu_theme")

func start_run():
    crossfade_music("menu_theme", "night_theme", 0.5)

func _on_boss_spawn():
    crossfade_music("night_theme", "boss_theme", 0.5)

func _on_victory():
    stop_music(1.0)  # Fade out
    play_sfx("cockadoodledoo")
    play_music("victory_jingle", false)  # No loop
```

## Audio Specifications

**Music:**

- Format: OGG Vorbis (smaller than WAV)
- Loop length: 1-2 minutes
- Crossfade duration: 0.5 seconds
- Volume default: 80% (leave headroom for SFX)

**SFX:**

- Format: WAV (16-bit, 44.1kHz)
- Max simultaneous: 8 sounds at once
- Priority (highest to lowest): Player hurt > Pickup > Level up > Weapon > Enemy

## Integration Test (Week 9)

**Critical: Audio must enhance gameplay, not distract from it!**

1. **Eyes Closed Test (Audio-Only Gameplay):**

   - Play 5-minute run with eyes closed
   - Can you tell when you're taking damage? (player hurt sound)
   - Can you tell when enemies die? (death sound + pickup chime)
   - Can you tell when you level up? (level up sound + music pause)
   - Can you distinguish different weapon sounds? (Peck vs Wing Slap vs Feather Shot)
   - **Pass if:** All major gameplay events are recognizable by audio alone

2. **Full Run Audio Test:**

   - Start from main menu (menu music plays)
   - Start run (crossfade to night theme)
   - Survive to 20:00 (boss theme triggers)
   - Win at 30:00 (COCKADOODLEDOO + victory jingle)
   - Verify no audio glitches, clicks, or pops during transitions

3. **Repetition Fatigue Test:**

   - Play 15-minute run focusing only on audio
   - Kill 200+ enemies (enemy hit sound plays hundreds of times)
   - Collect 100+ pickups (pickup sounds repeat constantly)
   - **Check:** Does pitch randomization prevent ear fatigue?
   - **Check:** Do sounds become annoying or grating?

4. **Settings Compliance Test:**

   - Set music volume to 0% (music mutes, SFX still audible)
   - Set SFX volume to 0% (SFX mutes, music still audible)
   - Set both to 50% (both audible at half volume)
   - Verify settings persist after game restart

5. **Music Progression Test:**
   - Verify music crossfades smoothly (no abrupt cuts)
   - Boss music intensity increases tension
   - Victory jingle feels triumphant (ends run on high note)
   - Menu music loops seamlessly (no noticeable seam)

**Pass Criteria:** Complete 30:00 victory run, all audio triggers correctly, no ear fatigue from repetitive sounds, audio enhances immersion rather than distracting from gameplay.

---

**Related Files:**
- [Settings & Game Feel](prd-polish-feel.md) - Week 7
- [Steam Build & Balance](prd-polish-release.md) - Weeks 10-11



