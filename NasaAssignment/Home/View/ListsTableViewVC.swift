//
//  ListsTableViewVC.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListsTableViewVC: UIViewController {

    
    @IBOutlet private weak var listsTableView: UITableView!
    
    
    public var lists = PublishSubject<[Items]>()
    
    public var cellList : Items!
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupBinding()
    }
    
    
    private func setupBinding(){
        
        listsTableView.register(UINib(nibName: "ListsTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: ListsTableViewCell.self))
        
        lists.bind(to: listsTableView.rx.items(cellIdentifier: "ListsTableViewCell", cellType: ListsTableViewCell.self)) {  (row,list,cell) in
            cell.cellList = list
            self.cellList = list
            }.disposed(by: disposeBag)
        
        
        
        listsTableView.rx.itemSelected
          .subscribe(onNext: { [weak self]indexPath in

            
            // Load Storyboard
            let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            
            // Instantiate View Controller
           let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC



            detailViewController.cellDetail =  self?.cellList

            self?.present(detailViewController, animated:true, completion: nil)
           // tracksTableView.rx.itemDeselected
          }).disposed(by: disposeBag)
    }
}




