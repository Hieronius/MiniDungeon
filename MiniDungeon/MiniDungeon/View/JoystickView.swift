import SwiftUI

extension MainView {
	
	struct JoystickView: View {
		
		// MARK: Properties
		
		@State var wasButtonPressed = false
		
		var onTapEnd: ((Direction) -> Void)?
		
		
		// MARK: Body
		
		var body: some View {
			
			ZStack {
				
				Rectangle()
					.frame(width: UIScreen.main.bounds.width / 2,
						   height: UIScreen.main.bounds.height / 4)
					.foregroundStyle(.white)
					.backgroundStyle(.black)
				
				VStack {
					
					// top arrow
					Button("Top") {
						onTapEnd?(.top)
						print("Top")
					}
					.backgroundStyle(wasButtonPressed ? .green : .black)
					HStack {
						
						// left arrow
						Button("Left") {
							onTapEnd?(.left)
							print("left")
						}
						
						// right arrow
						Button("Right") {
							onTapEnd?(.right)
							print("right")
						}
					}
					
					// bottom arrow
					Button("B") {
						onTapEnd?(.bottom)
						print("bottom")
					}
				}
			}
		}
	}
}
