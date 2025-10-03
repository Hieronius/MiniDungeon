import Foundation

struct SpecialisationManager {
	
	static let specialisations: [Specialisation] = [
		
		Specialisation(
			name: "Warrior",
			description: "Mighty Warrior gain 5 more max health and 1 more max damage"),
		
		Specialisation(
			name: "Knight",
			description: "Strong Knight gain 5 more max health and 1 extra defence point"),
		
		Specialisation(
			name: "Assasin",
			description: "An Assasin gain 2 extra max damage points"),
		
		Specialisation(
			name: "Priest",
			description: "Prist gain 1 spell power and 5 max mana points"),
		
		Specialisation(
			name: "Mage",
			description: "Mage gain 10 extra max mana points")
	]
	
	static func getThreeRandomSpecialisations() -> [Specialisation] {
		
		var specs: Set<Specialisation> = []
		
		while specs.count < 3 {
			
			guard let spec = self.specialisations.randomElement() else { return [] }
			specs.insert(spec)
		}
		
		return Array(specs)
	}
}

/// You can choose one of three different specialisation at the start of each run
struct Specialisation: Identifiable, Hashable {
	
	var id = UUID()
	var name: String
	var description: String
}
