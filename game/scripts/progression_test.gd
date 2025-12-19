extends Node

func _ready():
    # Test level 1→2 at 120 XP
    ProgressionManager.add_xp(120)
    print("After 120 XP: Level ", ProgressionManager.current_level, " XP: ", ProgressionManager.current_xp)
    
    # Test level 2→3 (needs 280 more XP from level 2)
    ProgressionManager.add_xp(280)
    print("After 280 more XP: Level ", ProgressionManager.current_level, " XP: ", ProgressionManager.current_xp)
