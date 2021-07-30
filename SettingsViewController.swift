//
//  SettingsViewController.swift
//  Prework
//
//  Created by Chandana Pemmasani on 7/16/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipChangefield: UITextField!
    
    @IBOutlet weak var currencyChanger: UIPickerView!
    
    var countryCurrency = [String: String]()
    var countriesList = ["UK", "US", "India", "China", "Europe countries", "Egypt"]

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        listCountriesAndCurrencies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if let selColo = UserDefaults.standard.color(forKey: "color") {
          self.view.backgroundColor = selColo
       }
        if let curSym = UserDefaults.standard.object(forKey: "curSym") as? Int{
            currencyChanger.selectRow(curSym, inComponent: 0, animated: false)
       }
        
    }
    @IBAction func actionSheetDisplay(_ sender: Any) {
        
          let optionMenu = UIAlertController(title: nil, message: "Choose colour", preferredStyle: .actionSheet)
        
        
              
        let deleteAction = UIAlertAction(title: "Pink", style: .default, handler: { (action) -> Void in
            
            UserDefaults.standard.set(UIColor.systemPink, forKey: "color")
           

            self.view.backgroundColor = UIColor.systemPink
            
        })
          let saveAction = UIAlertAction(title: "Gray", style: .default, handler: { (action) -> Void in
            
            UserDefaults.standard.set(UIColor.systemGray, forKey: "color")
            self.view.backgroundColor = UIColor.gray
            
          })
        
              
          let cancelAction = UIAlertAction(title: "Default", style: .default, handler: { (action) -> Void in
            
            UserDefaults.standard.set(UIColor.white, forKey: "color")
            self.view.backgroundColor = UIColor.white
            
          })
              
          optionMenu.addAction(deleteAction)
          optionMenu.addAction(saveAction)
          optionMenu.addAction(cancelAction)
              
          self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    @IBAction func tipChangebtn(_ sender: Any) {
        
        let changedTip = Double(tipChangefield.text!)
        UserDefaults.standard.set(changedTip , forKey: "tip")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    func listCountriesAndCurrencies() {
        let localeIds = Locale.availableIdentifiers
       
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)

             let country = locale.identifier
            if country == "chr_US"{
                if let currency = locale.currencySymbol {
                    countryCurrency["US"] = currency
            }
            }
            if country == "co_FR"{
                if let currency = locale.currencySymbol {
                    countryCurrency["Europe countries"] = currency
            }
            }
            if country == "cy_GB"{
                if let currency = locale.currencySymbol {
                    countryCurrency["Egypt"] = currency
                    countryCurrency["UK"] = currency
            }
            }
            if country == "bn_IN"{
                if let currency = locale.currencySymbol {
                    countryCurrency["India"] = currency
            }
            }
            if country == "bo_CN"{
                if let currency = locale.currencySymbol {
                    countryCurrency["China"] = currency
            }
            }
        }
        
    }

}
extension UserDefaults {

    func color(forKey key: String) -> UIColor? {

        guard let colorData = data(forKey: key) else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("color error \(error.localizedDescription)")
            return nil
        }

    }

    func set(_ value: UIColor?, forKey key: String) {

        guard let color = value else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error color key data not saved \(error.localizedDescription)")
        }

    }
    
}
extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCurrency.count
    }
    
    
}
extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let cur = countriesList[row]
        UserDefaults.standard.set(countryCurrency[cur], forKey: "currency")
        UserDefaults.standard.set(row, forKey: "curSym")
        
    }
    
}
