//
//  CustomTableViewCell.swift
//  pdfconverter
//
//  Created by Ios Dev on 5/10/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCgpa: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
