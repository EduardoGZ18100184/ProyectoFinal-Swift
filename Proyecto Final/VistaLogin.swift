//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit
var blnResultado = false
var gs_usuario = ""

class VistaLogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo2")!)
    }

    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtContra: UITextField!
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        let usuario = txtUsuario.text
        let contra = txtContra.text
        
        DispatchQueue.main.async{
            self.wsLogin(usuario!)
            if usuarioCurrent.email == usuario && usuarioCurrent.password == contra {
                print("Cargando segunda vista...")
                gs_usuario = self.txtUsuario.text!
                let vista = self.storyboard?.instantiateViewController(identifier: "vTabBar") as? VistaTabBar
                playSound(sonido: "login")
                
                self.navigationController?.pushViewController(vista!, animated: true)
            }else{
                //mostrar alert de error
                print("Usuario/Contraseña incorrecta")
                let alerta = UIAlertController(title: "Error", message: "Usuario/Contraseña incorrecto", preferredStyle: .alert)
                let btnCancelar = UIAlertAction(title: "Ok", style: .default){_ in
                    print("error")
                    print(usuarioCurrent.email)
                    print(usuarioCurrent.password)
                }
                alerta.addAction(btnCancelar)
                self.present(alerta, animated: true, completion: nil)
                blnResultado = false
            }
        }
    }
    
    func wsLogin(_ usuario: String) {
        let liga = "https://vetappios.herokuapp.com/usuario/query?email="+"\(usuario)"
        //var blnResultado = false
        guard let url = URL(string: liga) else { return }
        
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: peticion){
            (data, response, error) in
            DispatchQueue.main.async{
                guard let datos = data else { return }
                do {
                    usuarioCurrent = try JSONDecoder().decode(Usuario.self, from: datos)
                } catch let jsonError {
                    print(jsonError)
                }
            }
        }.resume()
    }
}

