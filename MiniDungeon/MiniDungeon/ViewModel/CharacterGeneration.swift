import SwiftUI

extension MainViewModel {
	
	func generateEnemy() -> Enemy {
		
		// Modifer for level difficulty
		let level = gameState.currentDungeonLevel + 1
		
		// Modifer to define how often we might encouner elite
		let eliteEnemySpawnChance = 5
		
		// Modifer to define how often we might encouner final boss
		// Should be once per level
		let finalBossSpawnChance = 1
		
		let hp = Int.random(in: 50...100)
		let mp = Int.random(in: 10...50)
		let energy = 5
		let damage = Int.random(in: 5...10)
		let spellPower = Int.random(in: 5...10)
		let defence = Int.random(in: 0...3)
		
		return Enemy(
			enemyCurrentHP: hp,
			enemyMaxHP: hp,
			currentMana: mp,
			maxMana: mp,
			currentEnergy: energy,
			maxEnergy: energy,
			enemyDamage: damage,
			defence: defence,
			spellPower: spellPower
		)
	}
}
