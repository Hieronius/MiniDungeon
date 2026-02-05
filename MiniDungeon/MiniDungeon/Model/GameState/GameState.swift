import SwiftUI
import SwiftData

/// Data type to define all possible state conditions of the game
@Model
class GameState {
	
	// MARK: - Navigation & Session
	
	var currentGameScreen: GameScreen = GameScreen.menu
	var previousGameScreen: GameScreen = GameScreen.menu
	
	// MARK: 3 test properties to replace gameState.currentScreen = screenName with overlay properties like "if isHeroStatsScreenOpen { buildStats() }
	
	var isHeroStatsScreenOpen = false
	var isInventoryScreenOpen = false
	var isEnemyStatsScreenOpen = false
	
	/// Property to define X offset of the FlaskView during drag operation
	/// Should be combined with @State property dragFlaskTemporaryTranslationPositionOnScreen in  MainView
	var flaskViewXOffset: CGFloat = 0
	
	/// Property to define Y offset of the FlaskView during drag operation
	/// Should be combined with @State property dragFlaskTemporaryTranslationPositionOnScreen in  MainView
	var flaskViewYOffset: CGFloat = 0
	
	var isFreshSession =  true
	
	// MARK: - Mini Games Properties
	
	/// When you hit the enemy this mini game appears
	var isCombatMiniGameIsOn = false
	
	/// When you press "defuse the trap" button this game appears
	var isTrapDefusionMiniGameIsOn = false
	
	/// When you press "Lock-Pick the chest" button this game appears
	var isLockPickingMiniGameIsOn = false
	
	// MARK: - Combat
	
	var isHeroTurn = true
	var didUserPressedEndTurnButton = false
	var comboPoints = 0
	
	var didHeroUseBlock = false
	var didEnemyUseBlock = false
	var didEnemyReceivedComboAttack = false
	
	var isCombatMiniGameSuccessful = false
	
	// MARK: - Flask, Hero, Enemy Objects
	
	var hero: Hero
	
	var enemy = Enemy()
	
	// MARK: - Upgrades
	
	/// Use this property as a flag if flask get it's level up during the fight or after getting some dark energy from the loot
	/// If this flag is true -> make Shadow Flask icon animate a little bit to reflect that user can click it to get flask level bonus from MapView or other non-action screens
	var didFlaskGetLevelUP = false
	
	var didApplySpec = false
	
	// Spec
	
	var specToDisplay: Specialisation?
	var specsToChooseAtStart: [Specialisation] = []
	var specWasSelected: Bool {
		specToDisplay != nil
	}
	
	// Shrines
	
	var shrineUpgradeToDisplay: Shrine?
	var upgradedShrines: [Shrine] = []
	var shrineUpgradeWasSelected: Bool {
		shrineUpgradeToDisplay != nil
	}
	var shadowGreedShrineBeenActivated = false
	var mysteryShrineBeenActivated = false
	
	// Hero Level Bonuses
	
	var heroLevelBonusToDisplay: HeroLevelBonus?
	var heroLevelBonusesToChoose: [HeroLevelBonus?] = []
	var selectedHeroLevelBonuses: [HeroLevelBonus] = []
	
	// Flask Level Bonuses
	
	var flaskLevelBonusToDisplay: FlaskLevelBonus?
	var flaskLevelBonusesToChoose: [FlaskLevelBonus?] = []
	var selectedFlaskLevelBonuses: [FlaskLevelBonus] = []
	
	// Flask Talants
	
	/// Upgraded Talants of the flask should contain the talant to collect combat impact during the fight by default
	/// FlaskTalantManager.minorTalants[0] - it's a Soul Collector talant
	var upgradedFlaskTalants: [FlaskTalant] = [FlaskTalantManager.minorTalants[0]]
	var flaskTalantToDisplay: FlaskTalant?
	var flaskTalantWasSelected: Bool {
		flaskTalantToDisplay != nil
	}
	
	// Used Potions
	var usedPotionsWithPermanentEffects: [Item] = []
	
	// MARK: - Dungeon
	
	var currentDungeonLevel = 0
	
	var dungeonMapInMemory: [[Tile]] = []
	
	@Transient var dungeonMap: [[Tile]] = []
//	var dungeonMap: [[Tile]] = []
	
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
	
	/// Track how much hero did gain during all game sessions to get a new talant for the Flask after each new run
	var heroMaxDarkEnergyOverall = 0
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var didUseFlaskEmpowerForOffensive = false
	var didUseFlaskEmpowerForDefensive = false
	var skillEnergyCost = 1
	var spellManaCost = 10
	var healMinValue = 3
	var healMaxValue = 6
	var minBlockValue = 3
	var maxBlockValue = 5
	
	/// Value to track how much defence value enemy got from his block so you can clean it when block ends
	var enemyBlockValueBuffer = 0
	
	/// Value to track how much defence value enemy got from his block so you can clean it when block ends
	var heroBlockValueBuffer = 0
	
	// MARK: - View Action Animations
	
	enum ActionAnimation: Codable {
		
		case gotDamage
		case gotHealing
		case usedBlock
		case none
		
		var color: Color {
			switch self {
			case .gotDamage: return .red
			case .gotHealing: return .green
			case .usedBlock: return .blue
			case .none: return .black
			}
		}
	}
	
	var currentHeroAnimation = ActionAnimation.none
	var currentEnemyAnimation = ActionAnimation.none
	
	// MARK: - Log
	
	var logMessage = "This is a test Log Message"
	
	// MARK: - Items
	
	var merchantWeaponsLoot: [Weapon: Int] = [:]
	var merchantArmorsLoot: [Armor: Int] = [:]
	var merchantInventoryLoot: [Item: Int] = [:]
	
	@Transient var lootToDisplay: [String] = []
	
	var isItemOnSale = false
	var expLootToDisplay = 0
	var goldLootToDisplay = 0
	var darkEnergyLootToDisplay = 0
	var healthPointsLootToDisplay = 0
	var manaPointsLootToDisplay = 0
	
	init(hero: Hero) {
		self.hero = hero
//		self.flask = Flask()
	}
}
