//
//  DrawingView.swift
//  AliceWard-Lab3
//
//  Created by Alice Ward on 10/2/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    //Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var theLine:Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    var lines: [Line] = [] {
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    func drawLine(_ line: Line){
        line.color.setFill()
        let path = createQuadPath(points: line.points)
        path.lineWidth = line.width
        line.color.setStroke()
        path.stroke()
    }
    
    //Midpoint Function
    func midpoint(first: CGPoint, second: CGPoint) -> CGPoint{
        let x = (first.x+second.x)/2
        let y = (first.y+second.y)/2
        return CGPoint(x: x, y: y)
    }

    //Given code from lab assignment to smooth lines
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addQuadCurve(to: secondPoint, controlPoint: firstMidpoint)
        path.lineCapStyle = .round
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
    
    override func draw(_ rect: CGRect){
        for line in lines {
            drawLine(line)
        }
        if theLine != nil {
            drawLine(theLine!)
        }
    }
    
    
    
}
