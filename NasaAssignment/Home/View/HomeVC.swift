//
//  HomeVC.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import UIKit
import RxSwift
import RxCocoa


class HomeVC: UIViewController {
    
    // MARK: - SubViews
    @IBOutlet weak var listsVCView: UIView!

    
    private lazy var listsViewController: ListsTableViewVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ListsTableViewVC") as! ListsTableViewVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController, to: listsVCView)
        
        return viewController
    }()
    
    
    var homeViewModel = HomeViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - View's Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // self.view.addBlurArea(area: self.view.frame, style: .dark)
        setupBindings()
        homeViewModel.requestData()
    }
    
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        // binding loading to vc
        
        homeViewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        
        // observing errors to show
        
        homeViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
        
        homeViewModel
            .lists
            .observe(on: MainScheduler.instance)
            .bind(to: listsViewController.lists)
            .disposed(by: disposeBag)
       
    }
}
