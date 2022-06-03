//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit

class VistaAgendarCita: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var gint_id_mascota = 0
    
    @IBOutlet weak var txtMotivo: UITextField!
    @IBOutlet weak var btnAgendar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pruebaPkv()
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
    
    // Acciones que realiza si se da en el boton agendar
    @IBAction func btnAgendar(_ sender: Any) {
        ValidarHorario()
        
        let alerta = UIAlertController(title: "Agendar cita", message: "Cita agendada correctamente", preferredStyle: .alert)
        let btnCancelar = UIAlertAction(title: "Ok", style: .default){_ in
        }
        alerta.addAction(btnCancelar)
        self.present(alerta, animated: true, completion: nil)
        
        playSound(sonido: "correcto")
        
        //gs_usuario
        //gint_id_mascota
        //dateTF.text
        
        
    }
    
    func ValidarHorario(){
        let horario = dateTF.text
        
        //var formateador = DateFormatter()
        //formateador.dateFormat = "yyyy-MM-dd HH:mm"
        //var horarioDate = formateador.date(from: horario!)
        
        var horarioDate = formatDate(cadena: horario!)
        
        print(horarioDate)
    }
    
    
    /// Funciones para el pickerview de las mascotas del usuario
    
    @IBOutlet weak var pkvMascotas: UIPickerView!
    @IBOutlet weak var txtNombreMascota: UITextField!
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
        
        //txtNombreMascota.text = mascotas[row].nombre
        gint_id_mascota = mascotas[row].idMascota
        //txtTipoMascota.text = String(mascotas[row].idTipo)
        txtTipoMascota.text = buscarTipo(id: mascotas[row].idTipo)
        txtRazaMascota.text = String(mascotas[row].raza)
        imgImagenMascota.image = UIImage()
    }
    
    /// Funciones para la fecha de la cita
    
    func EstablecerFechas(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        let fecha_actual = Calendar.current
        let fecha_minima = fecha_actual.date(byAdding: .day, value: 1, to: Date())
        datePicker.minimumDate = fecha_minima
        datePicker.minuteInterval = 30
        
        //let calendar = Calendar.current
        let date = fecha_actual.date(byAdding: .year, value: 1, to: Date())
        datePicker.maximumDate = date //Muestra hasta un anio mas
                
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date())
    }
    
    @IBOutlet weak var dateTF: UITextField!
    
    @objc func dateChange(datePicker: UIDatePicker)
    {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    //convierte de date a string
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    
    //convierte de string a date
    func formatDate(cadena: String) -> Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: cadena)!
    }
    
}
