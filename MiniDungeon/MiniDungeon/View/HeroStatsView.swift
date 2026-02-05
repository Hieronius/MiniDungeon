import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	/// Try to collect all stats/skills and such into structs inside Hero class so you can use something like List(gameState.hero.Stats.\.self
	@ViewBuilder
	func buildHeroStatsView() -> some View {
		
		List {
			
			Section(header: Text("Hero Stats")) {
				
				Text("LVL: \(viewModel.gameState.hero.heroLevel)")
				Text("Experience: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
				//				Text("Specialisation: \(viewModel.gameState.hero.specialisation?.name ?? "")")
				Text("Health: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
				Text("Mana: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
				Text("Energy: \(viewModel.gameState.hero.currentEnergy)/\(viewModel.gameState.hero.maxEnergy)")
				Text("Spell Power: \(viewModel.gameState.hero.spellPower)")
			}
			
			Section(header: Text("Flask Stats")) {
				
				Text("LVL: \(viewModel.gameState.hero.flask.level)")
				Text("Experience: \(viewModel.gameState.hero.flask.currentXP)/\(viewModel.gameState.hero.flask.expToLevelUP)")
				Text("Flask Charges: \(viewModel.gameState.hero.flask.currentCharges)/\(viewModel.gameState.hero.flask.currentMaxCharges)")
			}
			
			Section(header: Text("Combat")) {
				Text("Damage: \(viewModel.gameState.hero.minDamage) - \(viewModel.gameState.hero.maxDamage)")
				Text("Defence: \(viewModel.gameState.hero.defence)")
				Text("Crit Chance: \(viewModel.gameState.hero.critChance)%")
				Text("Hit Chance: \(viewModel.gameState.hero.hitChance)%")
			}
			
			Section(header: Text("Utility")) {
				Text("Gold: \(viewModel.gameState.heroGold)")
				Text("Current Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
				Text("Dark Energy Overall: \(viewModel.gameState.heroMaxDarkEnergyOverall)")
			}
			
			if viewModel.gameState.hero.weaponSlot != nil {
				Section(header: Text("Equiped Weapon Slot Effects")) {
					Text("\(viewModel.gameState.hero.weaponSlot!.label): \(viewModel.gameState.hero.weaponSlot!.itemDescription)")
				}
			}
			
			if viewModel.gameState.hero.armorSlot != nil {
				Section(header: Text("Equiped Armor Slot Effects")) {
					Text("\(viewModel.gameState.hero.armorSlot!.label): \(viewModel.gameState.hero.armorSlot!.itemDescription)")
				}
			}
			
			// MARK: Used Potions should be put here
			
			if !viewModel.gameState.usedPotionsWithPermanentEffects.isEmpty {
				Section(header: Text("Permanent Potion Effects")) {
					
					ForEach(viewModel.gameState.usedPotionsWithPermanentEffects) { effect in
						
						Text("\(effect.label): \(effect.itemDescription)")
					}
				}
			}
			
			if !viewModel.gameState.selectedHeroLevelBonuses.isEmpty {
				Section(header: Text("Active Hero Level Bonuses")) {
					
					ForEach(viewModel.gameState.selectedHeroLevelBonuses) { bonus in
						
						Text("\(bonus.name): \(bonus.bonusDescription)")
					}
				}
			}
			
			if !viewModel.gameState.selectedFlaskLevelBonuses.isEmpty {
				Section(header: Text("Active Flask Level Bonuses")) {
					
					ForEach(viewModel.gameState.selectedFlaskLevelBonuses) { bonus in
						
						Text("\(bonus.name): \(bonus.bonusDescription)")
					}
				}
			}
			
			if !viewModel.gameState.upgradedShrines.isEmpty {
				Section(header: Text("Active Shrines Effects")) {
					
					ForEach(viewModel.gameState.upgradedShrines) { shrine in
						
						Text("\(shrine.name): \(shrine.shrineDescription)")
					}
				}
			}
			
			if !viewModel.gameState.upgradedFlaskTalants.isEmpty {
				Section(header: Text("Active Flask Talants Effects")) {
					
					ForEach(viewModel.gameState.upgradedFlaskTalants) { talant in
						
						Text("\(talant.name): \(talant.flaskTalantDescription)")
					}
				}
			}
		}
		.frame(height: 650)
		
		List {
			
			Section(header: Text("Navigation")) {
				
				Button("Dungeon") {
					viewModel.goToDungeon()
				}
//				Button("Inventory") {
//					viewModel.goToInventory()
//				}
			}
		}
	}
}
