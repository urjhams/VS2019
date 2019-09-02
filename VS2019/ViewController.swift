//
//  ViewController.swift
//  VS2019
//
//  Created by Quân Đinh on 28.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import SwiftCharts
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var legendCollectionView: UICollectionView!
    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var chartPoints: Array<ChartPoint> = [ChartPoint]()
    var chartXLabels = [ChartAxisValue]()
    var chartData: Array<FoodObject> = [FoodObject]()
    
    fileprivate var chart: Chart?
    
    let name = [
        "Calories from Fat",
        "total Fat",
        "Sodium",
        "Potasium",
        "total Carbon-hydrate",
        "Sugar",
        "Protein",
        "saturated Fat",
        "Cholesterol"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        legendCollectionView.delegate = self
        legendCollectionView.dataSource = self
        searchBar.delegate = self
        
        self.loadFullChartData()
        self.drawChart()
    }
    
    private func refreshArrays() {
        chartPoints = [ChartPoint]()
        chartXLabels = [ChartAxisValue]()
        chartData = [FoodObject]()
    }
    
    private func loadFullChartData() {
        refreshArrays()
        for obj in Static.calories {
            chartData.append(obj)
        }
    }
    
    private func drawChart() {
        // remove old chart if there is
        chartView.subviews.forEach {
            $0.removeFromSuperview()
        }
        // ---------------------------
        
        
        let labelDefaultSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont,
                                               fontColor: UIColor.black,
                                               rotation: 0,
                                               rotationKeep: ChartLabelDrawerRotationKeep.bottom,
                                               shiftXOnRotation: true,
                                               textAlignment: .default)
        
        var currentHorizontalPosition = 1
        var currentOrder = 0
        
        // add an empty point at 1st position
        chartPoints.append(ChartPoint(x: ChartAxisValueDouble(0),
                                      y: ChartAxisValueDouble(Double.greatestFiniteMagnitude)))
        chartXLabels.append(ChartAxisValueString("",
                                                 order: 0,
                                                 labelSettings: labelSettings.defaultVertical()))
        currentOrder += 1
        //----------------------------------
        
        for obj in chartData {
            chartPoints.append(ChartPoint(x: ChartAxisValueDouble(currentHorizontalPosition),
                                          y: ChartAxisValueDouble(obj.calories)))
            currentHorizontalPosition += 1
            chartXLabels.append(ChartAxisValueString(obj.name.components(separatedBy: ",")[0],
                                                     order: currentOrder,
                                                     labelSettings: labelSettings.defaultVertical()))
            currentOrder += 1
        }
        
        // add an empty point at last position
        chartPoints.append(ChartPoint(x: ChartAxisValueDouble(currentHorizontalPosition),
                                      y: ChartAxisValueDouble(Double.greatestFiniteMagnitude)))
        chartXLabels.append(ChartAxisValueString("",
                                                 order: currentOrder,
                                                 labelSettings: labelSettings.defaultVertical()))
        //-----------------------------------
        
        let generator = ChartAxisGeneratorMultiplier(20)
        let labelsGenerator = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "\(scalar)", settings: labelSettings)
        }
        
        let yModel = ChartAxisModel(firstModelValue: 0,
                                    lastModelValue: 220,
                                    axisTitleLabels: [ChartAxisLabel(text: "Calories",
                                                                     settings: labelDefaultSettings.defaultVertical())],
                                    axisValuesGenerator: generator,
                                    labelsGenerator: labelsGenerator)
        
        let xModel = ChartAxisModel(axisValues: chartXLabels)
        
        let chartFrame = ExamplesDefaults.chartFrame(chartView.frame)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings,
                                                               chartFrame: chartFrame,
                                                               xModel: xModel,
                                                               yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        // view generator - this is a function that creates a view for each chartpoint
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let viewSize: CGFloat = Env.iPad ? 100 : 100
            let center = chartPointModel.screenLoc
            let pointView = PieChartView(frame: CGRect(x: center.x - viewSize / 2,
                                                       y: center.y - viewSize / 2,
                                                       width: viewSize,
                                                       height: viewSize))
            
            let position = Int(chartPointModel.chartPoint.description.components(separatedBy: ",")[0])!
            
            if (position != 0 && position != self.chartXLabels.count - 1){
                let objs = self.chartData
                let foodObj = objs[position - 1]
                
                // data
                let caloriesFromFat = PieChartDataEntry(value: foodObj.caloriesFromFat, label: "calories from fat")
                let totalFat = PieChartDataEntry(value: foodObj.totalFat, label: "total fat")
                let sodium = PieChartDataEntry(value: foodObj.Sodium, label: "sodium")
                let potasium = PieChartDataEntry(value: foodObj.potasium, label: "potasium")
                let totalCarbonHydrate = PieChartDataEntry(value: foodObj.totalCarboHydrate, label: "total Carbon-hydrate")
                let sugars = PieChartDataEntry(value: foodObj.sugars, label: "sugars")
                let protein = PieChartDataEntry(value: foodObj.protein, label: "protein")
                let saturatedFat = PieChartDataEntry(value: foodObj.saturatedFat, label: "saturated fat")
                let cholesterol = PieChartDataEntry(value: foodObj.cholesterol, label: "cholesterol")
                
                let data = [caloriesFromFat,
                            totalFat,
                            sodium,
                            potasium,
                            totalCarbonHydrate,
                            sugars,
                            protein,
                            saturatedFat,
                            cholesterol]
                
                let dataSet = PieChartDataSet(entries: data, label: nil)
                let chartData = PieChartData(dataSet: dataSet)
                chartData.setValueTextColor(NSUIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0))
                dataSet.colors = Helper.colorArray
                
                pointView.legend.enabled = false
                pointView.drawHoleEnabled = false
                pointView.highlightPerTapEnabled = false
                pointView.data = chartData
                
                let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap(sender:)))
                doubleTap.numberOfTapsRequired = 2
                pointView.addGestureRecognizer(doubleTap)
            }
            
            return pointView
            
        }
        
        // create layer that uses viewGenerator to display chartpoints
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis,
                                                     yAxis: yAxisLayer.axis,
                                                     chartPoints: chartPoints,
                                                     viewGenerator: viewGenerator,
                                                     mode: .translate)
        
        // create chart instance with frame and layers
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                lineLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer),
                chartPointsLayer
            ]
        )
        
        chartView.addSubview(chart.view)
        self.chart = chart
    }
    
    private func lineLayer(xAxisLayer: ChartAxisLayer, yAxisLayer: ChartAxisLayer) -> ChartGuideLinesDottedLayer{
        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        return ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer,
                                                         yAxisLayer: yAxisLayer,
                                                         settings: guidelinesLayerSettings)
    }
    
    @objc func doubleTap(sender: UIGestureRecognizer) {
        if let view = sender.view as? PieChartView {
            let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup") as! PopUpViewController
            destination.chartData = (view.data as! PieChartData)
            self.present(destination, animated: true, completion: nil)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "legnedCell", for: indexPath) as! LegendCollectionViewCell
        cell.colorImg.backgroundColor = Helper.colorArray[indexPath.item]
        cell.nameText.text = name[indexPath.item]
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.loadFullChartData()
            self.drawChart()
        } else {
            refreshArrays()
            for obj in Static.calories {
                if let text = searchBar.text {
                    if obj.name.lowercased().contains(text.lowercased()) {
                        chartData.append(obj)
                    }
                }
            }
            drawChart()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.endEditing(true)
        return true
    }
}

