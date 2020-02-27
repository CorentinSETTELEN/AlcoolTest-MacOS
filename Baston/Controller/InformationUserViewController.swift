//
//  InformationUserViewController.swift
//  Baston
//
//  Created by Corentin on 30/01/2020.
//  Copyright © 2020 Corentin. All rights reserved.
//

import UIKit

class InformationUserViewController: UIViewController {

    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var genderText: UILabel!
    
    @IBOutlet weak var sliderWeight: UISlider!
    @IBOutlet weak var weightText: UILabel!
    
    @IBOutlet weak var sliderLaunch: UISlider!
    @IBOutlet weak var launchText: UILabel!
    
    @IBOutlet weak var alcoolView: UIView!
    
    @IBOutlet weak var alcoolMessage: UILabel!
    
    @IBOutlet weak var scrollGlobalView: UIScrollView!
    
    var isFemale:Bool = false
    
    @IBAction func genderEvent(_ sender: UISwitch) {
        let value = sender.isOn
        var text = "Femme"
        if value {
            text = "Homme"
        }
        genderText.text = text
    }
    
    @IBAction func weightEvent(_ sender: UISlider) {
        let weight = 40 + Int(sender.value * 10)
        weightText.text = String(weight) + " kg"
    }
    
    @IBAction func launchEvent(_ sender: UISlider) {
        launchText.text = getLaunchType(slider: sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        defineValidAlcool()
        // Do any additional setup after loading the view.
    }
    
    func defineValidAlcool(){
        var heightView = 0
        var nbr = 1
        let taglistalcool = TagAlcoolViewController.listtagalcool
        for (_, tagalcool) in taglistalcool.enumerated(){
            for (index, alcool) in tagalcool.list.enumerated(){
                if alcool.nombre > 0{
                    print(alcool.nom)
                    generateAlcoolView(heightView: heightView, alcool: alcool, index: nbr)
                    nbr = nbr + 1
                    heightView = 120 + heightView
                }
            }
        }
        
        if heightView == 0{
            alcoolMessage.text = "Aucun Alcool"
        }else{
            alcoolMessage.text = "Alcool"
        }
    }
    
    func generateAlcoolView(heightView: Int, alcool: Alcool, index: Int){
        var newView: UIView!
        let widthView = Double(alcoolView.frame.width)
        let height = Double(heightView)
        // let index = index + 1
        newView = UIView(frame: CGRect(x: 0, y: height, width: widthView, height: 120))
        
        if( index % 2 == 0 ){ // Un sur deux coloré
           let red = Double(206) / 255
           let green = Double(191) / 255
           let blue = Double(26) / 255
           newView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        }
               
        print(index)
        newView.viewWithTag(index)
        alcoolView.addSubview(newView)
        
        
        // TEXT : Nom de l'alcool
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        label.text = alcool.nom + " : " + String(alcool.nombre)
        label.font = label.font.withSize(40)
        label.tag = index
        label.sizeToFit()
        newView.addSubview(label)
        
        let image  = UIImageView(frame:CGRect(x: newView.frame.size.width - 100, y: 0, width: 0, height: 0))
        image.image = UIImage(named:alcool.image)
        image.sizeToFit()
        newView.addSubview(image)
        
        // view.isUserInteractionEnabled = true
        
        let txtLabel: UILabel = UILabel(frame: CGRect(x: 5, y: 90, width: 150, height: 90))
        txtLabel.font = UIFont(name: "Courier", size: 30)
        txtLabel.text = "Il y a"
        txtLabel.sizeToFit()
        newView.addSubview(txtLabel)
        
        let txtField: UITextField = UITextField(frame: CGRect(x: 120, y: 80, width: alcoolView.frame.size.width - 150, height: 60))
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .countDownTimer
        // datePickerView.countDownDuration = 0 // 60 = une minute
        datePickerView.tag = index
        datePickerView.addTarget(self, action: #selector(datePickerEventDuration), for: .valueChanged)

        txtField.inputView = datePickerView
        txtField.font = UIFont(name: "Courier", size: 50)
        txtField.placeholder = "00:00"
        // txtField.text = "non"
        txtField.tag = index
        txtField.sizeToFit()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        scrollGlobalView.addGestureRecognizer(tap)
        
        newView.addSubview(txtField)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        scrollGlobalView.endEditing(true)
    }
    
    @objc func datePickerEventDuration(datePicker: UIDatePicker){
        let parentView = datePicker
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let tag = datePicker.tag
        if let view = alcoolView as? UIView
        {
            for subview in view.subviews
            {
                    for subsubview in subview.subviews
                    {
                        if( subsubview.tag == tag ){
                            if let item = subsubview as? UITextField
                            {
                                item.text = dateFormatter.string(from: datePicker.date)
                            }
                        }
                    }
            }
        }
        
        // aaa?.backgroundColor = .green
        // scrollGlobalView.endEditing(true)
    }
    
    func getLaunchType(slider: Float)-> String{
        var launch = ""
        var imageName = "salade"
        
        switch slider {
        case _ where slider < 0.5:
            launch = "Ventre vide"
            imageName = ""
        case _ where slider < 1.5:
            launch = "Repas léger (300g)"
            imageName = ""
        case _ where slider < 2.5:
            launch = "Repas correct (500g)"
            imageName = ""
        case _ where slider < 3.5:
            launch = "Repas consistant (800g)"
            imageName = ""
        case _ where slider < 4.5:
            launch = "Gros repas (1000g)"
            imageName = ""
        case _ where slider < 5.5:
            launch = "Repas XXL (1500g)"
            imageName = ""
        default:
            print("this is impossible")
        }
        
        // sliderWeight.setThumbImage(UIImage(named: "salade"), for: UIControl.State.highlighted)
        // sliderLaunch.setThumbImage(UIImage(named: "salade"), for: UIControl.State.normal)
        
        // sliderLaunch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        
        // sliderLaunch.setThumbImage(thumbImage, for: UIControl.State.normal )

        return launch
    }
    


}
