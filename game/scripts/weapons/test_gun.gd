extends BaseWeapon
class_name TestGun

func attack() -> void:
    # find nearest enemy
    var target = find_nearest_enemy()
    if not target:
        print("No enemy found")
        reset_cooldown()
        return

    # spawn projectile toward enemy
    spawn_projectile(target.global_position)
    print("Fired at enemy at ", target.global_position)

    # reset cooldown so weapon waits before firing again
    reset_cooldown()

func get_base_cooldown() -> float:
    return 1.0 # fire once per second

func get_base_damage() -> float:
    return 10.0 # 10 damage per shot
