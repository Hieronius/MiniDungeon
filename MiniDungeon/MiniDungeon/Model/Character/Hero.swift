import Foundation

struct Hero {
	
	// Base Stats
	
	var heroLevel = 1
	
	var baseMinDamage = 5
	var baseMaxDamage = 10
	
	var baseDefence = 0
	
	// In %
	var baseHitChance = 85
	
	// In %
	var baseCritChance = 5
	
	// Current Stats
	
	var currentHP = 100
	var maxHP = 100
	
	var currentMana = 100
	var maxMana = 100
	
	var currentEnergy = 5
	var maxEnergy = 5
	
	var weaponSlot: Weapon? = nil
	var armorSlot: Armor? = nil
	
	var minDamage: Int { baseMinDamage + (weaponSlot?.minDamage ?? 0) }
	var maxDamage: Int { baseMaxDamage + (weaponSlot?.maxDamage ?? 0) }
	var hitChance: Int { baseHitChance + (weaponSlot?.hitChance ?? 0) }
	var critChance: Int { baseCritChance + (weaponSlot?.critChance ?? 0) }
	
	var defence: Int { baseDefence + (armorSlot?.defence ?? 0) }
	
	var spellPower = 10
	
	var skillPoints = 1
	
	var weapons: [Weapon] = [
		WeaponManager.weapons[0],
		WeaponManager.weapons[1]
	]
	var armors: [Armor] = [ArmorManager.armors[0], ArmorManager.armors[1]]
//	var inventory: [Item] = [ItemManager.potions[0], ItemManager.loot[0]]
	var inventory: [Item: Int] = [
		ItemManager.potions[0] : 1,
		ItemManager.loot[0] : 1
	]
	
	// MARK: Increase/Decrease Stats
	
	mutating func levelUP() {
		
		self.maxHP += 20
		self.currentHP = self.maxHP
		self.maxMana += 10
		self.currentMana = self.maxMana
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
		self.spellPower += 1
		self.skillPoints += 2
		self.heroLevel += 1
	}
	
	mutating func upgradeDamage() {
		
//		self.skillPoints -= 1
		self.baseMinDamage += 1
		self.baseMaxDamage += 1
	}
	
	mutating func upgradeHP() {
		
//		self.skillPoints -= 1
		self.maxHP += 1
		self.currentHP = self.maxHP
	}
	
	mutating func upgradeDefence() {
		
//		self.skillPoints -= 1
		self.baseDefence += 1
	}
	
	mutating func upgradeSpellPower() {
		
//		self.skillPoints -= 1
		self.spellPower += 1
	}
}
