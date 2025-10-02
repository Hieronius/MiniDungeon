import Foundation

struct GameState {
	
	// MARK: - Properties to move
	
	var isMiniGameOn = false

	// MARK: - Combat
	
	var isHeroTurn = true
	
	var didHeroUseBlock = false
	var didEnemyUseBlock = false
	
	var isMiniGameSuccessful = false
	
	var hero = Hero()
	
	var enemy = Enemy()
	
	// MARK: - Upgrades
	
	var hpUpgradeCount = 0
	var manaUpgradeCount = 0
	var damageUpgradeCount = 0
	var defenceUpgradeCount = 0
	var spellPowerUpgradeCount = 0
	var didApplySpec = false
	var specToDisplay: Specialisation?
	var specsToChooseAtStart: [Specialisation] = []
	
	// MARK: - Dungeon
	
	var isHeroAppeard = false
	var didEncounterEnemy = false
	var didEncounteredBoss = false
	var dungeonLevelBeenExplored = false
	var didFindLootAfterFight = false
	
	var currentDungeonLevel = 0
	var dungeonMap: [[Tile]] = []
	
	var heroPosition = (row: 0, col: 0)
	
	// MARK: - Stats
	
//	var heroCurrentXP = 0
//	var heroMaxXP = 150
	var heroGold = 0
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var skillEnergyCost = 1
	var spellManaCost = 10
	var blockValue = 2
	
	// MARK: - Log
	
	var logMessage = "This is a test Log Message"
	
	// MARK: - Items
	
	var merchantWeaponsLoot: [Weapon: Int] = [:]
	var merchantArmorsLoot: [Armor: Int] = [:]
	var merchantInventoryLoot: [Item: Int] = [:]
	
	var lootToDisplay: [String] = []
	var itemToDisplay: (any ItemProtocol)?
	
	var wasItemSelected: Bool {
		itemToDisplay != nil
	}
	var isItemOnSale = false
	var expLootToDisplay = 0
	var goldLootToDisplay = 0
	
	init() {
		
	}
}
