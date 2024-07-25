import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
     
    var imageArray = [UIImage]()
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
                let pdfVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        for result in results {
        
            result.itemProvider.loadObject(ofClass: UIImage.self){
                object,
                error in
                if let image = object as? UIImage{
                    
                    self.imageArray.append(image)
                    pdfVC.imageArray = self.imageArray

                }
                
            }
        }        
                self.navigationController?.pushViewController(pdfVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var selectedImages: [UIImage] = []
    let imagePicker = UIImagePickerController()

    @IBAction func btnUploadImage(_ sender: Any) {
    
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        
        let phPickerVc = PHPickerViewController(configuration: config)
        phPickerVc.delegate = self
        self.present(phPickerVc, animated: true)
        
        
        
        
    }
    
    
    @IBAction func btnTableView(_ sender: Any) {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        self.navigationController?.pushViewController(tableVC, animated: true)
        
    }
    

   
}

