//
//  TotalGraphView.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 8. 7..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import ScrollableGraphView

class TotalGraphView: UIView, ScrollableGraphViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGraph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGraph() {
        let graphView = ScrollableGraphView(frame: self.frame, dataSource: self)
        let linePlot = LinePlot(identifier: "line")
        let referenceLines = ReferenceLines()
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        self.addSubview(graphView)
    }
    
    let linePlotData = [10.0, 20.0, 30.0]
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "line":
            return linePlotData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return 3
    }
}
