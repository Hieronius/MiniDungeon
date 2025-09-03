import Foundation

struct GameState {

	// MARK: Combat
	
	var isHeroTurn = true
	
	var hero = Hero()
	
	var enemy = Enemy()
	
	// MARK: - Dungeon
	
	var isHeroAppeard = false
	var didEncounterEnemy = false
	var currentDungeonLevel = 10
	var dungeonMap: [[Tile]] = []
	var heroPosition = (row: 0, col: 0)
	
	// MARK: - Stats
	
	var heroCurrentXP = 0
	var heroMaxXP = 100
	var heroGold = 0
	
	var xpPerEnemy = 50
	var goldPerEnemy = 50
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var skillEnergyCost = 1
	
	init() {
		
	}
}
