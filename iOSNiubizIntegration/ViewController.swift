//
//  ViewController.swift
//  iOSNiubizIntegration
//
//  Created by Joseph on 6/05/21.
//

import UIKit
import VisaNetSDK

class ViewController: UIViewController, VisaNetDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.getStringData() { response in
            switch response {
            case .success(let token):
                self.presentVisa(with: token)
            case .failure(let error):
                print("Token error ", error)
            }
        }
        VisaNet.shared.delegate = self
    }
    
    func presentVisa(with token: String) {
        print("Generated token", token)
        Config.CE.dataChannel = .mobile
        Config.CE.countable = true
        Config.securityToken = token
        Config.merchantID = "456879852"
        Config.CE.purchaseNumber = "1790"
        Config.amount = 15.22
        Config.CE.endPointDevURL = "https://apisandbox.vnforappstest.com/"
        Config.CE.endPointProdURL = "https://apiprod.vnforapps.com/"
        Config.PINSHA256DEV = "sha256/w+9oxEkAQVM2aZGzmUYiTP2L2VA0JnxqIvH2e/HPhV0=edit"
        Config.PINSHA256PROD = "sha256/w+9oxEkAQVM2aZGzmUYiTP2L2VA0JnxqIvH2e/HPhV0=edit"
        Config.CE.FirstNameField.defaultText = "Juan"
        Config.CE.LastNameField.defaultText = "Perez"
        Config.CE.EmailField.defaultText = "jperez@test.com"
        print("Opening payment form")
        _ = VisaNet.shared.presentVisaPaymentForm(viewController: self)
    }
    
    @objc func registrationDidEnd(serverError: Any?, responseData: Any?) {
        if serverError == nil {
            print("OK")
        } else {
            print("Payment form error ", serverError!)
        }
    }
}
