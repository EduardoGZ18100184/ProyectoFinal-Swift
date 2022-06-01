//
//  Datos.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation

struct Mascota: Decodable, Encodable
{

    var id_mascota: Int
    var nombre: String
    var id_tipo: Int
    var raza: String
    var id_dueno: Int
}

struct Usuario: Decodable, Encodable
{
    var idUsuario: Int
    var nombre: String
    var email: String
    var password: String 
}

var cascotas = [Mascota]()
var usuarios = [Usuario]()
