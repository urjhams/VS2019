//
//  PopUpPickerViewController.swift
//  VS2019
//
//  Created by Quân Đinh on 01.09.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit

class PopUpPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var frameView: UIView!
    var value = 20
    var root:ViewController1!
    
    var pickerData = [
        20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,
        105,110,115,120,125,130,135,140,145,150,155,160,165,
        170,175,180,185,190,105,200
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        frameView.layer.cornerRadius = 10
        frameView.layer.masksToBounds = true
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        value = pickerData[row]
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickOK(_ sender: Any) {
        self.dismiss(animated: true) {
            self.root.calories = self.value
        }
    }
}
