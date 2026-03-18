/*
 
 File to be used for separate AudioManager
 
 right now was used to create a single method to play audio files
 */


import SwiftUI
import AVFoundation

final class AudioManager {
	
	private var player: AVAudioPlayer?
	
	func playSound(fileName: String, extensionName: String) {
		
		guard let url = Bundle.main.url(forResource: fileName, withExtension: extensionName) else {
				print("the URL was not valid") // tell yourself what went wrong
				return
			}
		
		do {
			player = try AVAudioPlayer(contentsOf: url)
			player?.play()
			print("Played some audio")
		} catch {
			print(error)
		}
	}
}
