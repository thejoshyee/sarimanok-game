# Sarimanok Survivor - Polish & Balance (Weeks 7-11)

## Project Context
- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026
- **Price:** $2.99-4.99

After Week 6, you have a functionally complete, shippable MVP. Weeks 7-11 focus on making the game **feel good** (settings, juice, controller polish), **look good** (art integration), **sound good** (music + final SFX), and **play well** (balance, bugs, performance). Code freezes at end of Week 10 for final testing before Next Fest demo submission.

## Dependencies

**Must be completed from Weeks 1-6:**
- Complete Story Mode with win condition (30:00 dawn)
- All 3 characters (Classic, Shadow, Golden Sarimanok)
- All 4 enemies (Green/Red Duwende, Santelmo, Manananggal)
- All 6 weapons functional
- All 4 passives functional
- Shop system with permanent upgrades
- Endless Mode
- Save system
- Placeholder SFX from Weeks 2-3
- Damage numbers and enemy flash from Week 3

## Weeks 7-11 Goals
- **Week 7:** Settings menu, accessibility, controller UX, juice (screen shake, particles)
- **Week 8:** Art integration (swap placeholders → real sprites)
- **Week 9:** Audio polish (music tracks, final SFX)
- **Week 10:** Steam build, demo, achievements (CODE COMPLETE milestone)
- **Week 11:** Balance, bugs, playtesting

---

# Week 7: Settings & Game Feel

**End State: "The game FEELS good and controller experience is polished"**

## Settings Menu

### Required Settings

| Setting               | Purpose                                    | Default |
| --------------------- | ------------------------------------------ | ------- |
| Music Volume          | Control background music loudness          | 80%     |
| SFX Volume            | Control sound effects loudness             | 100%    |
| Fullscreen Toggle     | Switch between fullscreen and windowed     | On      |
| Window Mode           | Fullscreen / Windowed / Borderless         | Fullscreen|
| Resolution            | For non-16:9 monitors                      | Native  |
| Screen Shake Toggle   | Accessibility (some players get motion sick)| On     |
| Reduced Motion Option | Disable particles for motion sensitivity   | Off     |

### Settings Persistence

Settings save to file:

```json
{
  "settings": {
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "fullscreen": true,
    "window_mode": "fullscreen",  // "fullscreen", "windowed", "borderless"
    "screen_shake_enabled": true,
    "reduced_motion": false
  }
}
```

### Technical Requirements

- Settings menu accessible from main menu and pause menu
- Settings apply immediately (no "Apply" button needed)
- Volume sliders control AudioServer bus volumes
- Settings persist in save file
- Load settings at game start

## Accessibility Features

**Colorblind Mode Consideration:**
- Green/Red Duwende must be distinguishable without color
- Solution: Add size or shape difference (Red slightly larger, or different silhouette)

**Reduced Motion:**
- Disable particle effects when enabled
- Reduce or eliminate screen shake
- Keep gameplay identical (enemy movement, weapons still work)

**Steam Deck Support:**
- Test text legibility at 1280x720 resolution
- Verify controller support works (from Week 1)
- Test performance at lower resolution

## Game Feel (Juice)

### Screen Shake

Implement subtle camera shake on impactful events:

```gdscript
func camera_shake(intensity: float, duration: float):
    if not GameState.settings.screen_shake_enabled:
        return
    
    var tween = create_tween()
    var original_offset = camera.offset
    
    for i in range(int(duration * 60)):  # 60 FPS
        var shake_offset = Vector2(
            randf_range(-intensity, intensity),
            randf_range(-intensity, intensity)
        )
        tween.tween_property(camera, "offset", original_offset + shake_offset, 0.016)
    
    tween.tween_property(camera, "offset", original_offset, 0.1)
```

**Shake triggers:**
- Player takes damage: intensity 5, duration 0.2s
- Boss spawns: intensity 10, duration 0.5s
- Boss dies: intensity 8, duration 0.4s

### Impact Frames (Hitstop)

Brief 50ms pause on big hits for satisfying feedback:

```gdscript
func hitstop(duration: float = 0.05):
    Engine.time_scale = 0.0
    await get_tree().create_timer(duration, true, false, true).timeout
    Engine.time_scale = 1.0
```

**Hitstop triggers:**
- Boss takes damage
- Player kills multiple enemies at once (3+)
- Player levels up

### Particle Effects

- Enemy death: small burst of colored particles matching enemy
- XP gem magnetism: subtle glow/sparkle when in pickup range
- Level-up: large particle burst with scale animation
- Victory dawn: rising sun particles, bird silhouettes (optional)

### Visual Feedback

- Invincibility flash: Player sprite flashes white when taking damage (already implemented in Week 3)
- Pickup magnet visual: Faint circle showing pickup range radius
- Boss HP bar: Positioned above boss, red fill with damage shake

## Controller UX Polish

> **Note:** Core controller INPUT was set up in Week 1 using `Input.get_action_strength()`. Week 7 adds UX polish to make it feel native.

### UI Navigation

- D-pad/Left Stick: Navigate menus
- A Button (Xbox) / Cross (PS): Confirm selection
- B Button (Xbox) / Circle (PS): Back/Cancel
- Start: Pause (already mapped in Week 1)

### Dynamic Button Prompts

Detect input device and show appropriate icons:

```gdscript
# InputManager.gd - Track last input device
var last_input_device: String = "keyboard"  # or "controller"

func _input(event):
    if event is InputEventKey or event is InputEventMouse:
        if last_input_device != "keyboard":
            last_input_device = "keyboard"
            EventBus.input_device_changed.emit("keyboard")
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        if last_input_device != "controller":
            last_input_device = "controller"
            EventBus.input_device_changed.emit("controller")
```

**UI updates:**
- Show "Press SPACE" vs "Press A"
- Show keyboard icons vs controller icons
- Update immediately when device switches mid-game

### Dead Zone & Sensitivity

Test and adjust:
- Left stick dead zone: 0.15 (default)
- Movement sensitivity: Feels responsive but not twitchy
- Menu navigation: Slightly lower sensitivity to prevent accidental selections

## Tutorial (Level Design, NOT Overlays)

**Design Principles:**
- No text overlays blocking gameplay
- Learn by doing, not by reading
- First 30 seconds teach movement and combat naturally

**Implementation:**
- First 30 seconds: Slow spawn pattern forces player to discover WASD movement
- Peck auto-attacks immediately (player sees damage numbers, understands combat)
- Brief "Survive until dawn" text at run start (fades after 3s)
- First level-up choice is semi-scripted (only show weapon options to teach system)
- Icon-based learning where possible (no paragraphs of text)

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

| Asset Type               | Source                    | Notes                                   |
| ------------------------ | ------------------------- | --------------------------------------- |
| Sarimanok (all variants) | Ericka creates            | Cultural identity - MUST be authentic   |
| Enemies (all 4)          | Ericka creates            | Filipino creatures - cultural hook      |
| Weapon icons             | Ericka creates            | Bird-themed                             |
| Passive icons            | Asset pack                | Generic stat icons acceptable           |
| Pickups (XP, gold)       | Asset pack                | Generic gems/coins acceptable           |
| Tileset (farm arena)     | Asset pack (~$10-20)      | Generic farm tiles acceptable           |
| UI elements              | Asset pack (~$10-15)      | Buttons, panels, HP/XP bars             |

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

---

# Week 9: Audio Polish

**End State: "The game SOUNDS polished and professional"**

> **Note:** Placeholder SFX were added in Weeks 2-3. Week 9 replaces them with final audio.

## Music Tracks (4 Total)

| Track          | Purpose                 | Length    | Notes                           |
| -------------- | ----------------------- | --------- | ------------------------------- |
| Menu theme     | Main menu               | 1-2 min   | Calm, Filipino-inspired         |
| Night theme    | Main gameplay           | 1-2 min   | Tense, action                   |
| Boss theme     | When Manananggal spawns | 1-2 min   | Intense, dramatic               |
| Victory jingle | Dawn/win                | 10-20 sec | Triumphant, Sarimanok crow      |

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

---

# Week 10: Steam Build & Demo (CODE COMPLETE)

**End State: "Ready for Steam with demo and achievements"**

**🎯 CODE COMPLETE MILESTONE (February 2-8, 2026)**

This is feature freeze. By end of Week 10:
- All features implemented and working
- All art integrated (or refined placeholders)
- Demo submitted for Next Fest review (Feb 9 deadline)
- Weeks 11-14 are ONLY for bugs, balance, and launch logistics

## Demo Configuration (10-Minute Time Limit)

**Type:** Time-limited demo (same build with timer check)

| Setting          | Value                                         |
| ---------------- | --------------------------------------------- |
| Time Limit       | 10 minutes                                    |
| Cut-off Point    | Before Santelmo (10:00) and before boss (20:00)|
| Shop Access      | DISABLED (removes meta-progression hook)      |
| Character Select | Classic Sarimanok only                        |
| Save Data        | Does not persist                              |

**Demo End Screen:**

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

**Implementation:**

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

## Steam Achievements (5-8 for EA)

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

## GodotSteam Integration (2-4 Hours)

1. Install GodotSteam GDExtension from Godot Asset Library (2-3 min)
2. Create Steam autoload with initialization code (15-30 min)
3. Test Steam overlay (Shift+Tab)
4. **IMPORTANT:** Use Compatibility rendering mode (Forward+ breaks overlay)
5. **IMPORTANT:** Set `SteamAppId` environment variable BEFORE `Steam.steamInit()`

**Achievement Hook Example:**

```gdscript
func _on_story_mode_victory():
    if Steam.isInitialized():
        Steam.setAchievement("ACHIEVEMENT_FIRST_DAWN")
        Steam.storeStats()
```

## Analytics Logging (CRITICAL for Update 1)

Log to local file for balance decisions:

```gdscript
func log_run_data():
    var run_data = {
        "time_survived": time_survived,
        "death_location": player.global_position,
        "enemies_killed": enemies_killed,
        "weapons_chosen": weapons.map(func(w): return w.id),
        "passives_chosen": passives.keys(),
        "final_level": level,
        "cause_of_death": last_damage_source,
        "timestamp": Time.get_unix_time_from_system()
    }
    
    var file = FileAccess.open("user://analytics.log", FileAccess.READ_WRITE)
    file.seek_end()
    file.store_line(JSON.stringify(run_data))
```

**Use for Update 1:** Analyze which weapons are popular, where players die, average survival time.

---

# Week 11: Balance & Bugs

**End State: "The game is FUN and STABLE"**

## Playtesting Focus

**Run 10+ full runs and track:**
- Average survival time for new players (target: 8-12 minutes)
- Win rate after 5 attempts (target: 20-30%)
- Most popular weapon choices (should be varied)
- Most common death locations/times (adjust difficulty spikes)
- Performance at 200+ enemies (target: 60 FPS)

## Balance Adjustments

**Enemy Stats:**
- If players survive past 30:00 easily: Increase stat scaling rate
- If players die before 10:00 consistently: Reduce early spawn rate
- If boss is trivial: Increase HP or dive attack frequency
- If boss is impossible: Reduce HP or telegraph dive attack longer

**Weapon Balance:**
- If one weapon dominates: Nerf slightly, buff alternatives
- If weapon feels weak: Increase damage or reduce cooldown
- If max level feels underwhelming: Increase final upgrade power

**XP Curve:**
- If leveling too fast: Increase XP requirements
- If leveling too slow: Decrease XP requirements or increase enemy XP drops

## Bug Fixing Priority

1. **Game-breaking:** Crashes, soft-locks, save corruption
2. **Critical:** Can't progress, lose progress, major exploits
3. **High:** Noticeable visual glitches, audio issues, balance problems
4. **Medium:** Minor visual issues, typos, small QoL improvements
5. **Low:** Polish, "nice-to-have" features

## Performance Testing

- 200+ enemies at 60 FPS (target from Week 6)
- 30-minute run with no memory leaks
- Rapid level-ups (spam XP collection) - no lag
- 1000+ projectiles on screen - acceptable FPS (45+)

## External Feedback

Send build to 3-5 friends/family:
- Can they beat Story Mode in 3-5 attempts?
- What feels unfair or frustrating?
- What feels satisfying and fun?
- Any crashes or bugs encountered?

## Error Handling

Wrap critical systems:

```gdscript
func save_game():
    try:
        # Save logic here
        pass
    catch error:
        push_error("Save failed: " + str(error))
        show_error_notification("Failed to save game. Please check disk space.")
```

---

# Definition of Done (Weeks 7-11)

## Week 7 (Settings & Feel)
- [ ] Settings menu works from main menu and pause
- [ ] Volume controls work (music, SFX)
- [ ] Fullscreen/windowed toggle works
- [ ] Screen shake toggle works (accessibility)
- [ ] Reduced motion option works
- [ ] Settings persist in save file
- [ ] Controller UI navigation works (D-pad/stick)
- [ ] Button prompts switch dynamically (keyboard ↔ controller)
- [ ] Screen shake on hits (if enabled)
- [ ] Impact frames on big hits
- [ ] Enemy death particles
- [ ] Pickup magnet visual feedback
- [ ] Level-up particle burst
- [ ] Tutorial teaches through level design (no overlays)

## Week 8 (Art)
- [ ] Sarimanok Classic sprite imported and working
- [ ] Sarimanok Shadow sprite imported and working
- [ ] Sarimanok Golden sprite imported and working
- [ ] All enemy sprites imported and working
- [ ] Tileset imported, arena painted
- [ ] Weapon/passive icons imported
- [ ] Pickup sprites imported
- [ ] Hitboxes adjusted if needed
- [ ] Animations play correctly
- [ ] No visual glitches

## Week 9 (Audio)
- [ ] Menu music plays
- [ ] Gameplay music plays
- [ ] Boss music triggers at 20:00
- [ ] Victory jingle plays at win
- [ ] All placeholder SFX replaced with final
- [ ] COCKADOODLEDOO sound plays at victory
- [ ] Manananggal roar on spawn
- [ ] Audio respects volume settings
- [ ] Pitch randomization on repetitive sounds
- [ ] Music crossfades smoothly

## Week 10 (Steam Build)
- [ ] Windows build exports correctly
- [ ] Demo build with 10-minute timer works
- [ ] Demo end screen displays with wishlist CTA
- [ ] GodotSteam integration complete
- [ ] Steam overlay works (Shift+Tab)
- [ ] 5-8 achievements implemented and tested
- [ ] Analytics logging to local file
- [ ] Demo submitted for Next Fest review by Feb 9
- [ ] Trailer recorded (gameplay in first 5 seconds)
- [ ] Final screenshots taken

## Week 11 (Balance & Bugs)
- [ ] 10+ full playtests completed
- [ ] All game-breaking bugs fixed
- [ ] All critical bugs fixed
- [ ] Enemy balance feels fair
- [ ] Weapon balance feels varied
- [ ] XP curve feels appropriate
- [ ] Performance: 200+ enemies at 60 FPS
- [ ] No memory leaks in 30-minute run
- [ ] Feedback from 3-5 external testers collected
- [ ] Trailer finalized with music and titles
- [ ] Steam Deck testing complete (if available)

---

**Next Milestone:** Weeks 12-14 (Launch Prep) - See `prd-launch.md`

