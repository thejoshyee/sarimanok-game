# Sarimanok Survivor - Settings & Game Feel (Week 7)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

After Week 6, you have a functionally complete, shippable MVP. Week 7 focuses on making the game **feel good** (settings, juice, controller polish).

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

---

# Week 7: Settings & Game Feel

**End State: "The game FEELS good and controller experience is polished"**

## Settings Menu

### Required Settings

| Setting               | Purpose                                      | Default    |
| --------------------- | -------------------------------------------- | ---------- |
| Music Volume          | Control background music loudness            | 80%        |
| SFX Volume            | Control sound effects loudness               | 100%       |
| Fullscreen Toggle     | Switch between fullscreen and windowed       | On         |
| Window Mode           | Fullscreen / Windowed / Borderless           | Fullscreen |
| Resolution            | For non-16:9 monitors                        | Native     |
| Screen Shake Toggle   | Accessibility (some players get motion sick) | On         |
| Reduced Motion Option | Disable particles for motion sensitivity     | Off        |

### Settings Persistence

Settings save to file:

```json
{
  "settings": {
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "fullscreen": true,
    "window_mode": "fullscreen", // "fullscreen", "windowed", "borderless"
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

## Integration Test (Week 7)

**Critical: Polish must enhance the existing game, not break it!**

1. **Full Controller Playthrough:**

   - Play entire run (0:00 → 30:00) using ONLY controller
   - Navigate main menu with D-pad/stick (no mouse)
   - Start run, level up 10+ times, verify all UI navigable
   - Pause mid-game, adjust settings, resume (all with controller)
   - Beat game, navigate results screen, return to menu (no mouse)
   - **Pass if:** Never need to touch keyboard/mouse

2. **Input Device Switching Test:**

   - Start run with controller (see controller button prompts)
   - Mid-run, switch to keyboard (prompts change to keyboard keys)
   - Switch back to controller (prompts revert to controller buttons)
   - Verify switching is seamless (no lag, no broken prompts)

3. **Settings Integration Test:**

   - Adjust ALL settings in menu
   - Start run and verify each setting works:
     - Music volume at 50% (quieter than default)
     - SFX volume at 50% (quieter than default)
     - Screen shake OFF (no shake on hits)
     - Reduced motion ON (fewer particles)
   - Quit to menu, restart game
   - Verify settings persisted (still at 50% volume, shake off, etc.)

4. **Game Feel Test (Juice Validation):**

   - Start run and pay attention to visual/tactile feedback:
     - Screen shake on enemy hits (if enabled) - feels impactful?
     - Enemy death particles appear and fade
     - Pickup magnet shows visual feedback (gems drift toward player)
     - Level-up particle burst feels celebratory
     - Impact frames on big hits feel satisfying
   - **Pass if:** Combat feels "juicy" and satisfying, not flat

5. **Tutorial Test (New Player Simulation):**

   - Fresh run as if you've never played before
   - Do NOT read any external documentation
   - Can you figure out movement in first 30 seconds? (no text tells you)
   - Do you understand weapons auto-attack? (damage numbers appear)
   - Do you understand level-up system? (first choice is clear)
   - **Pass if:** First-time player can survive 5+ minutes without reading docs

6. **Accessibility Test:**
   - Enable colorblind mode
   - Can you still distinguish Green vs Red Duwende? (size/shape difference)
   - Enable reduced motion
   - Does game still feel responsive without particles?
   - Test at 1280x720 resolution (Steam Deck)
   - Is all text still readable?

**Pass Criteria:** Complete 30:00 victory run with controller, all settings work and persist, game feels polished and satisfying, tutorial teaches naturally without text overlays.

---

**Related Files:**
- [Art Integration & Audio Polish](prd-polish-content.md) - Weeks 8-9
- [Steam Build & Balance](prd-polish-release.md) - Weeks 10-11








