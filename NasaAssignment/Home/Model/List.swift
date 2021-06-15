//
//  List.swift
//  NasaAssignment
//
//  Created by Admin on 15/06/21.
//

import Foundation
struct NasaModel : Codable {
    let collection : Collection?
}

struct Collection : Codable{
    let items : [Items?]
    
}


struct Items :Codable{
    let links : [Links?]
    let data : [DataS?]
    let href : String?
    
}

struct Links : Codable {
    let href  : String?
}

struct  DataS : Codable{
    let  nasa_id  :String?
    let  date_created  :String?
    let  photographer :String?
    let  title  :String?
    let  center  :String?
    let  description  :String?
    let  media_types  :String?
}
extension Items {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Items.self, from: data)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}
