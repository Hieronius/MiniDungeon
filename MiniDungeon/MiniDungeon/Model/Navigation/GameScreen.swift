//
//  GameScreen 2.swift
//  MiniDungeon
//
//  Created by Арсентий Халимовский on 07.01.2026.
//


import Foundation

/// Entity to define all possible screens in the game
enum GameScreen: Codable, CaseIterable {
	
	case menu
	case battle
	case dungeon
	case town
	case heroStats
	case enemyStats
	case inventory
	case rewards
	case options
	case combatMiniGame
	case trapDefusionMiniGame
	case chestLockPickingMiniGame
	case specialisation
	case merchant
	case heroLevelBonus
	case flask
	case flaskLevelBonus
	case flaskTalants
}
