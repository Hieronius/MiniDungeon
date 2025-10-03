import SwiftUI

// MARK: - Merchant's Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMerchant() -> some View {
		
		/*
		 
		 Souls / gold count
		 
		 Items to sell
		 
		 Items to buy
		 */
		
		List {
			
			Section(header: Text("Currency")) {
				Text("Gold: \(viewModel.gameState.heroGold)")
			}
			
			if viewModel.gameState.wasItemSelected {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(viewModel.gameState.itemToDisplay?.label ?? "")")
					Text("Item Level: \(viewModel.gameState.itemToDisplay?.itemLevel ?? 0)")
					Text("Price: \(viewModel.gameState.itemToDisplay?.price ?? 0)")
					Text("Description:  \(viewModel.gameState.itemToDisplay?.description ?? "")")
					Button(viewModel.gameState.isItemOnSale ? "Sell" : "Buy") {
						viewModel.buyOrSellItem(
							onSale: viewModel.gameState.isItemOnSale
						)
					}
				}
			}
			
			Section(header: Text("Items to Sell")) {
				
				ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
						viewModel.gameState.itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = true
					}
				}
				
				ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
						viewModel.gameState.itemToDisplay = armor
						viewModel.gameState.isItemOnSale = true
					}
				}
				
				ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
						viewModel.gameState.itemToDisplay = item
						viewModel.gameState.isItemOnSale = true
					}
				}
			}
			
			Section(header: Text("Items to Buy")) {
				
				ForEach(Array(viewModel.gameState.merchantWeaponsLoot.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.merchantWeaponsLoot[weapon] ?? 0)") {
						viewModel.gameState.itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = false
					}
				}
				
				ForEach(Array(viewModel.gameState.merchantArmorsLoot.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.merchantArmorsLoot[armor] ?? 0)") {
						viewModel.gameState.itemToDisplay = armor
						viewModel.gameState.isItemOnSale = false
					}
				}
				
				ForEach(Array(viewModel.gameState.merchantInventoryLoot.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.merchantInventoryLoot[item] ?? 0)") {
						viewModel.gameState.itemToDisplay = item
						viewModel.gameState.isItemOnSale = false
					}
				}
				
			}
			
			Section(header: Text("Navigation")) {
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
				Button("Go To Dungeon") {
					viewModel.goToDungeon()
				}
			}
		}
	}
}
