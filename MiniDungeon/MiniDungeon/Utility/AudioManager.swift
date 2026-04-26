/*
 
 File to be used for separate AudioManager
 
 right now was used to create a single method to play audio files
 */


import SwiftUI
import AVFoundation

/// Entity to control playing sounds and music
final class AudioManager {
	
	private var player: AVAudioPlayer?
	
	private var session: AVAudioSession?
	
	init() {
		
		do {
			try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
			print("AudioSession set to respect silent mode and to be able to mix with other mixable sounds from the device")
			
		}
			catch {
				print("can't set AudioManager to respect silent mode")
			}
	}
	
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
