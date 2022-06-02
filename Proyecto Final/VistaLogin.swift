//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit

class VistaLogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //wsCredencialesUsuario()
    }

    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtContra: UITextField!
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        let usuario = txtUsuario.text
        let contra = txtContra.text
        //var blnCredencialesCorrectas = false
        
        //wsCredencialesUsuario()
        wsLogin(usuario!)
        for valor in usuarios {
            if (usuario == valor.email && contra == valor.password){
                //blnCredencialesCorrectas = true
                //break
                print("Cargando segunda vista...")
                
                let vista = storyboard?.instantiateViewController(identifier: "vTabBar") as? VistaTabBar
                //vista?.indice = indexPath.row
                
                navigationController?.pushViewController(vista!, animated: true)
            }else{
                print("Usuario/Contraseña incorrecta")
            }
        }
        
        /*if blnCredencialesCorrectas {
            //cargar segunda vista
            print("Cargando segunda vista...")
            
            let vista = storyboard?.instantiateViewController(identifier: "vTabBar") as? VistaTabBar
            //vista?.indice = indexPath.row
            
            navigationController?.pushViewController(vista!, animated: true)
            
        }else{
            //mostrar alert de error
            print("Usuario/Contraseña incorrecta")
        }
        print("usuario: "+txtUsuario.text!)
        print("pass: "+txtContra.text!)*/
    }
    
    func wsCredencialesUsuario(){
        let liga = "https://vetappios.herokuapp.com/usuario?fbclid=IwAR1OfsV5xQ6kau48cnsf1sbt_gwKjsBi3HSqqncZBy9LoalhVxLh_Cmlwnc"
        
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
                    usuarios = try JSONDecoder().decode([Usuario].self, from: datos)
                }
                catch let jsonError
                {
                    print(jsonError)
                }
                //self.tableView.reloadData()
                //self.tableView.refreshControl?.endRefreshing()
                print (usuarios)
            }
        }.resume()
    }
    
    func wsLogin(_ usuario: String){
        let liga = "https://vetappios.herokuapp.com/usuario/query?email="+"\(usuario)"
        
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
                    usuarios = try JSONDecoder().decode([Usuario].self, from: datos)
                }
                catch let jsonError
                {
                    print(jsonError)
                }
                print (usuarios)
            }
        }.resume()
    }
}

