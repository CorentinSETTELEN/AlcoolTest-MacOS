//
//  TagAlcoolViewController.swift
//  Baston
//
//  Created by Corentin on 02/02/2020.
//  Copyright © 2020 Corentin. All rights reserved.
//

import UIKit

class TagAlcoolViewController: UIViewController {

    @IBOutlet weak var alcoolMessage: UILabel!
    @IBOutlet weak var alcoolView: UIView!
    @IBOutlet weak var scrollGlobalView: UIScrollView!
    
    @IBOutlet weak var beerView: UIView!
    @IBOutlet weak var cocktailView: UIView!
    @IBOutlet weak var vodkaView: UIView!
    @IBOutlet weak var champagneView: UIView!
    
    
    var datasend = ""
    var objectalcool: [String: Any] = [:] // Recupere les données JSON
    
    static var listtagalcool = [TagAlcool]()
    var tagalcoolselect: Int = 0
    
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    
    var listNameTag = ["Biere","Cocktail","Vodka","Champagne"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        initializeEventView()
        
        
        print(getJsonValue(filename:"alcool"))
        
        for (tagindex, tagelement) in objectalcool.enumerated() {
            // Definis les categories

            let tagalcool = (tagelement.value as? [String: Any])!
            let taglist = (tagalcool["list"] as? [String: Any])!
            let tagalcoolobject = TagAlcool(nom: tagalcool["nom"] as! String , id: tagindex, red: tagalcool["red"] as! Int, green: tagalcool["green"] as! Int,blue: tagalcool["blue"] as! Int)
            
            for (index, element) in taglist.enumerated() {
                let alcool = (element.value as? [String: Any])!
                let alcoolobject = Alcool(nom: alcool["nom"] as! String, id: index, image: alcool["image"] as! String)
                tagalcoolobject.list.append(alcoolobject)
            }
            
            TagAlcoolViewController.listtagalcool.append(tagalcoolobject)
        }
        
    }
           
    
    @objc func displayTagAlcool(_ sender: UITapGestureRecognizer) {
        let tag = sender.view?.tag ?? 0
        let color = sender.view?.backgroundColor!
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        let name = listNameTag[tag]
        updateView(buttonname: name, buttontag: tag)
    }

    
    func updateView(buttonname: String, buttontag: Int){
        
        print(TagAlcoolViewController.listtagalcool[0].nom)
        print(TagAlcoolViewController.listtagalcool[0].list[0].nom)
        print(buttontag)
        
        if TagAlcoolViewController.listtagalcool.indices.contains(buttontag){
            
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

    func initializeEventView(){
        let gestureBeer = UITapGestureRecognizer(target: self, action:#selector(displayTagAlcool))
        self.beerView.addGestureRecognizer(gestureBeer)
        
        let gestureCocktail = UITapGestureRecognizer(target: self, action:#selector(displayTagAlcool))
        self.cocktailView.addGestureRecognizer(gestureCocktail)
        
        let gestureVodka = UITapGestureRecognizer(target: self, action:#selector(displayTagAlcool))
        self.vodkaView.addGestureRecognizer(gestureVodka)
        
        let gestureChampagne = UITapGestureRecognizer(target: self, action:#selector(displayTagAlcool))
        self.champagneView.addGestureRecognizer(gestureChampagne)
                
        // les 3 autres
    }
    
    
}
