//
//  HomeViewModel.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import Foundation
import RxSwift
import RxCocoa



class HomeViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    
    public let lists : PublishSubject<[Items]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        APIManager.requestData(url: "/search?q=%22%22", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
               
                let lists = returnJson["collection"]["items"]
                .arrayValue.compactMap {return Items(data: try! $0.rawData())}
               
                self.lists.onNext(lists)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
        
    }
}

