//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit
var blnResultado = false
class VistaLogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        wsCredencialesUsuario()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo2")!)
    }

    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtContra: UITextField!
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        let usuario = txtUsuario.text
        let contra = txtContra.text
        var blnBandera = false
        wsLogin(usuario!)
        
        for valor in usuarios {
            if (usuario == valor.email && contra == valor.password){
                blnBandera = true
                break
            }
        }
        
        if  blnBandera {
            //cargar segunda vista
            print("Cargando segunda vista...")
            
            let vista = storyboard?.instantiateViewController(identifier: "vTabBar") as? VistaTabBar
            playSound(sonido: "login")
            //vista?.indice = indexPath.row
            
            navigationController?.pushViewController(vista!, animated: true)
            
        }else{
            //mostrar alert de error
            print("Usuario/Contraseña incorrecta")
            let alerta = UIAlertController(title: "Error", message: "Usuario/Contraseña incorrecto", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel){_ in
                print("error")
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
            blnResultado = false
        }
    }
    
    func wsCredencialesUsuario()
    {
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
                print (usuarios)
            }
        }.resume()
    }
    
    func wsLogin(_ usuario: String) {
        let liga = "https://vetappios.herokuapp.com/usuario/query?email="+"\(usuario)"
        //var blnResultado = false
        guard let url = URL(string: liga) else { return }
        
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: peticion)
        {(data, response, error) in
            DispatchQueue.main.sync
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

