//
//  WeatherAPI.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//

import Foundation

import Alamofire
protocol WeatherServiceInterface{
  
}


class WeatherService{
    init() {}
    static public let shared = WeatherService()
    
    func getCountryWeather(city : String,dt : Int,   closure: @escaping ((Answer) -> Void)){
        

        let str = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&lang=ru&units=metric&dt=\(dt)&appid=5f52739f815601826671b595f249a6d2"
     
       
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
                    let parseddata = try decoder.decode(Answer.self, from: data)
                    DispatchQueue.main.async {
                      
//                        if !parseddata.isEmpty {
                            closure(parseddata)
                           
//                        }
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

