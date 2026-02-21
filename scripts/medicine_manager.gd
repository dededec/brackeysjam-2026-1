extends Node

var chosen_symptoms_keys: Array[String] = []
var random_symptoms = []
var pill_ready = false
const symptoms = {
	"s1": ["s1-1", "s1-2", "s1-3"],
	"s2": ["s2-2", "s2-2", "s2-3"],
	"s3": ["s3-1", "s3-2", "s3-3"],
	"s4": ["s4-1", "s4-2", "s4-3"],
	"s5": ["s5-1", "s5-2", "s5-3"],
	"s6": ["s6-1", "s6-2", "s6-3"],
	"s7": ["s7-1", "s7-2", "s7-3"],
	"s8": ["s8-1", "s8-2", "s8-3"],
	}

const medicine_symptoms = {
	"cafetera": ["s1", "s2", "s3"],
	"yano": ["s1", "s2", "s3"],
	"maligno": ["s1", "s2", "s3"],
	"cebollo": ["s1", "s2", "s3"],
	"cajagalletas": ["s1", "s2", "s3"],
	"platano": ["s1", "s2", "s3"],
	"saxo": ["s1", "s2", "s3"],
	"ambientador": ["s1", "s2", "s3"],
}
var patients = ["patient_1", "patient_2", "patient_3"]
var randomised_patients = []
var current_patient = 0

func _get_random_sentence(key: String) -> String:
	return symptoms[key][randi() % 3]

func randomise_symptoms() -> void:
	var temp_random_symptoms: Dictionary[String, String] = {}
	chosen_symptoms_keys.clear()
	for i in range(3):
		var symptom_key = "s" + str(i+1)
		var random_key = "s" + str(randi() % symptoms.keys().size() + 1)
		chosen_symptoms_keys.push_back(random_key)
		temp_random_symptoms[symptom_key] = _get_random_sentence(random_key)
	random_symptoms = temp_random_symptoms
	print(random_symptoms)

func get_current_patient_label() -> String:
	return randomised_patients[current_patient]
	
func randomise_encounters() -> void:
	randomised_patients = patients.duplicate()
	randomised_patients.shuffle()
	
func has_healed_patient(medicines: Array[String]) -> bool:
	var healed_symptoms = []
	for medicine in medicines:
		healed_symptoms.append(medicine_symptoms[medicine])
	
	for symptom in random_symptoms:
		if not healed_symptoms.has(symptom):
			return false 
	return true
