import SwiftUI

// MARK: - Merchant's Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildMerchantView() -> some View {
		
		List {
			
			if !viewModel.gameState.isStatsRecoveryViewOpen {
				
				Section(header: Text("Currency")) {
					Text("Gold: \(viewModel.gameState.heroGold)")
				}
			}
			
			if itemToDisplay != nil {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
						.foregroundStyle(itemToDisplay?.rarity.color ?? .white)
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
		
		// MARK: - Stats Difference View
		
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
						.foregroundStyle(viewModel.gameState.hero.weaponSlot?.rarity.color ?? .white)
						.bold()
				}
			}
			
			Section(header: Text("Armor Slot")) {
				Button {
					itemToDisplay = viewModel.gameState.hero.armorSlot
					viewModel.gameState.isItemOnSale = true
				} label: {
					Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
						.foregroundStyle(viewModel.gameState.hero.armorSlot?.rarity.color ?? .white)
						.bold()
				}
			}
			
			Section(header: Text("Items to Sell")) {
				
				ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
						itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = true
					}
					.foregroundStyle(weapon.rarity.color)
				}
				
				ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
						itemToDisplay = armor
						viewModel.gameState.isItemOnSale = true
					}
					.foregroundStyle(armor.rarity.color)
				}
				
				ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
						itemToDisplay = item
						viewModel.gameState.isItemOnSale = true
					}
					.foregroundStyle(item.rarity.color)
				}
			}
			
			// MARK: - Items to Buy
			
			Section(header: Text("Items to Buy")) {
				
				ForEach(Array(viewModel.gameState.merchantWeaponsLoot.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.merchantWeaponsLoot[weapon] ?? 0)") {
						itemToDisplay = weapon
						viewModel.gameState.isItemOnSale = false
					}
					.foregroundStyle(weapon.rarity.color)
				}
				
				ForEach(Array(viewModel.gameState.merchantArmorsLoot.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.merchantArmorsLoot[armor] ?? 0)") {
						itemToDisplay = armor
						viewModel.gameState.isItemOnSale = false
					}
					.foregroundStyle(armor.rarity.color)
				}
				
				ForEach(Array(viewModel.gameState.merchantInventoryLoot.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.merchantInventoryLoot[item] ?? 0)") {
						itemToDisplay = item
						viewModel.gameState.isItemOnSale = false
					}
					.foregroundStyle(item.rarity.color)
				}
				
			}
		}
		.frame(height: 250)
		
		.overlay(alignment: .bottom) {
			
			if viewModel.gameState.isStatsRecoveryViewOpen {
				
				// THIS VIEW SERVS AS PART OF MAINVIEW SO YOU DON'T NEED TO USE VIEWBUILDER UNTIL YOU SURE THE VIEW CONFORMS TO VIEW AND RETURNS A VIEW
				
				StatsRecoveryView(
					currentHPValue: viewModel.gameState.hero.currentHP,
					maxHPValue: viewModel.gameState.hero.maxHP,
					currentMPValue: viewModel.gameState.hero.currentMana,
					maxMPValue: viewModel.gameState.hero.maxMana,
					currentGoldValue: viewModel.gameState.heroGold,
					audioManager: viewModel.audioManager
					
					// closure result from the view with new hp/mp/gold values to update by view model
				) { result in
					viewModel
						.handleStatsRecoveryUpdate(from: result)
				}
									   
			}
		}
		
		List {
			
			if !viewModel.gameState.isStatsRecoveryViewOpen {
			
			Section(header: Text("Navigation")) {
					
					Button("Restore HP/MP") {
						viewModel.gameState.isStatsRecoveryViewOpen = true
					}
					
					Button("Go To Dungeon") {
						itemToDisplay = nil
						viewModel.goToDungeon()
						viewModel.checkForHeroLevelUP()
					}
				}
			}
		}
	}
}
