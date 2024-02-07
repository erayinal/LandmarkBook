//
//  DetailsVC.swift
//  _15TableView
//
//  Created by Eray İnal on 18.12.2023.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var landmarkLabel: UILabel!
    
    var selectedLandmarkName = ""
    var selectedlandmarkImage = UIImage()
    
    // Bu iki değişkeni oluşturmamızın sebebi VieController sınıfında bir seçim yapıldığında bu iki değişkenin değişmesi için yaptık ve şimdi bunları viewDidLoad içerisinde modifiye edelim
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        landmarkLabel.text = selectedLandmarkName
        imageView.image = selectedlandmarkImage
    }
    



}
