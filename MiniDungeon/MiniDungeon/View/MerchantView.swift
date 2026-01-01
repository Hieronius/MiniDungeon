import SwiftUI

// MARK: - Merchant's Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMerchant() -> some View {
		
		List {
			
			Section(header: Text("Currency")) {
				Text("Gold: \(viewModel.gameState.heroGold)")
			}
			
			if itemToDisplay != nil {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
						.bold()
					Text("Item Level: \(itemToDisplay?.itemLevel ?? 0)")
					Text("Price: \(itemToDisplay?.price ?? 0)")
					Text("Description:  \(itemToDisplay?.itemDescription ?? "")")
					Button(viewModel.gameState.isItemOnSale ? "Sell" : "Buy") {
						
						// If we successfully sold  or bough and item -> make itemToDispaly as empty label
						if viewModel.buyOrSellItem(
							onSale: viewModel.gameState.isItemOnSale,
							item: itemToDisplay
						) {
							print("clean")
							itemToDisplay = nil
						}
					}
				}
			}
			
			// MARK: - Items to Sell
			
			Section(header: Text("Items to Sell")) {
				
				ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
						itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = true
					}
				}
				
				ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
						itemToDisplay = armor
						viewModel.gameState.isItemOnSale = true
					}
				}
				
				ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
						itemToDisplay = item
						viewModel.gameState.isItemOnSale = true
					}
				}
			}
			
			// MARK: - Items to Buy
			
			Section(header: Text("Items to Buy")) {
				
				ForEach(Array(viewModel.gameState.merchantWeaponsLoot.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.merchantWeaponsLoot[weapon] ?? 0)") {
						itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = false
					}
				}
				
				ForEach(Array(viewModel.gameState.merchantArmorsLoot.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.merchantArmorsLoot[armor] ?? 0)") {
						itemToDisplay = armor
						viewModel.gameState.isItemOnSale = false
					}
				}
				
				ForEach(Array(viewModel.gameState.merchantInventoryLoot.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.merchantInventoryLoot[item] ?? 0)") {
						itemToDisplay = item
						viewModel.gameState.isItemOnSale = false
					}
				}
				
			}
			
			Section(header: Text("Navigation")) {
				Button("Go To Dungeon") {
					itemToDisplay = nil
					viewModel.goToDungeon()
					viewModel.checkForLevelUP()
				}
			}
		}
	}
}
