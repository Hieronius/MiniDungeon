import Foundation

struct GameState {

	// MARK: Combat
	
	var isHeroTurn = true
	
	var heroCurrentHP = 100
	var heroMaxHP = 100
	var heroDamage = 10
	
	var enemyCurrentHP = 100
	var enemyMaxHP = 100
	var enemyDamage = 5
	
	// MARK: - Dungeon
	
	var isHeroAppeard = false
	var didEncounterEnemy = false
	var currentDungeonLevel = 10
	var dungeonMap: [[Tile]] = []
	var heroPosition = (row: 0, col: 0)
	
	init() {
		
	}
}
