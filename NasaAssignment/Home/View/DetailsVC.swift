//
//  DetailsVC.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLable : UILabel!
    @IBOutlet weak var photographerLabel : UILabel!
    @IBOutlet weak var dateCreatedLabel :UILabel!
    @IBOutlet weak var descriptionLabel :UILabel!
    @IBOutlet weak var detailImage :UIImageView!
    
    public var cellDetail : Items!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageData()
    }
    

    func manageData(){
        guard let item = cellDetail else {return}
        if item.data.count > 0 {
            let dataValue =  item.data.first as? DataS
            self.titleLable?.text = dataValue?.title ?? ""

            self.dateCreatedLabel?.text = dataValue?.date_created ?? ""

            self.photographerLabel?.text = dataValue?.photographer ?? ""

            self.descriptionLabel?.text = dataValue?.description ?? ""
        }

        if item.links.count > 0 {
            let linkValue =  item.links.first as? Links
            self.detailImage?.getImage(url:linkValue?.href ?? "")
        }
       
       
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion:nil)
    }
}
