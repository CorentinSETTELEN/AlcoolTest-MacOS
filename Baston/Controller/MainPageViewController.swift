//
//  MainPageViewController.swift
//  Baston
//
//  Created by Corentin on 23/01/2020.
//  Copyright © 2020 Corentin. All rights reserved.
//

import UIKit
import Foundation


class MainPageViewController: UIViewController {

    var datasend = ""
    var objectalcool: [String: Any] = [:] // Recupere les données JSON
    
    static var listtagalcool = [TagAlcool]()
    var tagalcoolselect: Int = 0
    
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        
//        print(getJsonValue(filename:"alcool"))
//        
//        for (tagindex, tagelement) in objectalcool.enumerated() {
//            // Definis les categories
//
//            let tagalcool = (tagelement.value as? [String: Any])!
//            let taglist = (tagalcool["list"] as? [String: Any])!
//            let tagalcoolobject = TagAlcool(nom: tagalcool["nom"] as! String , id: tagindex, red: tagalcool["red"] as! Int, green: tagalcool["green"] as! Int,blue: tagalcool["blue"] as! Int)
//            
//            for (index, element) in taglist.enumerated() {
//                let alcool = (element.value as? [String: Any])!
//                // let alcoolobject = Alcool(nom: alcool["nom"] as! String, id: index)
//                tagalcoolobject.list.append(alcoolobject)
//            }
//            
//            MainPageViewController.listtagalcool.append(tagalcoolobject)
//        }
//        
        // print(listtagalcool[0].nom)
        // print(listtagalcool[0].list[0].nom)

    }
    
    @IBAction func cocktailButton(_ TheButton: UIButton) {
        
        let ab = TheButton.backgroundColor!

        ab.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        updateView(buttonname: TheButton.titleLabel!.text!, buttontag: Int(TheButton.tag))
    }
    
    func updateView(buttonname: String, buttontag: Int){
        
        print(MainPageViewController.listtagalcool[0].nom)
        print(MainPageViewController.listtagalcool[0].list[0].nom)
        print(buttontag)
        
        if MainPageViewController.listtagalcool.indices.contains(buttontag){
            
            self.tagalcoolselect = buttontag
            self.datasend = buttonname
            self.performSegue (withIdentifier: "infopage", sender: self)
            
        }else{
            print("alcool introuvable dans le json")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "infopage" {
            let vc = segue.destination as! InformationAlcoolViewController
            vc.alcooltype = self.datasend
            
            // let rgb: Double = 255
            // let red: Double = self.alcoolselect["red"]! as! Double
            // let green: Double = self.alcoolselect["blue"]! as! Double
            // let blue: Double = self.alcoolselect["green"]! as! Double
        
            vc.color["Red"] =  Double(self.red)
            vc.color["Green"] = Double(self.green)
            vc.color["Blue"] = Double(self.blue)
            
            vc.tagalcoolselect = tagalcoolselect
        }
    }
    
    func getJsonValue(filename:String)->Bool {
         do {
               if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                   let data = try Data(contentsOf: file)
                   let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                   if let object = json as? [String: Any] {
                       // json is a dictionary
                    self.objectalcool = object
                       return true
                   }// else if let object = json as? [Any] {
                       // json is an array
                    // self.objectalcool = object
                      // return true
               //    }
               else {
                       print("JSON is invalid")
                       return false
                   }
               } else {
                   print("no file")
                   return false
               }
           } catch {
               print(error.localizedDescription)
           }
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
