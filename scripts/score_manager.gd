extends Node

const NUM_OF_PATIENTS: int = 6
var seen_patients: int = 0
var healed_patients: int = 0

func heal_patient(medicines: Array[String]) -> void:
	seen_patients += 1
	if MedicineManager.has_healed_patient(medicines):
		healed_patients += 1

func has_seen_all_patients() -> bool:
	return seen_patients == NUM_OF_PATIENTS

func reset() -> void:
	seen_patients = 0
	healed_patients = 0
