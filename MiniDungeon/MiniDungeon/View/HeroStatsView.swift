import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	/// Try to collect all stats/skills and such into structs inside Hero class so you can use something like List(gameState.hero.Stats.\.self
	@ViewBuilder
	func buildHeroStatsView() -> some View {
		
		List {
			
			// MARK: - Dungeon Stats
			
			Section(header: Text(isEnglish() ? "Dungeon" : "Подземелье")) {
				
				if isEnglish() {
					
					Text("Runs: \(viewModel.gameState.runs)")
					Text("Dungeon Level: \(viewModel.gameState.currentDungeonLevel)")
					Text("Rooms explored: \(viewModel.countMapRooms().0)/\(viewModel.countMapRooms().1)")
					Text("Battles won: \(viewModel.gameState.battlesWon)")
					
				} else {
					
					Text("Забеги: \(viewModel.gameState.runs)")
					Text("Уровень подземелья: \(viewModel.gameState.currentDungeonLevel)")
					Text("Комнат открыто: \(viewModel.countMapRooms().0)/\(viewModel.countMapRooms().1)")
					Text("Битв выиграно: \(viewModel.gameState.battlesWon)")
				}
			}
			
			// MARK: - Hero Main Stats
			
			Section(header: Text(isEnglish() ? "Hero Stats" : "Характеристики Героя")) {
				
				if isEnglish() {
					
					Text("Level: \(viewModel.gameState.hero.heroLevel)")
					Text("Experience: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
					Text("Health: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
					Text("Mana: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
					Text("Energy: \(viewModel.gameState.hero.currentEnergy)/\(viewModel.gameState.hero.maxEnergy)")
					
				} else {
					
					Text("Уровень: \(viewModel.gameState.hero.heroLevel)")
					Text("Опыт: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
					Text("Здоровье: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
					Text("Мана: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
					Text("Очки действия: \(viewModel.gameState.hero.currentEnergy)/\(viewModel.gameState.hero.maxEnergy)")
				}
			}
			
			// MARK: - Flask Main Stats
			
			Section(header: Text(isEnglish() ? "Flask Stats" : "Характеристики Фляги")) {
				
				if isEnglish() {
					
					Text("Level: \(viewModel.gameState.hero.flask.level)")
					Text("Experience: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
					Text("Flask Charges: \(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges)")
					
				} else {
					
					Text("Уровень: \(viewModel.gameState.hero.flask.level)")
					Text("Опыт: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
					Text("Заряды: \(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges)")
				}
			}
			
			// MARK: - Hero Combat Stats
			
			Section(header: Text(isEnglish() ? "Combat" : "Бой")) {
				
				if isEnglish() {
					
					Text("Damage: \(viewModel.gameState.hero.minDamage) - \(viewModel.gameState.hero.maxDamage)")
					Text("Defence: \(viewModel.gameState.hero.defence)")
					Text("Crit Chance: \(viewModel.gameState.hero.critChance)%")
					Text("Hit Chance: \(viewModel.gameState.hero.hitChance)%")
					Text("Spell Power: \(viewModel.gameState.hero.spellPower)")
					
				} else {
					
					Text("Урон: \(viewModel.gameState.hero.minDamage) - \(viewModel.gameState.hero.maxDamage)")
					Text("Броня: \(viewModel.gameState.hero.defence)")
					Text("Шанс на критический эффект: \(viewModel.gameState.hero.critChance)%")
					Text("Шанс на попадение по противнику: \(viewModel.gameState.hero.hitChance)%")
					Text("Сила заклинаний: \(viewModel.gameState.hero.spellPower)")
				}
			}
			
			// MARK: - Utility
			
			Section(header: Text(isEnglish() ? "Currency" : "Валюта")) {
				
				if isEnglish() {
					
					Text("Gold: \(viewModel.gameState.heroGold)")
					Text("Current Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
					Text("Dark Energy Overall: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
					
				} else {
					
					Text("Золото: \(viewModel.gameState.heroGold)")
					Text("Текущее количество темной энергии: \(viewModel.gameState.heroDarkEnergy)")
					Text("Получено темной энергии всего: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
				}
			}
			
			// MARK: - Current Weapon Slot
			
			if viewModel.gameState.hero.weaponSlot != nil {
				Section(header: Text(isEnglish() ? "Equiped Weapon Slot Effects" : "Эффекты экипированного оружия")) {
					
					if isEnglish() {
						
						Text("\(viewModel.gameState.hero.weaponSlot!.labelEN): \(viewModel.gameState.hero.weaponSlot!.itemDescriptionEN)")
						
					} else {
						
						Text("\(viewModel.gameState.hero.weaponSlot!.labelRU): \(viewModel.gameState.hero.weaponSlot!.itemDescriptionRU)")
					}
				}
			}
			
			// MARK: - Current Armor Slot
			
			if viewModel.gameState.hero.armorSlot != nil {
				Section(header: Text(isEnglish() ? "Equiped Armor Slot Effects" : "Эффекты экипированной брони")) {
					
					if isEnglish() {
						
						Text("\(viewModel.gameState.hero.armorSlot!.labelEN): \(viewModel.gameState.hero.armorSlot!.itemDescriptionEN)")
						
					} else {
						
						Text("\(viewModel.gameState.hero.armorSlot!.labelRU): \(viewModel.gameState.hero.armorSlot!.itemDescriptionRU)")
					}
				}
			}
			
			// MARK: Used Potions should be put here
			
			if !viewModel.gameState.usedPotionsWithPermanentEffects.isEmpty {
				Section(header: Text(isEnglish() ? "Permanent Potion Effects" : "Постоянные эффекты зелий")) {
					
					ForEach(viewModel.gameState.usedPotionsWithPermanentEffects) { effect in
						
						if isEnglish() {
							Text("\(effect.labelEN): \(effect.itemDescriptionEN)")
						} else {
							Text("\(effect.labelRU): \(effect.itemDescriptionRU)")
						}
					}
				}
			}
			
			// MARK: - Hero Level Bonuses
			
			if !viewModel.gameState.selectedHeroLevelBonuses.isEmpty {
				
				Section(header: Text(isEnglish() ? "Active Hero Level Bonuses" : "Активные Бонусы Уровня Героя")) {
					
					ForEach(viewModel.gameState.selectedHeroLevelBonuses) { bonus in
						
						if isEnglish() {
							Text("\(bonus.nameEN): \(bonus.bonusDescriptionEN)")
								.foregroundStyle(bonus.rarity.color)
						} else {
							Text("\(bonus.nameRU): \(bonus.bonusDescriptionRU)")
								.foregroundStyle(bonus.rarity.color)
						}
					}
				}
			}
			
			// MARK: - Level Perks
			
			if !viewModel.gameState.selectedLevelPerks.isEmpty {
				
				Section(header: Text(isEnglish() ? "Active Level Perks" : "Активные Перки Уровня")) {
					
					ForEach(viewModel.gameState.selectedLevelPerks) { perk in
						
						if isEnglish() {
							Text("\(perk.nameEN): \(perk.perkDescriptionEN)")
								.foregroundStyle(perk.rarity.color)
						} else {
							Text("\(perk.nameRU): \(perk.perkDescriptionRU)")
								.foregroundStyle(perk.rarity.color)
						}
					}
				}
			}
			
			// MARK: - Flask Level Bonuses
			
			if !viewModel.gameState.selectedFlaskLevelBonuses.isEmpty {
				
				Section(header: Text(isEnglish() ? "Active Flask Level Bonuses" : "Активные Таланты Фляги")) {
					
					ForEach(viewModel.gameState.selectedFlaskLevelBonuses) { bonus in
						
						if isEnglish() {
							Text("\(bonus.nameEN): \(bonus.bonusDescriptionEN)")
						} else {
							Text("\(bonus.nameRU): \(bonus.bonusDescriptionRU)")
						}
					}
				}
			}
			
			if !viewModel.gameState.upgradedShrines.isEmpty {
				Section(header: Text(isEnglish() ? "Active Shrines Effects" : "Активные Эффекты Алтарей")) {
					
					ForEach(viewModel.gameState.upgradedShrines) { shrine in
						
						if isEnglish() {
							Text("\(shrine.nameEN): \(shrine.shrineDescriptionEN)")
						} else {
							Text("\(shrine.nameEN): \(shrine.shrineDescriptionRU)")
						}
					}
				}
			}
			
			if !viewModel.gameState.upgradedFlaskTalants.isEmpty {
				Section(header: Text(isEnglish() ? "Active Flask Talants Effects" : "Активные Таланты Фляги")) {
					
					ForEach(viewModel.gameState.upgradedFlaskTalants) { talant in
						
						if isEnglish() {
							Text("\(talant.nameEN): \(talant.flaskTalantDescriptionEN)")
						} else {
							Text("\(talant.nameRU): \(talant.flaskTalantDescriptionRU)")
						}
					}
				}
			}
		}
		.frame(height: 700)
		
		.overlay(alignment: .topTrailing) {

			Button(isEnglish() ? "Close" : "Закрыть") {
				viewModel.goToDungeon()
			}
		}
	}
}
