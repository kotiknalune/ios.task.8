//
//  DrawingsViewController.swift
//  RSSchool_T8
//
//  Created by Katya Railian on 18.07.2021.
//

import UIKit

class DrawingsViewController: UIViewController {

    @objc var delegate:DrawingDelegate?
    var planetButton: Button?
    var headButton: Button?
    var treeButton: Button?
    var landscapeButton: Button?
    var currentButton:Int = 1
    var buttons: [Button?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.planetButton = Button.init(frame: CGRect(x: 88, y: 112, width: 200, height: 40))
        self.planetButton?.setTitle("Planet", for: .normal)
        self.headButton = Button.init(frame: CGRect(x: 88, y: 167, width: 200, height: 40))
        self.headButton?.setTitle("Head", for: .normal)
        self.treeButton = Button.init(frame: CGRect(x: 88, y: 222, width: 200, height: 40))
        self.treeButton?.setTitle("Tree", for: .normal)
        self.landscapeButton = Button.init(frame: CGRect(x: 88, y: 277, width: 200, height: 40))
        self.landscapeButton?.setTitle("Landscape", for: .normal)
        
        buttons = [planetButton, headButton, treeButton, landscapeButton];
        
        for button in buttons {
            button?.setupComponent()
            button?.addTarget(self, action: #selector(self.selectButton(sender:)), for: .touchUpInside)
            self.view.addSubview(button!)
        }
        self.navigationItem.title = "Drawings"
        setCurrentButtonStyle()
    }
    
    func setCurrentButtonStyle() {
        buttons[currentButton]?.layer.shadowColor = UIColor.init(named: "Light Green Sea")?.cgColor
        buttons[currentButton]?.layer.shadowOpacity = 1.0
    }
    
    @objc func selectButton(sender: Button){
        buttons[currentButton]?.layer.shadowColor = UIColor.init(named: "Black")?.cgColor
        buttons[currentButton]?.layer.shadowOpacity = 0.25
        buttons[currentButton]?.layer.borderWidth = 0

        switch sender.titleLabel!.text {
        case "Planet":
            delegate?.setDrawingPath?(0)
            currentButton = 0
            print(currentButton)
        case "Head":
            delegate?.setDrawingPath?(1)
            currentButton = 1
        case "Tree":
            delegate?.setDrawingPath?(2)
            currentButton = 2
        case "Landscape":
            delegate?.setDrawingPath?(3)
            currentButton = 3
        default:
            delegate?.setDrawingPath?(1)
            currentButton = 1
        }
        buttons[currentButton]?.layer.shadowColor = UIColor.clear.cgColor
        buttons[currentButton]?.layer.borderColor = UIColor.init(red: 151/256, green: 200/256, blue: 186/256, alpha: 1).cgColor
        buttons[currentButton]?.layer.borderWidth = 1
        setCurrentButtonStyle()
    }
}
