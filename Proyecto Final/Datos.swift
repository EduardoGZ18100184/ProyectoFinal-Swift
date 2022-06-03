//
//  Datos.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation

class Usuario: Decodable, Encodable {
    var idUsuario: Int
    var nombre: String
    var email: String
    var password: String
    
    init() {
        idUsuario = 0
        nombre = ""
        email = ""
        password=""
    }
}

class Mascota: Decodable, Encodable {
    var idMascota: Int
    var nombre: String
    var idTipo: Int
    var raza: String
    var idDueno: Int
    
    init(id: Int, nom: String, tipo: Int, raz: String, idD: Int){
        idMascota = id
        nombre = nom
        idTipo = tipo
        raza = raz
        idDueno = idD
    }
}

let tipoMascota = [1: "Perro", 2: "Gato", 3: "Ave", 4: "Reptil", 5: "Roedor", 6: "Pez"]


var mascotas = [Mascota]()
var usuarioCurrent = Usuario()

