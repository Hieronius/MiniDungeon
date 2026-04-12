import SwiftUI
import SwiftData

/// Data type to define all possible state conditions of the game
@Model
class GameState {
	
	// MARK: - Navigation & Session
	
	var isFreshSession =  true

	var currentGameScreen: GameScreen = GameScreen.menu
	var previousGameScreen: GameScreen = GameScreen.menu
	
	var currentMusic: GameMusic = GameMusic.none
	
	// MARK: 3 test properties to replace gameState.currentScreen = screenName with overlay properties like "if isHeroStatsScreenOpen { buildStats() }
	
	var isHeroStatsScreenOpen = false
	var isInventoryScreenOpen = false
	var isEnemyStatsScreenOpen = false
	var isWeaponsStatsDifferenceOpen = false
	var isArmorsStatsDifferenceOpen = false
	
	/// Property to open and close HP/MP recovery tab from the MerchantView after killing each boss
	var isStatsRecoveryViewOpen = false
	
	// MARK: - Tutorial flags
	
	/// Test property to set a predefined secret room during tutorial so user can't avoid it
	var shouldMeetPredefinedSecretRoom = true
	
	/// When user complete the demo level and kills the boss, throw an alert and set this property to false
	var shouldThrowDemoCompletionAlert = true
	
	/// Property to detect when user did complete demo level so if yes, don't run it again in next runs but run it if user dies while on Demo level
	var didEndDemoLevel = false
	
	/// Custom property for Demo level so first fight user will proceed without flask.
	var didFindFlask = false
	
	/// Test property to apply only for Demo Level enemies to make them a little bit easier
	var demoLevelEnemyPowerRatio = 0.75
	
		
	// MARK: - Mini Games Properties
	
	/// When you hit the enemy this mini game appears
	var isCombatMiniGameOn = false
	
	/// When enemy use his special attack this mini game appears
	var isShadowBallMiniGameOn = false
	
	/// When you press "defuse the trap" button this game appears
	var isTrapDefusionMiniGameIsOn = false
	
	/// When you press "Lock-Pick the chest" button this game appears
	var isLockPickingMiniGameIsOn = false
	
	/// When enemy try to land an attack this mini game pops up
	var isEvasionMiniGameOn = false
	
	/// Flag to start the combat with coin flip mini game to decide who will get turn first
	var isCoinFlipMiniGameOn = false
	
	// MARK: - Combat
	
	var isHeroTurn = true
	var didUserPressedEndTurnButton = false
	var comboPoints = 0
	
	var didHeroUseBlock = false
	var didEnemyUseBlock = false
	var didEnemyReceivedComboAttack = false
	
	var didBossFightSoundEnd = true
	
	var isCombatMiniGameSuccessful = false
	
	// MARK: - Level Perks Flags
	
	/// This flag we activate when hero get Preparation Perk
	var isPrepPerkActive = false
	
	/// By default you have 0% block value damage modifier.
	var prepPerkEffectModifier = 0.0
	
	/// This flag we put to Block ability to actually say "perk is active, block was used -> please affect next attack"
	var shouldPrepPerkAffectNextAttack = false
	
	/// This flag we use to determine did hero already used block value bonus damage at this turn or still not
	var didPrepPerkAffectCurrentTurn = false
	
	/// This flag we activate when hero get Ill Word Perk
	var isIllWordPerkActive = false
	
	/// By default you have 0% heal value damage modifier
	var illWordPerkEffectModifier = 0.0
	
	/// This flag we put to Heal ability to actually say "perk is active, heal was used -> please affect next attack"
	var shouldIllWordPerkAffectNextAttack = false
	
	/// This flag we use to determine did hero already used heal value bonus damage at this turn or still not
	var didIllWordPerkAffectCurrentTurn = false
	
	/// This flag should be active when hero got Perk of Reflection
	var isReflectionPerkActive = false
	
	/// This flag should be put to block() ability if perk is active to state that enemy should get some of it's attack damage back
	var shouldReflectAttacks = false
	
	/// By default we have 0% reflection modifier
	var reflectionPerkEffectModifier = 0.0
	
	/// This flag should be active when hero get Perk of Vampirism
	var isVampirismPerkActive = false
	
	/// By default we have 0% of vampirism
	var vampirismEffectModifier = 0.0
	
	/// This flag should be active when hero get Perk of Spell Stealing
	var isSpellStealingPerkActive = false
	
	/// By default we have 0% of Mana Vampirism (what is this perk about)
	var spellStealingEffectModifier = 0.0
	
	/// This flag should be active when hero get Perk of Fortitude
	var isFortitudePerkActive = false
	
	/// When perk of Fortitude is active and heal was used -> empower next block only
	var shouldEmpowerNextBlock = false
	
	/// An exact value you should add to a next block after using a heal ability
	var fortitudeEffectModifier = 0
	
	/// This flag should be active when hero get Perk of Resilience
	var isResiliencePerkActive = false
	
	/// An exact value you should add to a next heal ability after using block
	var resilienceEffectModifier = 0
	
	/// When perk of Resilience is active and we use block -> empower next heal only
	var shouldEmpowerNextHeal = false
	
	/// This flag should be active when hero get Armor Destruction Perk
	var isArmorDestructionPerkActive = false
	
	/// This value we should deduct enemy armor if we have Armor Destruction Perk
	var armorDestructionEffectModifier = 0
	
	/// This flag should be active when hero get Energy Surge Perk
	var isEnergySurgePerkActive = false
	
	/// By default we have 0% of perk effect activation chance
	/// We use simple Int because we compare it against Int.random(in:1...100) which is a simple representation of a chance percent
	var energySurgeEffectModifier = 0
	
	/// This flag should be active when hero get Soul Extraction Perk
	var isSoulExtractionPerkActive = false
	
	/// By default we have 0% effect
	var soulExtractionEffectModifier = 0.0
	
	/// This flag should be active when hero get Perk of Greed
	var isGreedPerkActive = false
	
	/// By default we have 0% effect of the Greed Perk
	var greedPerkEffectModifier = 0.0
	
	/// This flag should be active when hero get Crushing Blow Perk
	var isCrushingBlowPerkActive = false
	
	/// By default this value is 0
	/// We use simple Int to compare against Int.random(in: 1...) simple chance roll
	var crushingBlowEffectModifier = 0
	
	/// This flag should be active when hero get Perk of Swiftness
	var isSwiftnessPerkActive = false
	
	/// This value is 0 by default and should be a simple Int to compare against Int.random(in: 1...100)
	var swiftnessPerkEffectModifier = 0
	
	/// This flag should be active when hero get Health Grow Perk
	var isHealthGrowPerkActive = false
	
	/// By default it's 0 as simple Int type and should increase hero max hp by this value
	var healthGrowEffectModifier = 0
	
	/// This flag should be false as default so if perk is active, condition for use were met and the effect was applied, turn this flag to true
	/// When the combat ends this flag should be false again
	var wasHealthGrowPerkEffectUsed = false
	
	/// This flag should be active when hero get Blood Bath Perk
	var isBloodBathPerkActive = false
	
	/// By default it's 0 as simple Int type and should be increase hero max hp by this value
	var bloodBathPerkEffectModifier = 0
	
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
	
	// Level Perks
	
	var levelPerkToDisplay: LevelPerk?
	var levelPerksToChoose: [LevelPerk?] = []
	var selectedLevelPerks: [LevelPerk] = []
	
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
	
	var currentDungeonLevel = 1
	
	var dungeonMapInMemory: [[Tile]] = []
	
	@Transient var dungeonMap: [[Tile]] = []
	
	var heroPosition = Coordinate(row: 0, col: 0)
	
	// property to select default tile outside the grid to avoid undefined behaviour
	var tappedTilePosition = Coordinate(row: 999, col: 999)
	
	// set default tile outside the grid to avoid undefined behaviour
	var tappedTile: Tile = Tile(coordinate: Coordinate(row: 998, col: 998), type: .empty, isExplored: false, events: [.empty])
	
	var didHeroAppear = false
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
	
	var runs = 0
	
	var heroGold = 0
	
	/// Resource to boost abilities/explore dungeon/rebuild the town
	var heroDarkEnergy = 0
	
	/// Track how much hero did gain during all game sessions to get a new talant for the Flask after each new run
	var heroMaxDarkEnergyOverall = 0
	
	var battlesWon = 0
	
	// MARK: - Abilities
	
	var didUseFlaskEmpowerForOffensive = false
	var didUseFlaskEmpowerForDefensive = false
	var specialSkillEnergyCost = 2
	var ultimateSkillEnergyCost = 3
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
