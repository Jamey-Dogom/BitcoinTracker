//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the delgate and dataSource of the UIPickerView
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    // pre-reqs to conform to protocol
    
    // determine how many columns in our picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // determine how many rows in our picker
    // set the rows equal to the amount of currency types in our currency array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    // fill the picker row titles with the strings from our currency array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    // tell the picker what to do when the user selects a particular row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(currencyArray[row])
        
        finalURL = baseURL + currencyArray[row]
        getBtcData(url: finalURL)
    }

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBtcData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got BTC data!")
                    let btcJSON : JSON = JSON(response.result.value!)

                    self.updateBTCData(json: btcJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBTCData(json : JSON) {
        
        if let btcResult = json["averages"]["day"].double {
            bitcoinPriceLabel.text = String(btcResult)
        }
        else {
             self.bitcoinPriceLabel.text = "Connection Issues"
        }
    }




}

