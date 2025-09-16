import Foundation

struct GameState {

	// MARK: - Combat
	
	var isHeroTurn = true
	
	var didHeroUseBlock = false
	var didEnemyUseBlock = false
	
	var hero = Hero(
		weaponSlot: WeaponManager.weapons[0],
		armorSlot: ArmorManager.armors[0]
	)
	
	var enemy = Enemy()
	
	// MARK: - Upgrades
	
	var hpUpgradeCount = 0
	var manaUpgradeCount = 0
	var damageUpgradeCount = 0
	var defenceUpgradeCount = 0
	var spellPowerUpgradeCount = 0
	
	// MARK: - Dungeon
	
	var isHeroAppeard = false
	var didEncounterEnemy = false
	var didEncounteredBoss = false
	var dungeonLevelBeenExplored = false
	
	var currentDungeonLevel = 0
	var dungeonMap: [[Tile]] = []
	
	var heroPosition = (row: 0, col: 0)
	
	// MARK: - Stats
	
	var heroCurrentXP = 0
	var heroMaxXP = 100
	var heroGold = 0
	
	var xpPerEnemy = 34
	var goldPerEnemy = 25
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var skillEnergyCost = 1
	var spellManaCost = 10
	var blockValue = 2
	
	// MARK: - Items
	
	init() {
		
	}
}
