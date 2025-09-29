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
			
			Section(header: Text("Item Info")) {
				
				Text("Item Name - \(viewModel.gameState.itemToDisplay?.label ?? "")")
				Text("Item Level - \(viewModel.gameState.itemToDisplay?.itemLevel ?? 0)")
				Text("Description - \(viewModel.gameState.itemToDisplay?.description ?? "")")
				Button("Equip/Use") {
					 viewModel.equipOrUseItem()
				}
			}
			
		}
		.frame(height: 450)
		
		
		List {
			
			Section(header: Text("Weapons")) {
				
				ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
					Button("\(weapon.label) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
						viewModel.gameState.itemToDisplay = weapon
					}
				}
			}
			
			Section(header: Text("Armors")) {
				
				ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
					Button("\(armor.label) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
						viewModel.gameState.itemToDisplay = armor
					}
				}
			}
			
			Section(header: Text("Items")) {
				
				ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
					Button("\(item.label) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
						viewModel.gameState.itemToDisplay = item
					}
				}
			}
			
			Section(header: Text("Navigation")) {
				
				Button("Go To Menu") {
					viewModel.goToMenu()
				}
			}
		}
	}
}
