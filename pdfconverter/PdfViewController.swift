//
//  PdfViewController.swift
//  pdfconverter
//
//  Created by Ios Dev on 5/6/24.
//

import UIKit

class PdfViewController: UIViewController {
    var pdfData : Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        shareWithFriends.layer.cornerRadius = 12
        shareWithFriends.layer.borderWidth = 1
        shareWithFriends.layer.borderColor = UIColor.gray.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var shareWithFriends: UIButton!
    
    @IBAction func btnDownload(_ sender: Any) {
            guard let pdfData = pdfData else {
                print("Error: PDF data is nil")
                return
            }
            
            // Save the PDF data to a file
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileName = "generated_pdf.pdf"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            do {
                try pdfData.write(to: fileURL)
                print("PDF file saved at:", fileURL)
                
                // Display an alert to inform the user that the PDF has been saved successfully
                let alertController = UIAlertController(title: "Success", message: "Your PDF has been downloaded.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            } catch {
                print("Error saving PDF file:", error.localizedDescription)
                // Handle the error appropriately, such as displaying an alert to the user
            }
        }
    
    @IBAction func btnShareWithFriends(_ sender: Any) {
        guard let pdfData = pdfData else {
            print("Error: PDF data is nil")
            return
        }
        
        // Create a URL to save the PDF data temporarily
        let temporaryFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("temp_pdf.pdf")
        
        do {
            // Write the PDF data to the temporary file
            try pdfData.write(to: temporaryFileURL)
            
            // Create an activity view controller with the PDF file
            let activityViewController = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
            
            // Exclude some activities if needed
            activityViewController.excludedActivityTypes = [
                .postToWeibo,
                .print,
                .copyToPasteboard,
                .assignToContact
                // Add or remove activity types as needed
            ]
            
            // Present the activity view controller
            present(activityViewController, animated: true, completion: nil)
            
        } catch {
            print("Error sharing PDF file:", error.localizedDescription)
            // Handle the error appropriately, such as displaying an alert to the user
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
