//
//  VistaListadoMascotas.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 02/06/22.
//

import Foundation
import UIKit

class VistaListadoMascotas: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pruebaPkv()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cantidad de renglones que tendra el tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    //
    
   /* override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaNombre", for: indexPath) as! celdaListado
        
        /*celda.lblNombre.text = lenguajes[indexPath.row].nombre
        celda.lblOrientacion.text = lenguajes[indexPath.row].orientacion
        celda.imgLogo.image = lenguajes[indexPath.row].logo*/
        
        celda.lblNombreMascota.text = mascotas[indexPath.row].nombre
        //celda.lblTipoMascota.text = String(mascotas[indexPath.row].id_tipo)
        
        //debo obtener la nueva propiedad con el ur de la imagen
        //convertila a imagen en un objeto y asignarla
        //celda.imgFoto.image =
        

        return celda
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaNombre", for: indexPath) as! celdaListado
        
        celda.lblNombreMascota.text = mascotas[indexPath.row].nombre
        celda.lblTipoMascota.text = String(mascotas[indexPath.row].id_tipo)
        
        //debo obtener la nueva propiedad con el ur de la imagen
        //convertila a imagen en un objeto y asignarla
        celda.imgFoto.image = UIImage(mascotas[indexPath.row].foto)
        
        return celda
    }
}
