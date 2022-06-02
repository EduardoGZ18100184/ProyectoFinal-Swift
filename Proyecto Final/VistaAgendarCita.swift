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
        pkvMascotas.delegate = self
        pkvMascotas.dataSource = self
        
        EstablecerFechas()
        
    }
    
    /// Funciones para el pickerview de las mascotas del usuario
    @IBOutlet weak var pkvMascotas: UIPickerView!
    
    let mascotasPrueba = ["Luna","Masha", "Lulu", "Manchas", "Firulais" ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mascotasPrueba.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mascotasPrueba[row]
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
        dateTF.text = formatDate(date: Date()) // todays Date
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
