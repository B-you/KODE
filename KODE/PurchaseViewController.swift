//
//  PurchaseViewController.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//

import UIKit
import CoreLocation
class PurchaseViewController: UIViewController, CLLocationManagerDelegate {
    let geocoder = CLGeocoder()
   
    var model = [Model]()
    var countryPicker = UIPickerView()
    var countrytoolBar = UIToolbar()
    var datestring : String?
    var date: Date?
    let datePicker = UIDatePicker()
    let formatter = DateFormatter()
    var toolbar = UIToolbar()
//    var datePicker  = UIDatePicker()
    var adultcount = 1
    var childcount = 0
    var infantcount = 0
    var isinterchangeClick = true
    var isNotifiedClick = false
    var lastPressedView : UIView?
    
    
    @IBOutlet weak var interchangeOutlet: UIButton!
    
    
    @IBOutlet weak var infantAgeLabel: UILabel!
    @IBOutlet weak var childAgeLabel: UILabel!
    @IBOutlet weak var infantImageOutlet: UIImageView!
    @IBOutlet weak var childImageOutlet: UIImageView!
    @IBOutlet weak var notificationOutlet: UIButton!
    @IBOutlet weak var minusInfantOutlet: UIButton!
    @IBOutlet weak var minusChildOutlet: UIButton!
    @IBOutlet weak var goingDate: UITextField!
    @IBOutlet weak var comingBackDate: UITextField!
   
    @IBOutlet weak var numberOfInfantLabel: UILabel!
    @IBOutlet weak var numberOfChildLabel: UILabel!
    @IBOutlet weak var numberOfAdultLabel: UILabel!
    @IBOutlet weak var minusAdultOutlet: UIButton!
    @IBOutlet weak var comingBackButton: UIButton!
  
    @IBOutlet weak var fromWhereTextField: UITextField!
    
    @IBOutlet weak var toWhereTextField: UITextField!
    
    @IBOutlet weak var comingbackView: UIView!
   
    @IBOutlet weak var whereDateView: UIView!
    @IBOutlet weak var toLabel: UILabel!
  
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromView: UIView!
    
    private var isComingback = true
    var country : String?
    var anothercountry : String?
    lazy var locationManager: CLLocationManager = {
           var _locationManager = CLLocationManager()
           _locationManager.delegate = self
           _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           _locationManager.activityType = . automotiveNavigation
           _locationManager.distanceFilter = 10.0  // Movement threshold for new events
         //  _locationManager.allowsBackgroundLocationUpdates = true // allow in background

           return _locationManager
       }()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hi")
       if let currentLocation = locations.last {
        guard let locvalue : CLLocationCoordinate2D  = locationManager.location?.coordinate else {return}
        let location = CLLocation(latitude: locvalue.latitude, longitude: locvalue.longitude)
        print("Current location: \(currentLocation)")
        self.locationManager.stopUpdatingLocation()
        
        geocoder.reverseGeocodeLocation(location, completionHandler:  { (placemarks, error) in
            
            if error == nil {
                if let firstlocation = placemarks?[0] {
                    if let cityname = firstlocation.locality {
                    print("my city name is \(cityname)")
                        self.fromWhereTextField.text = "Все аеропорту".localized()
                        self.fromLabel.text = cityname.localized()
                    self.fromLabel.textColor = #colorLiteral(red: 0.08224926144, green: 0.1252499819, blue: 0.167604655, alpha: 1)
                   
                }
                }
            }
        })
       }
   }

//   // 2
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error)
   }
//   func getLocation() {
//    locationMgr.delegate = self
//        // 1
////        let status = locationMgr.authorizationStatus()
//
//    switch locationMgr.authorizationStatus {
//            // 1
//        case .notDetermined:
//            locationMgr.requestWhenInUseAuthorization()
//                return
//
//            // 2
//        case .denied, .restricted:
//            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//
//            present(alert, animated: true, completion: nil)
//            return
//        case .authorizedAlways, .authorizedWhenInUse:
//            break
//
//        @unknown default:
//            print("error")
//        }
//
//        // 4
//
//    locationMgr.startUpdatingLocation()
//    }
    @objc func viewClicked (_ gesture : UIGestureRecognizer) {

        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "countryVC") as! CountryListViewController
        mainView.modalPresentationStyle = .fullScreen
        mainView.placeholder = "Откуда".localized()
        self.present(mainView, animated: true, completion: nil)
    }
    @objc func viewClicked2 (_ gesture : UIGestureRecognizer) {

        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "countryVC") as! CountryListViewController
        mainView.modalPresentationStyle = .fullScreen
        mainView.placeholder = "Куда".localized()
        self.present(mainView, animated: true, completion: nil)
    }
//    private func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//           return rowHeight
//       }
//
//       func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//           return 1
//       }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//           return model.count
//       }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//
//           var returnLabel: UIView!
//           var pickerLabel: UILabel!
//           var pickerLabel2: UILabel!
//
//           if view == nil {
//            returnLabel = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: rowHeight))
//            pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: returnLabel.frame.size.width, height: rowHeight / 2))
//            pickerLabel2 = UILabel(frame: CGRect(x: 0, y: rowHeight / 2, width: returnLabel.frame.size.width, height: rowHeight / 2))
//               returnLabel.addSubview(pickerLabel)
//               returnLabel.addSubview(pickerLabel2)
//           }
//
//           // title
//
//
//
//        let myTitle = NSAttributedString(string: model[row].city!, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
//           pickerLabel.attributedText = myTitle
//        pickerLabel.textAlignment = .center
//
//           // subtitle
//
////           let subtitleData = subtitleList
//
//        let mySubtitleTitle = NSAttributedString(string: "Все аеропорту", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 12.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
//           pickerLabel2.attributedText = mySubtitleTitle
//
//           return returnLabel
//       }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        switch locationManager.authorizationStatus {
//                // 1
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//                    return
//
//                // 2
//            case .denied, .restricted:
//                let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(okAction)
//
//                present(alert, animated: true, completion: nil)
//                return
//            case .authorizedAlways, .authorizedWhenInUse:
//                break
//
//            @unknown default:
//                print("error")
//            }
//
//            // 4
//
//        locationManager.startUpdatingLocation()
        
        //allow location use
        locationManager.requestAlwaysAuthorization()

        print("did load")
        print(locationManager)

        //get current user location for startup
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
//
        if let city = UserDefaults.standard.object(forKey: "city") as? String {
            self.fromWhereTextField.text = "Все аеропорту".localized()
            self.fromLabel.text = city.localized()
            self.fromLabel.textColor = #colorLiteral(red: 0.08224926144, green: 0.1252499819, blue: 0.167604655, alpha: 1)
        }
        if let anothercity = UserDefaults.standard.object(forKey: "anothercity") as? String {
            self.toWhereTextField.text = "Все аеропорту".localized()
            self.toLabel.text = anothercity.localized()
            self.toLabel.textColor = #colorLiteral(red: 0.08224926144, green: 0.1252499819, blue: 0.167604655, alpha: 1)
        }
        if  self.fromWhereTextField.text != "" &&  self.toWhereTextField.text != "" {
            self.interchangeOutlet.isEnabled = true
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
//        getLocation()
        comingBackButton.layer.borderWidth = 0.5
        comingBackButton.layer.borderColor = #colorLiteral(red: 0.5726934671, green: 0.6336677074, blue: 0.7029700279, alpha: 1)
        
//        if country != "" {
//            self.fromWhereTextField.text = country
//        }
//        if anothercountry != "" {
//            self.toWhereTextField.text = anothercountry
//        }
        self.infantAgeLabel.isEnabled = false
        self.childAgeLabel.isEnabled = false
        self.numberOfAdultLabel.text = "\(1)"
        self.numberOfChildLabel.text = "\(0)"
        self.numberOfInfantLabel.isEnabled = false
        self.interchangeOutlet.isEnabled = false
        self.numberOfChildLabel.isEnabled = false
        self.numberOfInfantLabel.text = "\(0)"
        self.minusAdultOutlet.isEnabled = false
        self.minusChildOutlet.isEnabled = false
        self.minusInfantOutlet.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(datePicking))
        whereDateView.isUserInteractionEnabled = true
        whereDateView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(datePicking2))
        comingbackView.isUserInteractionEnabled = true
        comingbackView.addGestureRecognizer(tap2)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(viewClicked(_:)))
        fromView.isUserInteractionEnabled = true
        fromView.addGestureRecognizer(tapped)
        
        let othertapped = UITapGestureRecognizer(target: self, action: #selector(viewClicked2(_:)))
        toView.isUserInteractionEnabled = true
        toView.addGestureRecognizer(othertapped)
        
        if isNotifiedClick {
            self.notificationOutlet.setImage(UIImage(named: "ic_notiffications"), for: .normal)
            self.notificationOutlet.isEnabled = false
        }
    }

   
    @objc func datePicking2 () {
        print("hello")
        if #available(iOS 14, *) {
        setDatePicker2()
        }

    }
    @objc func datePicking () {
        print("hello")
        if #available(iOS 14, *) {
        setDatePicker()
        }

    }
    func setDatePicker2() {
        //Format Date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = NSDate() as Date
           datePicker.backgroundColor = UIColor.white
        datePicker.locale = Locale(identifier: "RU-ru")
           datePicker.autoresizingMask = .flexibleWidth
           datePicker.datePickerMode = .date
                   
           datePicker.addTarget(self, action: #selector(self.dateChanged2(_:)), for: .valueChanged)
           datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(datePicker)
                   
           toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolbar.barStyle = .blackTranslucent
           toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick2(_:)))]
           toolbar.sizeToFit()
           self.view.addSubview(toolbar)
    }
    func setDatePicker() {
        //Format Date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = NSDate() as Date
           datePicker.backgroundColor = UIColor.white
        datePicker.locale = Locale(identifier: "RU-ru")
           datePicker.autoresizingMask = .flexibleWidth
           datePicker.datePickerMode = .date
                   
           datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
           datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(datePicker)
                   
           toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolbar.barStyle = .blackTranslucent
           toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick(_:)))]
           toolbar.sizeToFit()
           self.view.addSubview(toolbar)
    }
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "RU-ru")
        dateFormatter.dateFormat = "dd MMM"
        
      
            
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            let month = self.formatter.string(from: date)
           let day = date.dayofweek()
            self.goingDate.text = "\(dateFormatter.string(from: date)),\(day!)"
            
            let formatter = DateFormatter()

            formatter.timeZone = TimeZone.current

            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            self.datestring = formatter.string(from: date)
             
        }
        

           
    }
    @objc func dateChanged2(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "RU-ru")
        dateFormatter.dateFormat = "dd MMM"
        
      
            
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            
           let day = date.dayofweek()
            self.comingBackDate.text = "\(dateFormatter.string(from: date)),\(day!)"
            
            
             
        }
    }

    @objc func onDoneButtonClick(_ sender: UIDatePicker?) {

        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()

    }
    @objc func onDoneButtonClick2(_ sender: UIDatePicker?) {

        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()

    }
 
    @IBAction func continuePressed(_ sender: Any) {
        if  self.fromWhereTextField.text != "" && self.toWhereTextField.text != "" && self.goingDate.text != "" {
            let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weatherVC") as! WeatherViewController
            mainView.modalPresentationStyle = .fullScreen
            mainView.firstcity =  self.fromLabel.text
                mainView.secondcity = self.toLabel.text
            mainView.date =  self.datestring
            self.present(mainView, animated: true, completion: nil)
        } else {
            
        }
    }
    @IBAction func minusInfantPressed(_ sender: Any) {
        if infantcount > 0  {
            infantcount -= 1
            if  infantcount > 0 {
                self.minusInfantOutlet.isEnabled = true
                self.numberOfInfantLabel.isEnabled = true
                self.infantAgeLabel.isEnabled = true
            } else if infantcount == 0 {
                self.minusInfantOutlet.isEnabled = false
                self.numberOfInfantLabel.isEnabled = false
                self.infantAgeLabel.isEnabled = false
            }
            
        } else if infantcount < 1 {
            print("it is zero")
            minusInfantOutlet.isEnabled = false
            self.numberOfInfantLabel.isEnabled = false
            self.infantAgeLabel.isEnabled = false
        }
        
        self.numberOfInfantLabel.text = "\(infantcount)"
    }
    @IBAction func addInfantPressed(_ sender: Any) {
        if infantcount < adultcount  {
       if adultcount + childcount < 9 &&  adultcount + childcount + infantcount < 9 {
       
         
            infantcount += 1
            if  infantcount > 0 {
                self.minusInfantOutlet.isEnabled = true
                self.numberOfInfantLabel.isEnabled = true
                self.infantAgeLabel.isEnabled = true
            } else if infantcount == 0 {
                self.minusInfantOutlet.isEnabled = false
                self.numberOfInfantLabel.isEnabled = false
                self.infantAgeLabel.isEnabled = false
            }
       } else {
        let alert = UIAlertController(title: "", message: "Пассажиров не должен быть более 9 человек".localized(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .cancel) { (action) in
           
            
        })
        self.present(alert, animated: true, completion: nil)
       }
       } else {
        
        let alert = UIAlertController(title: "", message: "Младенцев не должен быть меньше чем взрослых".localized(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .cancel) { (action) in
           
            
        })
        self.present(alert, animated: true, completion: nil)
       }
            
        
       
        self.numberOfInfantLabel.text = "\(infantcount)"
    }
    @IBAction func minusChildPressed(_ sender: Any) {
        if childcount > 0  {
            childcount -= 1
            if  childcount > 0 {
                self.minusChildOutlet.isEnabled = true
                self.numberOfChildLabel.isEnabled = true
                self.childImageOutlet.isUserInteractionEnabled = true
                self.childAgeLabel.isEnabled = true
            } else if childcount == 0 {
                self.minusChildOutlet.isEnabled = false
                self.numberOfChildLabel.isEnabled = false
                self.childImageOutlet.isUserInteractionEnabled = false
                self.childAgeLabel.isEnabled = false
        
            }
            
        } else if self.numberOfChildLabel.text == "\(0)" {
            minusChildOutlet.isEnabled = false
            self.numberOfChildLabel.isEnabled = false
        }
        
        self.numberOfChildLabel.text = "\(childcount)"
    }
    @IBAction func addChildPressed(_ sender: Any) {
        if childcount < 8 && adultcount + childcount + infantcount < 9 && adultcount + childcount < 9 {
         
            childcount += 1
            if childcount >= 1 {
                self.minusChildOutlet.isEnabled = true
                self.numberOfChildLabel.isEnabled = true
                self.childImageOutlet.isUserInteractionEnabled = true
                self.childAgeLabel.isEnabled = true
                
                
                
            } else if childcount == 0 {
                self.minusChildOutlet.isEnabled = false
                self.numberOfChildLabel.isEnabled = false
                self.childImageOutlet.isUserInteractionEnabled = false
                self.childAgeLabel.isEnabled = false
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "Пассажиров не должен быть более 9 человек".localized(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок".localized(), style: .cancel) { (action) in
               
                
            })
            self.present(alert, animated: true, completion: nil)
        }
        self.numberOfChildLabel.text = "\(childcount)"
    }
    @IBAction func minusAdultPressed(_ sender: Any) {
        if adultcount > 1  {
            adultcount -= 1
            if adultcount < infantcount {
                infantcount -= 1
            }
            if  adultcount > 1{
                minusAdultOutlet.isEnabled = true
            } else if adultcount == 1 {
                minusAdultOutlet.isEnabled = false
        
            }
            
        } else if self.numberOfAdultLabel.text == "\(1)" {
            minusAdultOutlet.isEnabled = false
        }
        self.numberOfInfantLabel.text = "\(infantcount)"
        self.numberOfAdultLabel.text = "\(adultcount)"
    }
    @IBAction func addAdultPressed(_ sender: Any) {
        if adultcount < 9 && adultcount + childcount + infantcount < 9 && adultcount + childcount < 9 {
         
            adultcount += 1
            if adultcount > 1 {
                self.minusAdultOutlet.isEnabled = true
            } else if adultcount == 1 {
                self.minusAdultOutlet.isEnabled = false
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "Пассажиров не должен быть более 9 человек", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel) { (action) in
               
                
            })
            self.present(alert, animated: true, completion: nil)
        }
        
        self.numberOfAdultLabel.text = "\(adultcount)"
    }
    @IBAction func comingBackPressed(_ sender: UIButton) {
//     var isComingback = false
        if !isComingback  {
      
            print("hello 1")
            isComingback = true
            comingbackView.isHidden = true
            comingBackButton.setImage(UIImage(named: "ic_plus"), for: .normal)
            comingBackButton.setTitle("Обратный рейс".localized(), for: .normal)
            comingBackButton.layer.borderWidth = 0.5
            comingBackButton.layer.borderColor = #colorLiteral(red: 0.5726934671, green: 0.6336677074, blue: 0.7029700279, alpha: 1)
            
        } else {
            print("hello 2")
            isComingback = false
            comingBackButton.layer.borderWidth = 0.0

            comingBackButton.semanticContentAttribute = .forceRightToLeft
            comingbackView.isHidden = false
            comingBackButton.setImage(UIImage(named: "ic_close"), for: .normal)

            
          
        }
    }
    @IBAction func interchangeButtonPressed(_ sender: Any) {
//        if  self.fromWhereTextField.text != "" &&  self.toWhereTextField.text != "" {
//            let to = self.toLabel.text
//            let from = self.fromLabel.text
//            print(to)
//            print(from)
//        if !isinterchangeClick {
//            isinterchangeClick = false
//            self.fromLabel.text = to
//            self.fromLabel.textColor = #colorLiteral(red: 0.08224926144, green: 0.1252499819, blue: 0.167604655, alpha: 1)
//        } else {
//            isinterchangeClick = true
//            self.toLabel.text = from
//            self.fromLabel.textColor = #colorLiteral(red: 0.08224926144, green: 0.1252499819, blue: 0.167604655, alpha: 1)
//        }
//        }
    }
    @IBAction func notificationPressed(_ sender: Any) {
        isNotifiedClick = true
        
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "notificationVC") as! NotificationViewController
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
        self.notificationOutlet.setImage(UIImage(named: "ic_notiffications"), for: .normal)
        self.notificationOutlet.isEnabled = false
    }
}
extension Date {
    func dayofweek() -> String? {
    let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU-ru")
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self).capitalized
    }
}

extension String {
    func localized() ->  String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
