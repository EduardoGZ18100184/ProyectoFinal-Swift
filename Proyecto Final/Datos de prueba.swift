//
//  Datos de prueba.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation
import UIKit
import AVKit //para sonidos

var login = [(user: "admin", pass: "1234"),
(user: "eduardo", pass: "gomez"),
(user: "carlos ", pass: "santana")]

//var loginDB = [{"idUsuario":1,"nombre":"Carlos Santana","email":"carlos@gmail.com","password":"123"},{"idUsuario":2,"nombre":"Eduardo Gomez","email":"eduardo@gmail.com","password":"abc"}]

///Datos de prueba para pickerview de citas
///
let mascotasPrueba = ["Luna","Masha", "Lulu", "Manchas", "Firulais" ]

func pruebaPkv(){
    let Luna = Mascota(id: 1,nom: "Luna",tipo: 1,raz: "Siames",idD:1)
    let Masha = Mascota(id: 2,nom: "Masha",tipo: 1,raz: "Desconocida",idD:1)
    let Lulu = Mascota(id: 3,nom: "Lulu",tipo: 1,raz: "Amarillo",idD:1)
    let Manchas = Mascota(id: 4,nom: "Manchas",tipo: 2,raz: "Chihuahua",idD:1)
    let Firulais = Mascota(id: 5,nom: "Firulais",tipo: 2,raz: "Desconocida",idD:1)
    Luna.foto = "https://www.purina-latam.com/sites/g/files/auxxlc391/files/styles/social_share_large/public/01_%C2%BFQu%C3%A9-puedo-hacer-si-mi-gato-est%C3%A1-triste-.png?itok=w67Nhubc"
    Manchas.foto = "https://upload.wikimedia.org/wikipedia/commons/b/b8/Degaen.jpg"
    Masha.foto = "https://static3.lasprovincias.es/www/multimedia/202010/10/media/cortadas/gato-ksgH-U1204237773070s-1248x770@Las%20Provincias.jpg"
    Lulu.foto = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Stray_calico_cat_near_Sagami_River-01.jpg/640px-Stray_calico_cat_near_Sagami_River-01.jpg"
    Firulais.foto = "https://assets.sams.com.mx/image/upload/f_auto,q_auto:eco,w_auto,c_scale,dpr_auto/mx/images/page-landing-images/recomendados/2021/03/recomendados-mascotas-perros-210323.png"
    
    mascotas = [Luna, Masha, Lulu, Manchas, Firulais]
}

///Funcion de prueba para cargar imagen desde una URL
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
