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
	
	var didApplySpec = false
	
	var specToDisplay: Specialisation?
	var specsToChooseAtStart: [Specialisation] = []
	var specWasSelected: Bool {
		specToDisplay != nil
	}
	
	var shrineUpgradeToDisplay: Shrine?
	var upgradedShrines: [Shrine] = []
	var shrineUpgradeWasSelected: Bool {
		shrineUpgradeToDisplay != nil
	}
	var shadowGreedShrineBeenActivated = false
	var mysteryShrineBeenActivated = false
	
	var levelBonusToDisplay: LevelBonus?
	var levelBonusesToChoose: [LevelBonus?] = []
	
	var levelBonusesRarities: [Rarity] = []
	
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
	
	var heroGold = 0
	
	/// Resource to boost abilities/explore dungeon/rebuild the town
	var heroDarkEnergy = 10
	
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
	var darkEnergyToDisplay = 0
	
	init() {
		
	}
}
