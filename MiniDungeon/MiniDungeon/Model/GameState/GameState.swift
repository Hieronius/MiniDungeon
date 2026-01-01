import SwiftData

/// Data type to define all possible state conditions of the game
@Model
class GameState {
	
	// MARK: - Navigation & Session
	
	var gameScreen: GameScreen = GameScreen.menu
	
	var isFreshSession =  true
	
	// MARK: - Properties to move
	
	/// When you hit the enemy this mini game appears
	var isCombatMiniGameIsOn = false
	
	/// When you press "defuse the trap" button this game appears
	var isTrapDefusionMiniGameIsOn = false
	
	/// When you press "Lock-Pick the chest" button this game appears
	var isLockPickingMiniGameIsOn = false

	// MARK: - Combat
	
	var isHeroTurn = true
	var comboPoints = 0
	
	var didHeroUseBlock = false
	var didEnemyUseBlock = false
	var didEnemyReceivedComboAttack = false
	
	var isCombatMiniGameSuccessful = false
	
	var hero: Hero
	
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
	
	var currentDungeonLevel = 0
	
	// TODO: Test property to store dungeon map in memory only when app being killed/relaunched
	var dungeonMapInMemory: [[Tile]] = []
	
	// TODO: This property causes an emence CPU overload
	// Set it as @Transient for testing
	@Transient var dungeonMap: [[Tile]] = []
	
	var heroPosition = Coordinate(row: 0, col: 0)
	
	// property to select default tile outside the grid to avoid undefined behaviour
	var tappedTilePosition = Coordinate(row: 999, col: 999)
	
	// set default tile outside the grid to avoid undefined behaviour
	var tappedTile: Tile = Tile(coordinate: Coordinate(row: 998, col: 998), type: .empty, isExplored: false, events: [.empty])
	
	var isHeroAppeared = false
	var didEncounterEnemy = false
	var didEncounteredBoss = false
	var dungeonLevelBeenExplored = false
	var didFindLootAfterFight = false
	
	/// Property to track that a User did tapped and unknown or empty tile to trigger a little animation of attempt to explore
	var didTappedUnknownTile = false
	
	/// When player tapps on empty tile and there is an enemy or loot -> change this value to true 
	var didEncounterSecretRoom = false
	
	/// Property to manage event when hero did encounter the Tile with Chest event
	var didEncounterChest = false
	
	/// Property to reflect if hero tried to open the chest or met with a chest monster
	var dealthWithChest = false
	
	/// Property to define what type of outcome from chest lock-picking hero will have
	var didChestLockPickingIsSuccess = false
	
	/// Property which might be duplicated with didChestLockPickingIsSuccess
	var isLockPickingMiniGameIsSuccess = false
	
	/// Property to detect that hero is on Restoration Shrine tile
	var didEncounterRestorationShrine = false
	
	/// Property to detect if hero got an effect of Shrine of Restoration
	var dealtWithRestorationShrine = false
	
	/// If hero stay on the "T" Tile it's mean we deal with trap
	var didEncounterTrap = false
	
	/// This property mean that we failed or succeed with the trap
	var dealtWithTrap = false
	
	/// Property needed to define what type of effect hero will get after defusion of the trap
	/// If false -> penalty, if true -> rewards
	var didTrapDefusionIsSuccess = false
	
	/// Property which might be duplicated with didTrapDefusionIsSuccess
	var isTrapDefusionMiniGameSuccessful = false
	
	/// Property to detect if hero reached the tile with "disenchant" event
	var didEncounterDisenchantShrine = false
	
	/// Property to define if user did used disenchant shrine
	var dealtWithDisenchantShrine = false
	
	// MARK: - Stats
	
	var heroGold = 0
	
	/// Resource to boost abilities/explore dungeon/rebuild the town
	var heroDarkEnergy = 0
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var skillEnergyCost = 1
	var spellManaCost = 10
	var blockValue = 5
	
	// MARK: - Log
	
	var logMessage = "This is a test Log Message"
	
	// MARK: - Items
	
	var merchantWeaponsLoot: [Weapon: Int] = [:]
	var merchantArmorsLoot: [Armor: Int] = [:]
	var merchantInventoryLoot: [Item: Int] = [:]
	
	// TODO: SECOND POTENTIAL PROBLEM WITH SWIFT DATA
	@Transient var lootToDisplay: [String] = []
	
	var isItemOnSale = false
	var expLootToDisplay = 0
	var goldLootToDisplay = 0
	var darkEnergyLootToDisplay = 0
	var healthPointsLootToDisplay = 0
	var manaPointsLootToDisplay = 0
	
	init() {
		self.hero = Hero()
	}
}
