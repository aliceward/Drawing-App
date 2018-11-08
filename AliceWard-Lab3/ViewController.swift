//
//  ViewController.swift
//  AliceWard-Lab3
//
//  Created by Alice Ward on 10/1/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentLine:Line?
    var drawCanvas:DrawingView!
    var currentColor = UIColor(red:0.95, green:0.48, blue:0.47, alpha:1.0)
    var sliderValue = CGFloat(25)

    //Creative Portion
    @IBAction func randomPressed(_ sender: Any) {
        let red = Double(arc4random_uniform(11))/10
        let green = Double(arc4random_uniform(11))/10
        let blue = Double(arc4random_uniform(11))/10
        currentColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        currentLine?.color = currentColor
    }
    
    @IBOutlet weak var stencil: UIImageView!
    @IBAction func stencilPressed(_ sender: Any) {
        let num = arc4random_uniform(5)
        if num == 0 {
            stencil.image = UIImage(named: "smile")
        } else if num == 1 {
            stencil.image = UIImage(named: "cat")
        } else if num == 2 {
            stencil.image = UIImage(named: "turtle")
        } else if num == 3 {
            stencil.image = UIImage(named: "flower")
        } else {
            stencil.image = UIImage(named: "octopus")
        }
    }
    
    //Change Colors
    @IBAction func redButton(_ sender: Any) {
        currentColor = UIColor(red:0.99, green:0.50, blue:0.49, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func orangeButton(_ sender: Any) {
        currentColor = UIColor(red:0.99, green:0.57, blue:0.15, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func yellowButton(_ sender: Any) {
        currentColor = UIColor(red:1.00, green:0.97, blue:0.22, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func greenButton(_ sender: Any) {
        currentColor = UIColor(red:0.47, green:0.97, blue:0.50, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func blueButton(_ sender: Any) {
        currentColor = UIColor(red:0.48, green:0.84, blue:0.99, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func purpleButton(_ sender: Any) {
        currentColor = UIColor(red:0.48, green:0.52, blue:0.99, alpha:1.0)
        currentLine?.color = currentColor
    }
    @IBAction func pinkButton(_ sender: Any) {
        currentColor = UIColor(red:0.99, green:0.54, blue:0.99, alpha:1.0)
        currentLine?.color = currentColor
    }
    
    //Change width to slider value
    @IBAction func sliderMoved(_ sender: UISlider) {
        sliderValue = CGFloat(sender.value)
        currentLine?.width = CGFloat(sliderValue)
    }
    
    //Clear and Undo
    @IBAction func clearPressed(_ sender: Any) {
        drawCanvas.theLine = nil
        drawCanvas.lines = []
        stencil.image = nil
    }
    @IBAction func undoPressed(_ sender: Any) {
        if (!drawCanvas.lines.isEmpty) {
            drawCanvas.theLine = nil
            drawCanvas.lines.remove(at: drawCanvas.lines.count-1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawCanvas = DrawingView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
        view.addSubview(drawCanvas)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let touchPoint = touches.first?.location(in: view) else {return}
        currentLine = Line(points: [touchPoint], width: sliderValue, color: currentColor)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else {return}
        currentLine?.points.append(touchPoint)
        drawCanvas.theLine = currentLine
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else {return}
        currentLine?.points.append(touchPoint)
        drawCanvas.theLine = currentLine
        if let newLine = currentLine{
            drawCanvas.lines.append(newLine)
        }
        currentLine = nil
    }


}

