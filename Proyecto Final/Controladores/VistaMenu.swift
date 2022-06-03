//
//  VistaMenu.swift
//  Proyecto Final
//
//  Created by Eduardo Gomez on 03/06/22.
//

//import Foundation
import UIKit

class VistaMenu: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpScrollView()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    func setUpScrollView(){
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


