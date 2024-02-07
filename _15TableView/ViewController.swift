//
//  ViewController.swift
//  _15TableView
//
//  Created by Eray İnal on 9.11.2023.
//


// Burada alt alta çıkan menü gibi olan Table View'ları göreceğiz.
// Şimdi konuyu anlamak için adı LandmarkBook olan şehirlerin simgelerini gösteren bir uygulama yapalım

// Başta bu konu biraz karışık gelebilir ama bu yapıyı ileride o kadar çok kullanacağız ki adımız gibi ezberleyeceğiz ve kolay gelecek




import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {    // İlk önce burada UITabelView dan kalıtım almamız lazım. Bu ikisi aslında bir sınıf değil interface'dir o yüzden interface fonksiyonlarını yazmazsak hata verir: numberOfRows ve cellFor yazınca çıkıyor

    @IBOutlet weak var myTabelView: UITableView!
    
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    
    var chosenLandmarkName = ""
    var chosenLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Bu aşağıdaki iki satır kodu da yazmamız lazım
        myTabelView.delegate = self
        myTabelView.dataSource = self
        
        
        //var landmarkNames = [String]()  // Burada tanımlayınca tableWiew fonksiyonu içerisinde gözükmediği için bunu dışarıda tanımlamalıyım. ama buradan silmiyorum ki ileride bu koda baktığın zaman kafan karışmasın sadece yorum satırına alıyorum
        landmarkNames.append("Kremlin")
        landmarkNames.append("Colosseum")
        landmarkNames.append("GreatWall")
        
        
        // var landmarkImages = [UIImage]()
        landmarkImages.append(UIImage(named: "Kremlin")!)   // Bu ünlemi koymk zorundayız çünkü swift böyle bir resmin olup olmadığını bilmiyor
        landmarkImages.append(UIImage(named: "Colosseum")!)
        landmarkImages.append(UIImage(named: "GreatWall")!)
        
        
        // Şimdi sıra geldi verileri bağlamaya:
        // İlk yapacağımız şey tableView adındaki iki fonksiyonumuzu ekdeki verilere göre özelleştirmek
        
        
        
        
        
    }

    
    /*fonksiyonların asıl hali aşağıda. Bu fonksiyonları özelleştireceğim için asıl ana hallerini burada yorum satırında tutuyorum
     
     // Verilen hatayı kaldırmak için aşağıdaki bu iki kodu yazmamız şart
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // Bu fonksiyonda kaç tane girdi olacağını soruyor. Atıyorum 10 tane istiyorsak: return 10
         
         return 10
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // Bu fonksiyonda ise ne gösterceğini soruyor
         
         let cell = UITableViewCell()
         // cell.textLabel?.text = "test"    Önceden bu şekilde yazılıyordu ama şimdi swift bu yazım şeklini kaldırdı
         var content = cell.defaultContentConfiguration()
         content.text = "TableView"
         content.secondaryText = "Test"
         cell.contentConfiguration = content
         return cell
     }
     */
    

    // Verilen hatayı kaldırmak için aşağıdaki bu iki kodu yazmamız şart
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Bu fonksiyonda kaç tane girdi olacağını soruyor. Atıyorum 10 tane istiyorsak: return 10
        // ama bizim gösterecek 3 tane girdimiz olacak -> Kremlin Colesseum GreatWall o yüzden return 3
        // ama daha ileri gidersek; biz ileride bunları internetten çekicez ve bu sayı durmadan değişecek o yüzden return lendmarkNames.count
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Bu fonksiyonda ise ne gösterceğini soruyor
        
        let cell = UITableViewCell()
        // cell.textLabel?.text = "test"    Önceden bu şekilde yazılıyordu ama şimdi swift bu yazım şeklini kaldırdı
        var content = cell.defaultContentConfiguration()
        // content.text = "TableView"  //şimdi burada hepsinde TableView yazıyor ama biz isimlerin sırasıyla yazmasını istiyoruz o yüzden bunu yorum satırına alıyorum ve bu fonksiyon parametresinde yazan indexPath'in gücünü görüyorum: Aynı liste gibi indexlere sahiptir
        content.text = landmarkNames[indexPath.row] // '.row' bize indexleri sırasıyla verir.
        content.secondaryText = "Click to see more details..."
        cell.contentConfiguration = content
        return cell
    }
    
    
    // Şimdi buraya kadar: yable view'a yazıları yazdık, detail sınıfını oluşturduk ve modifiye ettik, şimdi sırada table view'lara tıkandığında Detail sayfasının açılması var: bunun için 'didselect' yazdığımızda en bşata çıkan fonsiyona ihtiyacımız var:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bu fonksiyon bize table view'ın bir satırına tıklandığında ne yapayım diye onu soruyor
        
        chosenLandmarkName = landmarkNames[indexPath.row]
        chosenLandmarkImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil) // bu kod ile iki sayfa arasında geçiş yapabiliyorum
    }
    
    // şimdi bizim DetailsVC sınıfındaki değişkenlere(selectedLandmarkName, selectedLandmarkImage) ulaşmam lazım:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedLandmarkName = chosenLandmarkName
            destinationVC.selectedlandmarkImage = chosenLandmarkImage
        }
    }
    
    
    // TableView'dan satır silme
    // Şimdi apple'larda yana kaydırınca silme vs gibi çıkan şeyleri yapıcaz
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{ //'.'dan sonra nasıl bir düzenleme yapılacağını seçmelisin: delete, insert vs
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)  //With ile silerken animasyon oluşmasını ekleyebiliriz
        }
    }
    
}

