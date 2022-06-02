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
    //Botones de agregar y ordenar
    
    @IBAction func moverElemento(_ sender: Any) {
        
    }
    
    
    @IBAction func agregarElemento(_ sender: Any) {
        
    }
    
    //Renglones del listado
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cantidad de renglones que tendra el tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotas.count
    }
    
    //altura de cada renglon
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaNombre", for: indexPath) as! celdaListado
        
        celda.lblNombreMascota.text = mascotas[indexPath.row].nombre
        celda.lblTipoMascota.text = String(mascotas[indexPath.row].id_tipo)
        celda.imgFoto.image = UIImage(mascotas[indexPath.row].foto)
        
        return celda
    }
}
