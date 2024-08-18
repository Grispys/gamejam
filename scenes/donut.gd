extends Node3D



var is_eaten: bool = false

func eaten() -> void:
    is_eaten = true
    print("You win!")



func _on_interactable_interacted(_interactor:Interactor):
    if not is_eaten:
        eaten()


