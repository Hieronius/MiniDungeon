import Foundation

struct LevelBonusManager {
	
	private let commonLevelBonuses: [LevelBonus] = [
		
		
	]
	
	private let rareLevelBonuses: [LevelBonus] = [
		
		
	]
	
	private let epicLevelBonuses: [LevelBonus] = [
		
		
	]
	
	private let legenradyLevelBonuses: [LevelBonus] = [
		
		
	]
}

struct LevelBonus: Identifiable, Hashable {
	
	var id = UUID()
	var name: String
	var description: String
}
