/*
 MARK: View to decide what character will take a turn first during the fight
 
 h.circle and e.circle can be used to represent Hero and Enemy turn
 Can we implement it's as a single view which can rotate?
 
 ZStack with 2 circle views?
 
 Animation to increase the size after flipping
 
 systemSymbols can get it's own animation. I probably lose it when apply a custom image but it's ok for time being
 
 If hero goes first -> draw in green, otherwise draw in red
 
 Search for animation of rotating right from SwiftUI
 */
import SwiftUI

extension MainView {
	
	@ViewBuilder
	func buildCoinFlipMiniGame() -> some View {
		
		VStack {
			CoinFlipMiniGameView(heroChanceForFirstTurn: 50)
		}
	}
}

struct CoinFlipMiniGameView: View {
	
	@State var isRotating = false
	@State var rotatingAngle: Double = 0.0
	@State var isSpinning = false
	@State var coinColor: Color = .white
	@State var yOffSet: CGFloat = 0
	@State var direction: Direction = .top
	@State var isHeroCoinInFront = true
	@State var coinFlipEnd = false
	@State var isHapticOn = false
	
	var heroChanceForFirstTurn: Int
	
	/// This closure will send a game result to parent view (Battle View)
	var onGameEnd: ((Bool) -> Void)?
	
	var body: some View {
		
		ZStack {
			
			Rectangle()
				.frame(width: UIScreen.main.bounds.width / 2, height: 300)
				.foregroundStyle(.black)
				.border(coinColor, width: 5)
				.offset(y: -50)
			VStack {
				Image(systemName: isHeroCoinInFront ? "h.circle" : "e.circle")
					.font(.largeTitle)
					.foregroundStyle(coinColor)
					.scaleEffect(1.8)
					.rotation3DEffect(.degrees(rotatingAngle), axis: (x: 1, y: 0, z: 0))
					.offset(y: yOffSet)
				
				Text(isHeroCoinInFront ? "Hero Turn First!" : "Enemy Turn First!")
					.foregroundStyle(coinColor)
					.opacity(coinFlipEnd ? 1.0 : 0.0)
					.offset(y: 30)
				
			}
		}
		.onAppear { startMiniGame() }
		.sensoryFeedback(isHeroCoinInFront ? .success : .error, trigger: isHapticOn)
	}
}

extension CoinFlipMiniGameView {
	
	/// Method generates coin flipping outcome, throws and rotates the coin for visual effect
	func startMiniGame() {
		generateCoinFlippingOutcomeWithDelay()
		throwCoin()
		rotateCoin()
	}
	
	/// Rotates 7 times in 360 degree cycle each time to match throwing speed
	/// delay is equal an amount of degree rotation per each for in cycle
	/// if you want to speed up -> increase the delay in forIn/delay property in Dispatch
	/// if you want to slow down -> decrease the delay in forIn/delay property
	func rotateCoin() {
		
		for flip in 1...7 {
			
			for delay in 1...24 {
				if rotatingAngle == 360 {
					rotatingAngle = 0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay)/24) {
					rotatingAngle += 15.0
					isHeroCoinInFront.toggle()
				}
			}
			
		}
	}
	
	/// Method changes Coin Y offSet for an amount to simulate throwing.
	/// to speed up -> increase delay in forIn and dispatch
	/// to slow down -> decrease delay in forIn and dispatch
	func throwCoin() {
		
		for delay in 1...200 {
			
			DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay)/200) {
				if yOffSet <= -100 {
					direction = .bottom
					
				} else if yOffSet >= 0 {
					direction = .top
				}
				
				if direction == .top {
					print("we move top")
					yOffSet -= 1
				} else if direction == .bottom {
					print("we move bottom")
					yOffSet += 1
				}
				print(yOffSet)
				print(direction)
			}
		}
	}
	
	func generateCoinFlippingOutcomeWithDelay() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.01) {
			let roll = Int.random(in: 1...100)
			
			if roll <= heroChanceForFirstTurn {
				
				coinColor = .green
				isHeroCoinInFront = true
				onGameEnd?(true)
				print("HERO START FIRST")
			} else if roll > heroChanceForFirstTurn {
				
				coinColor = .red
				isHeroCoinInFront = false
				onGameEnd?(false)
				print("ENEMY START FIRST")
			}
			coinFlipEnd = true
			isHapticOn = true
		}
	}
}
