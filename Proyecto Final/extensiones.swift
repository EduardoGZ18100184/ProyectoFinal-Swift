//
//  extensiones.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 03/06/22.
//

import Foundation
import UIKit

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
extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
