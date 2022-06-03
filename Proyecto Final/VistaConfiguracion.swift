//
//  VistaConfiguracion.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation
import UIKit

class VistaConfiguracion: UIViewController {
    
    @IBOutlet weak var txtnvoCorreo: UITextField!
    
    @IBOutlet weak var txtConfirmaCorreo: UITextField!
    
    @IBAction func btnCambiarCorreo(_ sender: Any) {
        let correo1 = txtnvoCorreo.text!
        let correo2 = txtConfirmaCorreo.text!
        
        if (correo1 == "" || correo2 == ""){
            //mostrar alert de que esta vacio
            let alerta = UIAlertController(title: "Error", message: "Ingrese un correo valido", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(usuarioCurrent.email)
                print(usuarioCurrent.password)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
            return
        }
        
        if (correo1 == correo2){
            wsCambiarEmail(nvoEmail: correo1)
            let alerta = UIAlertController(title: "Cambio de correo", message: "Correo cambiado correctamente", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(usuarioCurrent.email)
                print(usuarioCurrent.password)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
        }else{
            //mostrar alert de que no coinciden
            let alerta = UIAlertController(title: "Error", message: "Los correos no coinciden", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(usuarioCurrent.email)
                print(usuarioCurrent.password)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
        }
        LimpiarCampos()
    }
    
    
    @IBOutlet weak var txtnvoContra: UITextField!
    
    @IBOutlet weak var txtConfirmaContra: UITextField!
    
    @IBAction func btnCambiaContra(_ sender: Any) {
        let contra1 = txtnvoContra.text!
        let contra2 = txtConfirmaContra.text!
        
        if (contra1 == "" || contra2 == ""){
            //mostrar alert de que esta vacio
            let alerta = UIAlertController(title: "Error", message: "Ingrese una contraseña valida", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(contra1)
                print(contra2)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
            return
        }
        
        if (contra1 == contra2){
            //cambia contra
            wsCambiarContrasena(nvaContrasena: contra1)
            let alerta = UIAlertController(title: "Cambio de contraseña", message: "Contraseña cambiada correctamente", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(usuarioCurrent.email)
                print(usuarioCurrent.password)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
        }else{
            //mostrar alert de que no coinciden
            let alerta = UIAlertController(title: "Error", message: "Las contraseñas no coinciden", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
                print(usuarioCurrent.email)
                print(usuarioCurrent.password)
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
        }
        LimpiarCampos()
    }
    
    func LimpiarCampos(){
        txtnvoContra.text = ""
        txtnvoCorreo.text = ""
        txtConfirmaContra.text = ""
        txtConfirmaCorreo.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func wsCambiarContrasena(nvaContrasena: String) {
        let parametros = [
            "idUsuario": usuarioCurrent.idUsuario,
            "nombre": usuarioCurrent.nombre,
            "email": usuarioCurrent.email,
            "password": nvaContrasena] as [String : Any]
        usuarioCurrent.password = nvaContrasena
        guard let url = URL(string: "https://vetappios.herokuapp.com/usuario/") else { return }
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "POST"
        peticion.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        peticion.httpBody = try? JSONSerialization.data(withJSONObject: parametros, options: [])
        
        let session = URLSession.shared.dataTask(with: peticion){
            data, response, error in
            if let error = error {
                print("El error es: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Respuesta json es \(jsonRes)")
            }
        }.resume()
    }
    
    func wsCambiarEmail(nvoEmail: String) {
        let parametros = [
            "idUsuario": usuarioCurrent.idUsuario,
            "nombre": usuarioCurrent.nombre,
            "email": nvoEmail,
            "password": usuarioCurrent.password] as [String : Any]
        usuarioCurrent.email = nvoEmail
        guard let url = URL(string: "https://vetappios.herokuapp.com/usuario/") else { return }
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "POST"
        peticion.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        peticion.httpBody = try? JSONSerialization.data(withJSONObject: parametros, options: [])
        
        let session = URLSession.shared.dataTask(with: peticion){
            data, response, error in
            if let error = error {
                print("El error es: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Respuesta json es \(jsonRes)")
            }
        }.resume()
    }
}
