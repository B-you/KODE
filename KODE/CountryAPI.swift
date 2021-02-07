//
//  CountryAPI.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//

import Foundation
import Alamofire
protocol CountryServiceInterface{
  
}


class CountryService{
    init() {}
    static public let shared = CountryService()
    
    func getCountries(  closure: @escaping (([Model]) -> Void)){
        

        let str = "https://api.meetup.com/find/locations?"
     
       
        AF.request(str, method:.get, encoding:   URLEncoding.default).responseJSON { (response) in
            guard let status = response.response?.statusCode else {return}
            let decoder = JSONDecoder()
            guard let data = response.data else {return}
            switch status {
            case 200:
                guard let result = response.value else { return }
                print(result)
                print("success")
                do {
                    let parseddata = try decoder.decode([Model].self, from: data)
                    DispatchQueue.main.async {
                        if !parseddata.isEmpty {
                            closure(parseddata)
                           
                        }
                    }
                } catch let error{
                    print("event getting error is \(error.localizedDescription)")
                }
          
            default:
                print("ok")
                
            }
        }
    }
}

