//
//  WeatherViewController.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//
import UIKit

class WeatherViewController: UIViewController {
    var firstcity : String?
    var secondcity : String?
    var result = [Answer]()
    var mylist = [List]()
    var date : String?
    var timeStamp : String?
     
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var tocityLabel: UILabel!
   
    @IBOutlet weak var weatherTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        if firstcity != "" {
            self.fromCityLabel.text = firstcity
        }
        if date != "" {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//
//            guard let date = dateFormatter.date(from: date!) else {
//                assert(false, "no date from string")
//
//            }
//
//            dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
//            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//             self.timeStamp = dateFormatter.string(from: date)
//
//            print(timeStamp)

        }
        
        if secondcity != "" {
            self.tocityLabel.text = secondcity
        
            WeatherService.shared.getCountryWeather(city: secondcity!, dt: 10000000) { (results) in
                self.result.append(results)
                for i in 0..<self.result.count {
                    self.mylist.append(contentsOf: self.result[i].list)
                }
                self.weatherTableView.reloadData()
                print(self.result)
            }
        
        // Do any additional setup after loading the view.
        }
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension WeatherViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        cell.titleLabel.text = mylist[indexPath.row].dtTxt
        cell.maximumLabel.text = "Maximum temperature in \(secondcity!) \(mylist[indexPath.row].main.tempMax)C)"
        cell.minimumLabel.text = "Minimum temperature in \(secondcity!) \(mylist[indexPath.row].main.tempMin)C"

        return cell
    }
    
    
}
extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
