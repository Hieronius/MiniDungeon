import SwiftUI

// MARK: - Inventory Screen (View)

extension MainView {
	
	@ViewBuilder
	func buildInventoryView() -> some View {
		
		// MARK: - Equiped Items
		
		List {
			
			Section(header: Text(isEnglish() ? "Weapon Slot" : "Оружие")) {
				Button {
					itemToDisplay = viewModel.gameState.hero.weaponSlot
				} label: {
					
					if isEnglish() {
						
						Text("\(viewModel.gameState.hero.weaponSlot?.labelEN ?? "Empty")")
							.foregroundStyle(viewModel.gameState.hero.weaponSlot?.rarity.color ?? .white)
							.bold()
						
					} else {
						
						Text("\(viewModel.gameState.hero.weaponSlot?.labelRU ?? "Пусто")")
							.foregroundStyle(viewModel.gameState.hero.weaponSlot?.rarity.color ?? .white)
							.bold()
					}
				}
			}
			
			Section(header: Text(isEnglish() ? "Armor Slot" : "Броня")) {
				
				Button {
					itemToDisplay = viewModel.gameState.hero.armorSlot
				} label: {
					
					if isEnglish() {
						
						Text("\(viewModel.gameState.hero.armorSlot?.labelEN ?? "Empty")")
							.foregroundStyle(viewModel.gameState.hero.armorSlot?.rarity.color ?? .white)
							.bold()
						
					} else {
						
						Text("\(viewModel.gameState.hero.armorSlot?.labelRU ?? "Пусто")")
							.foregroundStyle(viewModel.gameState.hero.armorSlot?.rarity.color ?? .white)
							.bold()
					}
				}
			}
			
			// MARK: - Selected Item Info
			
			if itemToDisplay != nil  {
				Section(header: Text(isEnglish() ? "Item Info" : "Свойства предмета")) {
					
					
					if isEnglish() {
						
						Text("Item Name: \(itemToDisplay?.labelEN ?? "")")
							.foregroundColor(itemToDisplay?.rarity.color ?? .white)
							.bold()
						Text("Item Level: \(itemToDisplay?.itemLevel ?? 0)")
						Text("Description: \(itemToDisplay?.itemDescriptionEN ?? "")")
						Text("Price: \(itemToDisplay?.price ?? 0) gold")
						
					} else {
						
						Text("Название: \(itemToDisplay?.labelRU ?? "")")
							.foregroundColor(itemToDisplay?.rarity.color ?? .white)
							.bold()
						Text("Уровень предмета: \(itemToDisplay?.itemLevel ?? 0)")
						Text("Описание: \(itemToDisplay?.itemDescriptionEN ?? "")")
						Text("Цена: \(itemToDisplay?.price ?? 0) золота")
						
					}
					
					if viewModel.gameState.didEncounterDisenchantShrine && !viewModel.gameState.dealtWithDisenchantShrine &&
						!(itemToDisplay is Item) {
						
						Button(isEnglish() ? "Disenchant" : "Распылить") {
							viewModel.applyEffect(for: .disenchantItem, item: itemToDisplay)
						}
						
					} else {
						
						if ((itemToDisplay as? Weapon ) != nil) {
							
							Button(isEnglish() ? "Equip Weapon" : "Использовать оружие") {
									if viewModel.equipOrUseItem(itemToDisplay) {
										itemToDisplay = nil
									}
								}
								
							Button(isEnglish() ? "Compare" : "Сравнить") {
									viewModel.audioManager.playSound(fileName: "click", extensionName: "mp3")
									viewModel.gameState.isArmorsStatsDifferenceOpen = false
									viewModel.gameState.isWeaponsStatsDifferenceOpen = true
								}
						}
						
						if ((itemToDisplay as? Armor ) != nil) {
							
							Button(isEnglish() ? "Equip Armor" : "Использовать броню") {
									if viewModel.equipOrUseItem(itemToDisplay) {
										itemToDisplay = nil
									}
								}
								
							Button(isEnglish() ? "Compare" : "Сравнить") {
									// viewModel.compareArmors
									viewModel.gameState.isWeaponsStatsDifferenceOpen = false
									viewModel.gameState.isArmorsStatsDifferenceOpen = true
									
								}
						}
						
						if itemToDisplay as? Item != nil {
							Button(isEnglish() ? "Use" : "Использовать") {
								if viewModel.equipOrUseItem(itemToDisplay) {
									itemToDisplay = nil
								}
							}
						}
					}
				}
			}
			
		}
		.frame(height: 500)
		
		// MARK: StatsDifferenceView
		
		.overlay(alignment: .topTrailing) {
			
			Button(isEnglish() ? "Close" : "Закрыть") {
				itemToDisplay = nil
				viewModel.goToDungeon()
			}
		}
		
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
				Section(header: Text(isEnglish() ? "Weapons" :"Оружие")) {
					
					ForEach(Array(viewModel.gameState.hero.weapons.keys)) { weapon in
						
						if isEnglish() {
							
							Button("\(weapon.labelEN) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
								itemToDisplay = weapon
							}
							.foregroundStyle(weapon.rarity.color)
							
						} else {
							
							Button("\(weapon.labelRU) - \(viewModel.gameState.hero.weapons[weapon] ?? 0)") {
								itemToDisplay = weapon
							}
							.foregroundStyle(weapon.rarity.color)
						}
					}
				}
			}
			
			// MARK: - Armors
			
			if !viewModel.gameState.hero.armors.isEmpty {
				Section(header: Text(isEnglish() ? "Armors" : "Доспехи")) {
					
					ForEach(Array(viewModel.gameState.hero.armors.keys)) { armor in
						
						if isEnglish() {
							
							Button("\(armor.labelEN) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
								itemToDisplay = armor
							}
							.foregroundStyle(armor.rarity.color)
							
						} else {
							
							Button("\(armor.labelRU) - \(viewModel.gameState.hero.armors[armor] ?? 0)") {
								itemToDisplay = armor
							}
							.foregroundStyle(armor.rarity.color)
						}
					}
				}
			}
			
			// MARK: - Other Items
			
			if !viewModel.gameState.hero.inventory.isEmpty {
				Section(header: Text(isEnglish() ? "Items" : "Предметы")) {
					
					ForEach(Array(viewModel.gameState.hero.inventory.keys)) { item in
						
						if isEnglish() {
							
							Button("\(item.labelEN) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
								itemToDisplay = item
							}
							.foregroundStyle(item.rarity.color)
							
						} else {
							
							Button("\(item.labelRU) - \(viewModel.gameState.hero.inventory[item] ?? 0)") {
								itemToDisplay = item
							}
							.foregroundStyle(item.rarity.color)
						}
					}
				}
			}
			
		}
		.frame(height: 200)
	}
}
