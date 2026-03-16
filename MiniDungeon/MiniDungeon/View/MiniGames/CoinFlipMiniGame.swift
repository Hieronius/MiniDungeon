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
			CoinFlipMiniGameView()
		}
	}
}

struct CoinFlipMiniGameView: View {
	
	@State var isRotating = false
	@State var rotatingAngle: Double = 0.0
	@State var isSpinning = false
	
	var body: some View {
		
		Spacer()
		Image(systemName: "h.circle")
			.font(.largeTitle)
			.scaleEffect(1.8)
			.rotation3DEffect(.degrees(rotatingAngle), axis: (x: 1, y: 0, z: 0))
			
		
		Spacer()
		
		Button("toggle rotating") {
			
			for _ in 1...10 {
				if rotatingAngle == 360 {
					rotatingAngle = 0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
					self.rotatingAngle += 15.0
				}
			}
		}
		Spacer()
		
	}
}
