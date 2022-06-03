//
//  Datos de prueba.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation
import UIKit
import AVKit //para sonidos

extension UIImageView {
    func cargarImagen(_ url: String) {
        guard let urlImagen = URL(string: url)
        else {
            return
        }
        DispatchQueue.main.async(execute: {
            do {
                let imageData = try Data(contentsOf: urlImagen)
                let image = UIImage(data: imageData)
                self.image = image
            } catch {
                print(error.localizedDescription)
            }
        })
    }
}

extension UIImage {
    convenience init (_ url: String) {
        if let urlImagen = URL(string: url) {
            do {
                let imageData = try Data(contentsOf: urlImagen)
                self.init(data: imageData)!
            } catch {
                print(error.localizedDescription)
                self.init()
            }
        } else {
            self.init()
        }
    }
}

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

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

