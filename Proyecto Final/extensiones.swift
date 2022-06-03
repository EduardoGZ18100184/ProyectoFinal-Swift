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



// tupla de id_tipo - descripcion
var tuplTipos = [
    (id: 1, tipo: "Perro"),
    (id: 2, tipo: "Gato"),
    (id: 3, tipo: "Ave"),
    (id: 4, tipo: "Reptil"),
    (id: 5, tipo: "Roedor"),
    (id: 6, tipo: "Pez")
]

func buscarTipo(id: Int) -> String{
    for tipo in tuplTipos{
        if (id == tipo.id){
            return tipo.tipo
        }
    }
    return ""
}

