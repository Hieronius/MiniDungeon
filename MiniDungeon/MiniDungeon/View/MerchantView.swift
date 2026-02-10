import SwiftUI

// MARK: - Merchant's Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMerchantView() -> some View {
		
		List {
			
			Section(header: Text("Currency")) {
				Text("Gold: \(viewModel.gameState.heroGold)")
			}
			
			if itemToDisplay != nil {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
						.bold()
					Text("Item Level: \(itemToDisplay?.itemLevel ?? 0)")
					Text(viewModel.gameState.isItemOnSale ? "Price to Sell: \((itemToDisplay?.price ?? 0) / 4)" : "Price to Buy: \(itemToDisplay?.price ?? 0)")
					//					Text("Price to Sell: \((itemToDisplay?.price ?? 0) / 4)")
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
					if itemToDisplay as? Weapon != viewModel.gameState.hero.weaponSlot && ((itemToDisplay as? Weapon) != nil) {
						
						Button("Compare") {
							// viewModel.compareWeapons()
							viewModel.gameState.isArmorsStatsDifferenceOpen = false
							viewModel.gameState.isWeaponsStatsDifferenceOpen = true
						}
					}
					
					if itemToDisplay as? Armor != viewModel.gameState.hero.armorSlot && ((itemToDisplay as? Armor) != nil) {
						
						Button("Compare") {
							// viewModel.compareArmors
							viewModel.gameState.isWeaponsStatsDifferenceOpen = false
							viewModel.gameState.isArmorsStatsDifferenceOpen = true
							
						}
					}
				}
			}
		}
		.frame(height: 350)
		
		.overlay() {
			if viewModel.gameState.isWeaponsStatsDifferenceOpen {
				buildItemsStatsDifferenceTable(forStats: viewModel.compareSelectedItemWithEquipedOne(itemToDisplay))
					.frame(height: 350)
			} else if
				viewModel.gameState.isArmorsStatsDifferenceOpen {
				buildItemsStatsDifferenceTable(forStats: viewModel.compareSelectedItemWithEquipedOne(itemToDisplay))
					.frame(height: 350)
			}
		}
			
			// MARK: - Items to Sell
			
		List {
			
			Section(header: Text("Weapon Slot")) {
				//				Text("\(viewModel.gameState.hero.weaponSlot?.label ?? "Empty")")
				Button {
					itemToDisplay = viewModel.gameState.hero.weaponSlot
					viewModel.gameState.isItemOnSale = true
				} label: {
					Text("\(viewModel.gameState.hero.weaponSlot?.label ?? "Empty")")
				}
			}
			
			Section(header: Text("Armor Slot")) {
				//				Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
				
				Button {
					itemToDisplay = viewModel.gameState.hero.armorSlot
					viewModel.gameState.isItemOnSale = true
				} label: {
					Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
				}
			}
			
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
		}
		.frame(height: 250)
		List {
			
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
