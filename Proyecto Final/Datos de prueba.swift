//
//  Datos de prueba.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation

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
    
    mascotas = [Luna, Masha, Lulu, Manchas, Firulais]
}
