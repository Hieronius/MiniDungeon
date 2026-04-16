import SwiftUI

extension MainView {
	
	/// Entity to handle user movement on the dungeon view
	struct JoystickView: View {
		
		// MARK: - State Properties
		
		@State var wasTopArrowButtonPressed = false
		@State var wasBottomArrowButtonPressed = false
		@State var wasLeftArrowButtonPressed = false
		@State var wasRightArrowButtonPressed = false
		
		// MARK: - Public Properties
		
		var onTapEnd: ((Direction) -> Void)?
		
		// MARK: - Body
		
		var body: some View {
			
			ZStack {
				
				Rectangle()
					.frame(width: UIScreen.main.bounds.width / 2,
						   height: UIScreen.main.bounds.height / 5)
					.foregroundStyle(.black)
					.border(.white, width: 5)
				
				HStack {
					
					// left arrow
					Button(
						action: {
							toggleAndSendLeftArrowButtonState()
						}, label: {
							Image(systemName: wasLeftArrowButtonPressed ? "arrow.left.square.fill" : "arrow.left.square")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50, height: 50)
								.foregroundColor(wasLeftArrowButtonPressed ? .green : .white)
						}
					)
					
					VStack {
						
						// top arrow
						Button(
							action: {
								toggleAndSendTopArrowButtonState()
							}, label: {
								Image(systemName: wasTopArrowButtonPressed ? "arrow.up.square.fill" : "arrow.up.square")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 50, height: 50)
									.foregroundColor(wasTopArrowButtonPressed ? .green : .white)
							}
						)
						
						// bottom arrow
						Button(
							action: {
								toggleAndSendBottomArrowButtonState()
							}, label: {
								Image(systemName: wasBottomArrowButtonPressed ? "arrow.down.square.fill" : "arrow.down.square")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 50, height: 50)
									.foregroundColor(wasBottomArrowButtonPressed ? .green : .white)
							}
						)
					}
					// right arrow
					Button(
						action: {
							toggleAndSendRightArrowButtonState()
						}, label: {
							Image(systemName: wasRightArrowButtonPressed ? "arrow.right.square.fill" : "arrow.right.square")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50, height: 50)
								.foregroundColor(wasRightArrowButtonPressed ? .green : .white)
						}
					)
				}
			}
			.onAppear() {
				print("View has been rendered")
			}
		}
	}
}

// MARK: Extension JoystickView

extension MainView.JoystickView {
	
	// MARK: - Handle user input
	
	func toggleAndSendTopArrowButtonState() {
		wasTopArrowButtonPressed = true
		onTapEnd?(.top)
		print("has been pressed")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			wasTopArrowButtonPressed = false
			print("has been unpressed")
		}
	}
	
	func toggleAndSendLeftArrowButtonState() {
		wasLeftArrowButtonPressed = true
		onTapEnd?(.top)
		print("has been pressed")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			wasLeftArrowButtonPressed = false
			print("has been unpressed")
		}
	}
	
	func toggleAndSendRightArrowButtonState() {
		wasRightArrowButtonPressed = true
		onTapEnd?(.top)
		print("has been pressed")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			wasRightArrowButtonPressed = false
			print("has been unpressed")
		}
	}
	
	func toggleAndSendBottomArrowButtonState() {
		wasBottomArrowButtonPressed = true
		onTapEnd?(.top)
		print("has been pressed")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			wasBottomArrowButtonPressed = false
			print("has been unpressed")
		}
	}
}
