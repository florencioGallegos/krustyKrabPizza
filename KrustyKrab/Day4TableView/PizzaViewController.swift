//
//  PizzaViewController.swift
//  Day4TableView
//
//  Created by MAC Consultant on 2/25/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import UIKit



class PizzaViewController: UIViewController {

  //  @IBOutlet weak var pizzaToppingImage: UIImageView!
    @IBOutlet var pizzaToppingLabel: UILabel!
    
    @IBOutlet weak var pizzaToppingImage: UIImageView!
    
    var pizzaTopping = String()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if pizzaTopping == "pepperoni"
        {
        pizzaToppingImage.image = UIImage(named: "pepperoni.jpg")
        }
        pizzaToppingLabel.text = pizzaTopping
        
    // Do any additional setup after loading the view.
    }
    
    //@IBAction func backButton(_ sender: UIButton) {
   //}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    */
}
