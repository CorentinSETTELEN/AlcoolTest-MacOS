//
//  InformationAlcoolViewController.swift
//  Baston
//
//  Created by Corentin on 23/01/2020.
//  Copyright © 2020 Corentin. All rights reserved.
//

import UIKit

class InformationAlcoolViewController: UIViewController {

    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var informationView: UIView!
    
    var alcooltype = ""
    var color = [String:Double]()
    var listalcool: [String: Any] = [:]
    
    var listobject = [Alcool]()
    
    var tagalcoolselect: Int = 0
 
    var newImage : UIImageView!
    var newSlider: UISlider!
    
    @IBOutlet weak var uiSliderView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setBackground()
        
        // let button = UIButton(type: UIButton.ButtonType.system)
        // button.frame = CGRect(x: 0, y: 0, width: 0, height: 200)
        
        // button.backgroundColor = UIColor.green
        // button.leftAnchor.constraint(equalTo: informationView.leftAnchor)
        // button.rightAnchor.constraint(equalTo: informationView.rightAnchor)
        // button.translatesAutoresizingMaskIntoConstraints = false// button.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 0.0).isActive = true
        
        // button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        // button.setTitle("  All Hospitals/Clinics", forState: UIControlState.Normal)
        // button.setTitleColor(UIColor.black, for: .Normal)
        // button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.Left
        // informationView.addSubview(button)
        

        let tagalcool = TagAlcoolViewController.listtagalcool[tagalcoolselect]
        var heightView = 0
        
        print(tagalcool.list)
        
        for (index, alcool) in tagalcool.list.enumerated(){
            // let alcool = (element.value as? [String: Any])!
            // print(alcool.nom)
            generateViewAndElement(heightView: heightView, alcool: alcool, index: index)
            heightView = 120 + heightView
            // print(alcool)
             // print("Item \(index): \(element)")
         }

        // informationView.sizeToFit()
        informationView.frame.size.height = informationView.frame.size.height + 250
        // informationView.sizeToFit()
        informationView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func generateViewAndElement(heightView: Int, alcool: Alcool, index: Int){
        var newView: UIView!
        let widthView = Double(informationView.frame.width)
        let height = Double(heightView)
        // let index = index + 1
        newView = UIView(frame: CGRect(x: 0.0, y: height, width: widthView, height: 120))
        //newView.backgroundColor = UIColor.green
 
        if( index % 2 == 0 ){ // Un sur deux coloré
            let red = Double(TagAlcoolViewController.listtagalcool[tagalcoolselect].red ) / 255
            let green = Double(TagAlcoolViewController.listtagalcool[tagalcoolselect].green ) / 255
            let blue = Double(TagAlcoolViewController.listtagalcool[tagalcoolselect].blue ) / 255
            newView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        }
        
        // print(index)
        newView.viewWithTag(index)
        informationView.addSubview(newView)
        
        
        let label = UILabel(frame: CGRect(x: 125, y: 5, width: 300, height: 30))
         // label.center = CGPoint(x: 160, y: 285) Pour affichage plus un article
         // label.textAlignment = NSTextAlignment.center;
        label.text = alcool.nom
        label.font = label.font.withSize(40)
        // .viewWithTag(<#T##tag: Int##Int#>)
        newView.addSubview(label)
        
        newImage  = UIImageView(frame:CGRect(x: 0, y: 0, width: 120, height: 120))
        newImage.image = UIImage(named:alcool.image)
        newView.addSubview(newImage)
        
        newSlider = UISlider(frame:CGRect(x: 150, y: 80, width: widthView - 250, height: 20))
        newSlider.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        newSlider.maximumValue = 6
        newSlider.minimumValue = 0
        newSlider.value = Float(alcool.nombre)
        newSlider.tag = index
        newSlider.addTarget(self, action: #selector(userSlideEdit), for: .touchDragInside)
        
        newView.addSubview(newSlider)
        
        let txtField: UITextField = UITextField(frame: CGRect(x: widthView - 40, y: 40, width: 0, height: 0));
        // txtField.borderStyle = UITextField.BorderStyle.line
        txtField.keyboardType = .numberPad
        // txtField.text = "0"
        txtField.font = UIFont(name: "Courier", size: 50)
        txtField.placeholder = "0"
        if alcool.nombre > 0 {
            txtField.text = String(alcool.nombre)
        }

        txtField.tag = index
        // txtField.borderStyle = UITextField.BorderStyle.roundedRect
        txtField.sizeToFit()
        txtField.addTarget(self, action: #selector(userTextEdit), for: .editingChanged)
        // listtext.append(txt)
        newView.addSubview(txtField)

    }
    
    @objc func userSlideEdit(_ sender: UISlider) {
        let parentView = sender.superview
        //aaa?.backgroundColor = .green
        for subview in parentView!.subviews
        {
             if let item = subview as? UITextField
             {
                 item.text = String(Int(sender.value))
             }
        }
        
        TagAlcoolViewController.listtagalcool[tagalcoolselect].list[sender.tag].nombre = Int(sender.value)
    }
    
    @objc func userTextEdit(_ sender: UITextField) {
        // print(sender)
        // print(sender.text)
        
        var valueslider = 0
        if sender.text != ""{
            let text = String((sender.text?.last!)!)
            if text != "" && text != "0"{
                print(Int(text)!)
                if Int(text)! > 6{
                    sender.text = "6"
                    valueslider = 6
                }else{
                    sender.text = text
                    valueslider = Int(text)!
                }
                
            }else{
                sender.text = ""
            }
        }else{
            sender.text = ""
        }
        
        let parentView = sender.superview
        for subview in parentView!.subviews
        {
             if let item = subview as? UISlider
               {
                   item.setValue(Float(valueslider), animated: true)
                   
               }
        }
        
        parentView!.endEditing(true)
    }
    
    func setTitle(){
       if alcooltype == ""{
           self.titleTop.text = "undefined"
       }else{
           self.titleTop.text = alcooltype
       }
    }
    
    func setBackground(){
        view.backgroundColor = UIColor(red: CGFloat(self.color["Red"]!), green: CGFloat(self.color["Green"]!), blue: CGFloat(self.color["Blue"]!), alpha: 1.0)
    }

}
