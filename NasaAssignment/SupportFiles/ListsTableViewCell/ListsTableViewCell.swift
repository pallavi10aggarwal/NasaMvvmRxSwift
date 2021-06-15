//
//  ListsTableViewCell.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import UIKit

class ListsTableViewCell: UITableViewCell {
    @IBOutlet weak var listImage : UIImageView!
    @IBOutlet weak var listArtist : UILabel!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listDate: UILabel!
    public var cellList : Items! {
        didSet {
            self.listImage.clipsToBounds = true
            self.listImage.layer.cornerRadius = 3
            let dataValue =  cellList.data.first as? DataS
            let linkValue =  cellList.links.first as? Links
            
           
            self.listImage?.getImage(url:linkValue?.href ?? "")
            self.listTitle.text = dataValue?.title ?? ""
            self.listArtist.text = dataValue?.photographer ?? ""
            self.listDate.text = dataValue?.date_created ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    override func prepareForReuse() {
        listImage.image = UIImage()
    }
    
}
