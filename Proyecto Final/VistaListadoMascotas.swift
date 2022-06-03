//
//  VistaListadoMascotas.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 02/06/22.
//

import Foundation
import UIKit

class VistaListadoMascotas: UITableViewController {
    
    var indice: Int!
    
    override func viewDidLoad() {
        cargarMascotas(UsuarioCurrent.idUsuario)
        super.viewDidLoad()

        pruebaPkv()
        tableView.reloadData()
        
    }
    
    @IBAction func refrescar(_ sender: UIRefreshControl) {
        cargarMascotas(UsuarioCurrent.idUsuario)
    }
    func cargarMascotas(_ idDueno: Int){
        let liga = "https://vetappios.herokuapp.com/mascota/query?idDueno="+"\(idDueno)"
        //var blnResultado = false
        guard let url = URL(string: liga) else { return }
        
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: peticion)
        {(data, response, error) in
            DispatchQueue.main.async
            {
                guard let datos = data else { return }
                do
                {
                    mascotas2 = try JSONDecoder().decode([Mascota].self, from: datos)
                }
                catch let jsonError
                {
                    print(jsonError)
                }
                print (mascotas2.count)
            }
        }.resume()
        
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()    }
    //Botones de agregar y ordenar
    
    @IBAction func moverElemento(_ sender: Any) {
        
    }
    
    
    @IBAction func agregarElemento(_ sender: Any) {
        var nombre = ""
        var tipo = 0
        var raza = ""
        
        let alerta = UIAlertController(title: "Ingrese", message: "Ingrese el nombre, tipo y raza de su mascota", preferredStyle: .alert)
        alerta.addTextField {
            txtNombre in txtNombre.placeholder = "Nombre"
        }
        alerta.addTextField {
            txtTipo in txtTipo.placeholder = "Tipo"
            //txtContrasena.isSecureTextEntry = true
        }
        alerta.addTextField{
            txtRaza in txtRaza.placeholder = "Raza"
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel) {
            _ in //self.lblResult.text = "CANCELADO"
        }
        let btnIngresar = UIAlertAction(title: "Ingresar", style: .default) {
            _ in nombre = alerta.textFields![0].text!
            tipo = Int(alerta.textFields![1].text!)!
            raza = alerta.textFields![2].text!
            print(nombre)
            print(tipo)
            print(raza)
            //var id = UsuarioCurrent.idUsuario
            let id = 1
            self.wsInsertarMascota(nombre, tipo, raza, id)
        }
        
        alerta.addAction(btnCancelar)
        alerta.addAction(btnIngresar)
        
        self.present(alerta, animated: true, completion: nil)
    }
    
    func wsInsertarMascota(_ nombre: String, _ tipo: Int, _ raza: String, _ duenio: Int)
    {
        let liga = "https://vetappios.herokuapp.com/mascota/"
        let parametros = "nombre=\(nombre)&idTipo=\(tipo)&raza=\(raza)&idDueno=\(duenio)"
        
        guard let url = URL(string: liga) else { return }
        var peticion = URLRequest(url: url)
        
        let reqMascota = RequestMascota(nombre: nombre, idTipo: tipo, raza: raza, idDueno: duenio)
        peticion.httpMethod = "POST"
        
        let json: [String: Any] = ["\"nombre\"": "\(nombre)",
                                   "\"idTipo\"": "\(tipo)",
                                   "\"raza\"": "\(raza)",
                                   "\"idDuenio\"": "\(duenio)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        peticion.httpBody = jsonData
        //peticion.httpMethod = "POST"
        //peticion.httpBody = parametros.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: peticion) { (data, response, error) in
            
            if let error = error {
                // Handle HTTP request error
            } else if let data = data {
                print("OK")
                
                let alerta = UIAlertController(title: "Agregar mascota", message: "Mascota agregada correctamente", preferredStyle: .alert)
                let btnCancelar = UIAlertAction(title: "Ok", style: .default){_ in
                }
                alerta.addAction(btnCancelar)
                self.present(alerta, animated: true, completion: nil)
            } else {
                // Handle unexpected error
            }
        }
        task.resume()
    }
    
    //Renglones del listado
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cantidad de renglones que tendra el tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotas2.count
    }
    
    //altura de cada renglon
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaNombre", for: indexPath) as! celdaListado
        
        celda.lblNombreMascota.text = mascotas2[indexPath.row].nombre
        celda.lblTipoMascota.text = String(mascotas2[indexPath.row].idTipo)
        //celda.imgFoto.image = UIImage(mascotas[indexPath.row].foto)
        
        return celda
    }
}
