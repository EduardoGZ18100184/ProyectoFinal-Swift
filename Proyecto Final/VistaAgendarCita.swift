//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import UIKit

class VistaAgendarCita: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pruebaPkv()
        pkvMascotas.delegate = self
        pkvMascotas.dataSource = self
        
        pickerView(pkvMascotas, didSelectRow: 0, inComponent: 1)//selecciona el primero en el pkv
        EstablecerFechas()
        
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
        
        txtNombreMascota.text = mascotas[row].nombre
        txtTipoMascota.text = String(mascotas[row].id_tipo)
        txtRazaMascota.text = String(mascotas[row].raza)
        imgImagenMascota.image = UIImage(mascotas[row].foto)
    }
    
    /// Funciones para la fecha de la cita
    
    func EstablecerFechas(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.minuteInterval = 30
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .year, value: 1, to: Date())
        datePicker.maximumDate = date //Muestra hasta un anio mas
                
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date())
    }
    
    @IBOutlet weak var dateTF: UITextField!
    
    @objc func dateChange(datePicker: UIDatePicker)
    {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    
}
