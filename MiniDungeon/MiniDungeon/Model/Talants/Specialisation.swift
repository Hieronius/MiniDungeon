import Foundation

// MARK: - SpecialisationManager

/// Entity to store all possible hero's specialisations in the game
struct SpecialisationManager {
	
	// MARK: specialisations
	
	static let specialisations: [Specialisation] = [
		
		Specialisation(
			name: "Warrior",
			specDescription: "Mighty Warrior gain 5 more max health and 1 more max damage"),
		
		Specialisation(
			name: "Knight",
			specDescription: "Strong Knight gain 5 more max health and 1 extra defence point"),
		
		Specialisation(
			name: "Assasin",
			specDescription: "An Assasin gain 2 extra max damage points"),
		
		Specialisation(
			name: "Priest",
			specDescription: "Priest gains 3 spell power and 10 max mana and health points"),
		
		Specialisation(
			name: "Mage",
			specDescription: "Mage gains 5 extra spell power and 20 extra max mana points")
	]
	
	// MARK: getThreeRandomSpecialisations
	
	static func getThreeRandomSpecialisations() -> [Specialisation] {
		
		var specs: Set<Specialisation> = []
		
		while specs.count < 3 {
			
			guard let spec = self.specialisations.randomElement() else { return [] }
			specs.insert(spec)
		}
		
		return Array(specs)
	}
}

// MARK: Specialisation

/// You can choose one of three different specialisation at the start of each run
struct Specialisation: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	var specDescription: String
	
	init(name: String,
		 specDescription: String
	) {
		self.id = UUID()
		self.name = name
		self.specDescription = specDescription
	}
}
