extends Node

var healed_patients: int = 0

func heal_patient(medicines: Array[String]) -> void:
	if MedicineManager.has_healed_patient(medicines):
		healed_patients += 1
