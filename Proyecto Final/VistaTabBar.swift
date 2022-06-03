//
//  VistaTabBar.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 31/05/22.
//

import Foundation
import UIKit

class VistaTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
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
    }
    
}
