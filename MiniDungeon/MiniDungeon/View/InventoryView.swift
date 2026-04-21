import SwiftUI

// MARK: - Inventory Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildInventoryView() -> some View {
		
		// MARK: - Equiped Items
		
		List {
			
			Section(header: Text("Weapon Slot")) {
				Button {
					itemToDisplay = viewModel.gameState.hero.weaponSlot
				} label: {
					Text("\(viewModel.gameState.hero.weaponSlot?.label ?? "Empty")")
						.foregroundStyle(viewModel.gameState.hero.weaponSlot?.rarity.color ?? .white)
						.bold()
				}
			}
			
			Section(header: Text("Armor Slot")) {
				
				Button {
					itemToDisplay = viewModel.gameState.hero.armorSlot
				} label: {
					Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
						.foregroundStyle(viewModel.gameState.hero.armorSlot?.rarity.color ?? .white)
						.bold()
				}
			}
			
			// MARK: - Selected Item Info
			
			if itemToDisplay != nil  {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
						.foregroundColor(itemToDisplay?.rarity.color ?? .white)
						.bold()
					Text("Item Level: \(itemToDisplay?.itemLevel ?? 0)")
					Text("Description: \(itemToDisplay?.itemDescription ?? "")")
					Text("Price: \(itemToDisplay?.price ?? 0) gold")
					
					if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine &&
						!(itemToDisplay is Item) {
						
						Button("Disenchant") {
							viewModel.applyEffect(for: .disenchantItem, item: itemToDisplay)
						}
						
					} else {
						
						if ((itemToDisplay as? Weapon ) != nil) {
							
								Button("Equip Weapon") {
									if viewModel.equipOrUseItem(itemToDisplay) {
										itemToDisplay = nil
									}
								}
								
								Button("Compare") {
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
									viewModel.gameState.isArmorsStatsDifferenceOpen = false
									viewModel.gameState.isWeaponsStatsDifferenceOpen = true
									print("Did compare Weapons")
								}
						}
						
						if ((itemToDisplay as? Armor ) != nil) {
							
								Button("Equip Armor") {
									if viewModel.equipOrUseItem(itemToDisplay) {
										itemToDisplay = nil
									}
								}
								
								Button("Compare") {
									// viewModel.compareArmors
									viewModel.gameState.isWeaponsStatsDifferenceOpen = false
									viewModel.gameState.isArmorsStatsDifferenceOpen = true
									print("Did compare Armors")
									
								}
						}
						
						if itemToDisplay as? Item != nil {
							Button("Use") {
								if viewModel.equipOrUseItem(itemToDisplay) {
									itemToDisplay = nil
								}
							}
						}
					}
				}
			}
			
		}
		.frame(height: 450)
		
		// MARK: StatsDifferenceView
		
		.overlay() {
			if viewModel.gameState.isWeaponsStatsDifferenceOpen {
				buildItemsStatsDifferenceTable(forStats: viewModel.compareSelectedItemWithEquipedOne(itemToDisplay))
					.frame(height: 450)
			} else if
				viewModel.gameState.isArmorsStatsDifferenceOpen {
				buildItemsStatsDifferenceTable(forStats: viewModel.compareSelectedItemWithEquipedOne(itemToDisplay))
					.frame(height: 450)
			}
		}
		
		List {
			
			// MARK: - Weapons
			
			if !viewModel.gameState.hero.weapons.isEmpty {
				Section(header: Text("Weapons")) {
					
					ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
						Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
							itemToDisplay = weapon
						}
						.foregroundStyle(weapon.rarity.color)
					}
				}
			}
			
			// MARK: - Armors
			
			if !viewModel.gameState.hero.armors.isEmpty {
				Section(header: Text("Armors")) {
					
					ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
						Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
							itemToDisplay = armor
						}
						.foregroundStyle(armor.rarity.color)
					}
				}
			}
			
			// MARK: - Other Items
			
			if !viewModel.gameState.hero.inventory.isEmpty {
				Section(header: Text("Items")) {
					
					ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
						Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
							itemToDisplay = item
						}
						.foregroundStyle(item.rarity.color)
					}
				}
			}
			
		}
		.frame(height: 250)
		
		List {
			// MARK: - Navigation
			
			Section(header: Text("Navigation")) {
				
				Button("Dungeon") {
					itemToDisplay = nil
					viewModel.goToDungeon()
				}
			}
		}
	}
}
