//
//  CollectionViewController.swift
//  pdfconverter
//
//  Created by Ios Dev on 5/6/24.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource{
    
    var imageArray = [UIImage]()

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else{
            return UICollectionViewCell()
        }
        cell.photoImageView.image = imageArray[indexPath.row]
        
        return cell
    }
    

    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createPDF(from images: [UIImage]) -> Data? {
        // Create a temporary file URL to write the PDF data
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("output.pdf") else {
            return nil
        }
        
        // Create PDF context
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        // Write PDF content to the temporary file
        do {
            try pdfRenderer.writePDF(to: fileURL) { context in
                for image in images {
                    context.beginPage()
                    let imageRect = CGRect(x: 0, y: 0, width: 300, height: 300)
                    image.draw(in: imageRect)
                }
            }
        } catch {
            print("Error creating PDF: \(error)")
            return nil
        }
        
        // Read the data from the temporary file
        do {
            let pdfData = try Data(contentsOf: fileURL)
            // Delete the temporary file
            try FileManager.default.removeItem(at: fileURL)
            return pdfData
        } catch {
            print("Error reading PDF data: \(error)")
            return nil
        }
    }


    @IBAction func btnNext(_ sender: Any) {
        if let pdfData = createPDF(from: imageArray){
            
            let pdfView = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
            pdfView.pdfData = pdfData
            
            self.navigationController?.pushViewController(pdfView, animated: true)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

