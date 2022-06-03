//
//  Datos de prueba.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation
import UIKit
import AVKit //para sonidos

var player: AVAudioPlayer?
func playSound(sonido: String) {
    guard let url = Bundle.main.url(forResource: sonido, withExtension: "wav") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}
