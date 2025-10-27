import SwiftUI

// MARK: - Hero Stats Screen (View)

extension MainView {
	
	/// Try to collect all stats/skills and such into structs inside Hero class so you can use something like Lise(gameState.hero.Stats.\.self
	@ViewBuilder
	func buildHeroStats() -> some View {
		
		List {
			
			Section(header: Text("Hero Stats")) {
				
				Text("LVL: \(viewModel.gameState.hero.heroLevel)")
				Text("Experience: \(viewModel.gameState.hero.currentXP)/\(viewModel.gameState.hero.maxXP)")
				Text("Specialisation: \(viewModel.gameState.hero.specialisation?.name ?? "")")
				Text("Health: \(viewModel.gameState.hero.currentHP)/\(viewModel.gameState.hero.maxHP)")
				Text("Mana: \(viewModel.gameState.hero.currentMana)/\(viewModel.gameState.hero.maxMana)")
				Text("Energy: \(viewModel.gameState.hero.currentEnergy)/\(viewModel.gameState.hero.maxEnergy)")
				Text("Spell Power: \(viewModel.gameState.hero.spellPower)")
			}
			
			Section(header: Text("Combat")) {
				Text("Damage: \(viewModel.gameState.hero.minDamage) - \(viewModel.gameState.hero.maxDamage)")
				Text("Defence: \(viewModel.gameState.hero.defence)")
				Text("Crit Chance: \(viewModel.gameState.hero.critChance)%")
				Text("Hit Chance: \(viewModel.gameState.hero.hitChance)%")
			}
			
			Section(header: Text("Utility")) {
				Text("Gold: \(viewModel.gameState.heroGold)")
				Text("Dark Energy: \(viewModel.gameState.heroDarkEnergy)")
			}
			
			if !viewModel.gameState.upgradedShrines.isEmpty {
				Section(header: Text("Active Shrines")) {
					
					ForEach(viewModel.gameState.upgradedShrines) { shrine in
						
						Text("\(shrine.description)")
					}
				}
			}
			
			Section(header: Text("Navigation")) {
				Button("Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Inventory") {
					viewModel.goToInventory()
				}
			}
		}
	}
}
