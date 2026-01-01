import SwiftUI

// MARK: - Inventory Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildInventory() -> some View {
		
		List {
			
			Section(header: Text("Weapon Slot")) {
				Text("\(viewModel.gameState.hero.weaponSlot?.label ?? "Empty")")
			}
			
			Section(header: Text("Armor Slot")) {
				Text("\(viewModel.gameState.hero.armorSlot?.label ?? "Empty")")
			}
			
			if itemToDisplay != nil  {
				Section(header: Text("Item Info")) {
					
					Text("Item Name: \(itemToDisplay?.label ?? "")")
						.bold()
					Text("Item Level: \(itemToDisplay?.itemLevel ?? 0)")
					Text("Description: \(itemToDisplay?.itemDescription ?? "")")
					Text("Price: \(itemToDisplay?.price ?? 0) gold")
					
					if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine {
						
						Button("Disenchant") {
							viewModel.applyEffect(for: .disenchantItem, item: itemToDisplay)
						}
							
					} else {
						
						Button("Equip/Use") {
							if viewModel.equipOrUseItem(itemToDisplay) {
								itemToDisplay = nil
							}
						}
					}
				}
			}
			
		}
		.frame(height: 450)
		
		
		List {
			
			if !viewModel.gameState.hero.weapons.isEmpty {
				Section(header: Text("Weapons")) {
					
					ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
						Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
							itemToDisplay = weapon
						}
					}
				}
			}
			
			if !viewModel.gameState.hero.armors.isEmpty {
				Section(header: Text("Armors")) {
					
					ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
						Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
							itemToDisplay = armor
						}
					}
				}
			}
			
			if !viewModel.gameState.hero.inventory.isEmpty {
				Section(header: Text("Items")) {
					
					ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
						Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
							itemToDisplay = item
						}
					}
				}
			}
			
			Section(header: Text("Navigation")) {
				
				Button("Dungeon") {
					viewModel.goToDungeon()
				}
				Button("Stats") {
					viewModel.goToHeroStats()
				}
			}
		}
	}
}
