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
        cargarMascotas(usuarioCurrent.idUsuario)
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    @IBAction func refrescar(_ sender: UIRefreshControl) {
        cargarMascotas(usuarioCurrent.idUsuario)
    }
    
    func cargarMascotas(_ idDueno: Int){
        let liga = "https://vetappios.herokuapp.com/mascota/query?idDueno="+"\(idDueno)"
        guard let url = URL(string: liga) else { return }
        
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: peticion) {
            (data, response, error) in
            DispatchQueue.main.async {
                guard let datos = data else { return }
                do {
                    mascotas = try JSONDecoder().decode([Mascota].self, from: datos)
                } catch let jsonError {
                    print(jsonError)
                }
                print (mascotas.count)
            }
        }.resume()
        
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
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
        celda.lblTipoMascota.text = tipoMascota[mascotas[indexPath.row].idTipo]
        return celda
    }
    
    //Botones de agregar y ordenar
    
    @IBAction func moverElemento(_ sender: Any) {
        
    }
    
    
    @IBAction func agregarElemento(_ sender: Any) {
        var nombre = ""
        var tipo = 0
        var raza = ""
        
        let alerta = UIAlertController(title: "Ingrese", message: "Ingrese el nombre, tipo y raza de su mascota. \nPerro = 1\nGato = 2\nAve = 3\nReptil = 4\nRoedor = 5\nPez = 6", preferredStyle: .alert)
        alerta.addTextField {
            txtNombre in txtNombre.placeholder = "Nombre"
        }
        alerta.addTextField {
            txtTipo in txtTipo.placeholder = "Tipo"
        }
        alerta.addTextField{
            txtRaza in txtRaza.placeholder = "Raza"
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel) { _ in }
        let btnIngresar = UIAlertAction(title: "Ingresar", style: .default) {
            _ in nombre = alerta.textFields![0].text!
            tipo = Int(alerta.textFields![1].text!)!
            raza = alerta.textFields![2].text!
            print(nombre)
            print(tipo)
            print(raza)
            
            //Valida que tenga un id valido
            if (tipo != 1 && tipo != 2 && tipo != 3 && tipo != 4 && tipo != 5 && tipo != 6){
                let alerta = UIAlertController(title: "Error", message: "Ingrese un tipo entre 1 y 6", preferredStyle: .alert)
                let btnCancelar = UIAlertAction(title: "Ok", style: .default){_ in
                }
                alerta.addAction(btnCancelar)
                self.present(alerta, animated: true, completion: nil)
                return
            }
            self.wsInsertarMascota(nombre, tipo, raza, usuarioCurrent.idUsuario)
            
            let alerta = UIAlertController(title: "Agregar mascota", message: "Mascota agregada correctamente", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .default){ _ in }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
            playSound(sonido: "correcto")
        }
        alerta.addAction(btnCancelar)
        alerta.addAction(btnIngresar)
        
        self.present(alerta, animated: true, completion: nil)
    }
    
    func wsInsertarMascota(_ nombre: String, _ tipo: Int, _ raza: String, _ duenio: Int) {
        let liga = "https://vetappios.herokuapp.com/mascota/"
        let parametros = [
            "nombre": nombre,
            "idTipo": tipo,
            "raza": raza,
            "idDueno": duenio
        ] as [String : Any]
        
        guard let url = URL(string: liga) else { return }
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "POST"
        
        peticion.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        peticion.httpBody = try? JSONSerialization.data(withJSONObject: parametros, options: [])
        
        let session = URLSession.shared.dataTask(with: peticion){
            data, response, error in
            if let error = error {
                print("El error es: \(error.localizedDescription)")
            }else{
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Respuesta json es \(jsonRes)")
            }
        }.resume()
    }
}
