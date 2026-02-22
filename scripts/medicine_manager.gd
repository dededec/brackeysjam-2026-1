extends Node

var chosen_symptoms_keys: Array[String] = []
var random_symptoms = []
var pill_ready = false

const symptoms = {
	"nostalgia": ["I reminisce about better days.", 
			"Past times seem better to me.", 
			"I think a lot about my childhood."],
	"insomnia": ["I cannot sleep at night.", 
			"Every night, I go to bed at 4AM", 
			"I am marathoning Friends in the wee hours."],
	"loneliness": ["I have no one with me.", 
			"I need a hug.", 
			"I feel lonely."],
	"gases": ["I am gassy.", 
			"I feel full all the time.", 
			"My stomatch is bloated."],
	"monotony": ["Everyday feels the same.", 
			"Life's all work and chores.", 
			"I feel trapped in routine."],
	"creative_block": ["I haven't made music in ages.", 
			"I cannot bring myself to write my memories.", 
			"I can't think of new ideas for making a game."],
	"throat_itch": ["My throat itches.", 
			"EHEM EHEM Sorry, my throat feels itchy.", 
			"I have a mouth but I cannot scream."],
	"goosebumps": ["I've been reading R.L. Stine recently.", 
			"This cold has me shaking uncontrollably.", 
			"I watched a horror movie and cannot stop shaking."],
	}

const medicine_symptoms = {
	"cafetera": ["insomnia",],
	"yano": ["loneliness", "nostalgia",],
	"maligno": ["creative_block", "goosebumps"],
	"cebollo": ["loneliness", "goosebumps",],
	"cajagalletas": ["nostalgia",],
	"platano": ["gases", "monotony", ],
	"saxo": ["monotony", "creative_block", ],
	"ambientador": ["gases", "throat_itch",],
}
const patients = ["patient_1", "patient_2", "patient_3", 
"patient_4", "patient_5", "patient_6"]
var randomised_patients = []
var current_patient = 0

func _get_random_sentence(key: String) -> String:
	return symptoms[key][randi() % 3]

func randomise_symptoms() -> void:
	var temp_random_symptoms: Dictionary[String, String] = {}
	chosen_symptoms_keys.clear()
	for i in range(3):
		var symptom_key = "s" + str(i+1)
		var random_symptom = symptoms.keys()[randi() % symptoms.keys().size()]
		chosen_symptoms_keys.push_back(random_symptom)
		temp_random_symptoms[symptom_key] = _get_random_sentence(random_symptom)
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
