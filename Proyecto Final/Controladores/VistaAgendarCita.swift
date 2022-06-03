//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit

class VistaAgendarCita: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var txtMotivo: UITextField!
    @IBOutlet weak var btnAgendar: UIButton!
    private var idMascota_ : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cargarMascotas(usuarioCurrent.idUsuario)
        pkvMascotas.delegate = self
        pkvMascotas.dataSource = self
        
        if mascotas.count == 0 {
            let alerta = UIAlertController(title: "Error", message: "No tiene mascotas registradas", preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "Ok", style: .cancel){_ in
                print("error")
            }
            alerta.addAction(btnCancelar)
            self.present(alerta, animated: true, completion: nil)
            btnAgendar.isEnabled = false
        }else{
            pickerView(pkvMascotas, didSelectRow: 0, inComponent: 1)//selecciona el primero en el pkv
            EstablecerFechas()
            btnAgendar.isEnabled = true
        }
        
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
    }
    
    // Acciones que realiza si se da en el boton agendar
    @IBAction func btnAgendar(_ sender: Any) {
        wsGuardarCita(idDueno: usuarioCurrent.idUsuario, idMascota: idMascota_, fechaCita: dateTF.text!, status: 1, motivo: txtMotivo.text!)
        let alerta = UIAlertController(title: "Agendar cita", message: "Cita agendada correctamente", preferredStyle: .alert)
        let btnCancelar = UIAlertAction(title: "Ok", style: .default){ _ in }
        alerta.addAction(btnCancelar)
        self.present(alerta, animated: true, completion: nil)
        playSound(sonido: "correcto")
        
    }
    
    @IBOutlet weak var pkvMascotas: UIPickerView!
    @IBOutlet weak var txtTipoMascota: UITextField!
    @IBOutlet weak var txtRazaMascota: UITextField!
    @IBOutlet weak var imgImagenMascota: UIImageView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mascotas.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mascotas[row].nombre
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.idMascota_ = mascotas[row].idMascota
        txtTipoMascota.text = tipoMascota[mascotas[row].idTipo]
        txtRazaMascota.text = String(mascotas[row].raza)
        imgImagenMascota.image = UIImage()
    }
    
    func EstablecerFechas(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        let fecha_actual = Calendar.current
        let fecha_minima = fecha_actual.date(byAdding: .day, value: 1, to: Date())
        datePicker.minimumDate = fecha_minima
        datePicker.minuteInterval = 30
        
        //let calendar = Calendar.current
        let date = fecha_actual.date(byAdding: .year, value: 1, to: Date())
        datePicker.maximumDate = date //Muestra hasta un anio mas
                
        dateTF.inputView = datePicker
        dateTF.text = Date().toString(format: "dd-MM-yyyy HH:mm")
    }
    
    @IBOutlet weak var dateTF: UITextField!
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = datePicker.date.toString(format: "dd-MM-yyyy HH:mm")
    }
    
    func wsGuardarCita(idDueno:Int, idMascota:Int, fechaCita: String, status: Int, motivo: String) {
        let parametros = [
            "idDueno": idDueno,
            "idMascota": idMascota,
            "fechaCita": fechaCita,
            "status": status,
            "motivo": motivo] as [String : Any]
        
        guard let url = URL(string: "https://vetappios.herokuapp.com/cita/") else { return }
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
