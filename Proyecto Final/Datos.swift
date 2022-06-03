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

class Usuario: Decodable, Encodable
{
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

class Mascota: Decodable, Encodable
{

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

struct RequestMascota: Decodable, Encodable
{
    var nombre: String
    var idTipo: Int
    var raza: String
    var idDueno: Int
}

var mascotas = [Mascota]()
var mascotas2 = [Mascota]()
var usuarios = [Usuario]()
var UsuarioCurrent = Usuario()

