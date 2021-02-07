//
//  CountryListViewController.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//

import UIKit

class CountryListViewController: UIViewController, UITextFieldDelegate{
    var placeholder : String?
    @IBOutlet weak var whereToTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var model = [Model]()
    var searchmodel = [Model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        CountryService.shared.getCountries { (models) in
            self.model.append(contentsOf: models)
            self.searchmodel.append(contentsOf: models)
            self.tableView.reloadData()
            
        }
        self.whereToTextField.delegate = self
        whereToTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if placeholder != "" {
            self.whereToTextField.placeholder = placeholder
        }
   
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func textFieldDidChange(_ textField: UITextField ) {
        
    guard let searchText = textField.text else {
            searchmodel = model
            return }
        searchmodel = model.filter{
            name in
            if searchText == ""{
                return true
            }
            if name.city == "" {
                return false
            }
            return (name.city!.lowercased().contains((searchText.lowercased())))
        }
            
        self.tableView.reloadData()
    }
}
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchmodel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == 1 {
            cell.textLabel?.text = "Определить мою геопозицию"
            cell.detailTextLabel?.text = ""
        }
        cell.textLabel?.text = searchmodel[indexPath.row].city
        cell.detailTextLabel?.text = "Все аеропорту"
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
        }
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
        mainView.modalPresentationStyle = .fullScreen
        mainView.selectedIndex = 1
        if whereToTextField.placeholder == "Откуда" {
            UserDefaults.standard.setValue(searchmodel[indexPath.row].city, forKey: "city")
//            mainView.country = model[indexPath.row].city
        } else if whereToTextField.placeholder == "Куда" {
//            mainView.anothercountry = model[indexPath.row].city
            UserDefaults.standard.setValue(searchmodel[indexPath.row].city, forKey: "anothercity")
        }
        
       
        self.present(mainView, animated: true, completion: nil)
    }
    
    
}
