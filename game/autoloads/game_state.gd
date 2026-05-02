extends Node

# Central run-reset orchestrator.
func reset_run() -> void:
	PoolManager.reset_run()
	ProgressionManager.reset_run()
	GameTimer.reset_run()
	PassiveManager.reset_run()
