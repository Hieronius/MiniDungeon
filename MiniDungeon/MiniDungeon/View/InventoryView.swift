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
				}
			}
			
			Section(header: Text("Armor Slot")) {
				
				Button {
					itemToDisplay = viewModel.gameState.hero.armorSlot
				} label: {
					Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
				}
			}
			
			// MARK: - Selected Item Info
			
			if itemToDisplay != nil  {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
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
						
						if itemToDisplay as? Weapon != viewModel.gameState.hero.weaponSlot && ((itemToDisplay as? Weapon) != nil) {
							
							Button("Equip") {
								if viewModel.equipOrUseItem(itemToDisplay) {
									itemToDisplay = nil
								}
							}
						}
						
						if itemToDisplay as? Armor != viewModel.gameState.hero.armorSlot && ((itemToDisplay as? Armor) != nil) {
							Button("Equip") {
								if viewModel.equipOrUseItem(itemToDisplay) {
									itemToDisplay = nil
								}
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
		
		List {
			
			// MARK: - Weapons
			
			if !viewModel.gameState.hero.weapons.isEmpty {
				Section(header: Text("Weapons")) {
					
					ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
						Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
							itemToDisplay = weapon
						}
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
				//				Button("Stats") {
				//					itemToDisplay = nil
				//					viewModel.goToHeroStats()
				//				}
			}
		}
	}
}
