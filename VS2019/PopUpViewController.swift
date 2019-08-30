//
//  PopUpViewController.swift
//  VS2019
//
//  Created by Quân Đinh on 30.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import Charts

class PopUpViewController: UIViewController {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var chartView: PieChartView!
    var chartData: PieChartData?
    override func viewDidLoad() {
        super.viewDidLoad()
        frameView.layer.cornerRadius = 10
        frameView.layer.masksToBounds = true
        if let data = chartData {
            
            data.setValueFont(.systemFont(ofSize: 10, weight: .bold))
            data.setValueTextColor(.white)
            chartView.data = data
        }
        let legend = chartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 0
        chartView.animate(xAxisDuration: 1.4, easingOption: .linear)
    }
    

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
