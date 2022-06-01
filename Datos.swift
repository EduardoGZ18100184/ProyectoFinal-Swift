//
//  Datos.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation

struct Mascota: Decodable, Encodable
{
    var id: Int
    var nombre: String
    var idTipo: Int
    var raza: String
    var id_duenio: Int
}

struct Usuario: Decodable, Encodable
{
    var idUsuario: Int
    var nombre: String
    var email: String
    var password: String //(codificada)
}

var cascotas = [Mascota]()
var usuarios = [Usuario]()
