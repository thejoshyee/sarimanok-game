# Sarimanok Survivor - Input Map Reference

This document defines all input actions configured in `Project Settings → Input Map`.

## Movement Actions

| Action       | Keyboard       | Gamepad                       | Deadzone |
| ------------ | -------------- | ----------------------------- | -------- |
| `move_up`    | W, Up Arrow    | D-pad Up, Left Stick Up       | 0.2      |
| `move_down`  | S, Down Arrow  | D-pad Down, Left Stick Down   | 0.2      |
| `move_left`  | A, Left Arrow  | D-pad Left, Left Stick Left   | 0.2      |
| `move_right` | D, Right Arrow | D-pad Right, Left Stick Right | 0.2      |

## System Actions

| Action  | Keyboard | Gamepad | Deadzone |
| ------- | -------- | ------- | -------- |
| `pause` | Escape   | Start   | 0.2      |

## UI Actions (Built-in, Extended)

| Action      | Keyboard     | Gamepad                    | Deadzone |
| ----------- | ------------ | -------------------------- | -------- |
| `ui_accept` | Enter, Space | A (Xbox) / X (PlayStation) | 0.5      |
| `ui_cancel` | Escape       | B (Xbox) / O (PlayStation) | 0.5      |

## Usage in Code

### Movement (supports analog sticks)

```gdscript
# Use get_action_strength for smooth analog input
var horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
var vertical = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
var direction = Vector2(horizontal, vertical).normalized()
```

### Pause Toggle

```gdscript
func _input(event):
    if event.is_action_pressed("pause"):
        toggle_pause()
```

### UI Navigation

```gdscript
func _input(event):
    if event.is_action_pressed("ui_accept"):
        confirm_selection()
    elif event.is_action_pressed("ui_cancel"):
        go_back()
```

## Notes

- Movement deadzone (0.2) prevents stick drift from triggering movement
- All movement actions support both digital (keyboard/D-pad) and analog (stick) input
- The `pause` action shares the Escape key with `ui_cancel` - handle context appropriately






