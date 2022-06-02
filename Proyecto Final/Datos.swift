//
//  Datos.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation

/*
struct Mascota: Decodable, Encodable
{

    var id_mascota: Int
    var nombre: String
    var id_tipo: Int
    var raza: String
    var id_dueno: Int
}
 */

struct Usuario: Decodable, Encodable
{
    var idUsuario: Int
    var nombre: String
    var email: String
    var password: String 
}

class Mascota: Decodable, Encodable
{

    var id_mascota: Int
    var nombre: String
    var id_tipo: Int
    var raza: String
    var id_dueno: Int
    var foto: String
    
    init(id: Int, nom: String, tipo: Int, raz: String, idD: Int){
        id_mascota = id
        nombre = nom
        id_tipo = tipo
        raza = raz
        id_dueno = idD
        foto = ""
    }
}

var mascotas = [Mascota]()
var usuarios = [Usuario]()

