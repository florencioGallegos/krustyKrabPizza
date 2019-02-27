//
//  KrustyKrabViewController.swift
//  Day4TableView
//
//  Created by Kevin Yu on 2/25/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

// JSON: JavaScript Object Notation

import UIKit

class KrustyKrabViewController: UIViewController {
    
     var gotToIndex:IndexPath!
    
    var tableView: UITableView!
    
    var bikiniBottomers = ["SpongeBob", "Sandy", "Patrick", "Plankton", "Mr. Krabs"]
    var imageNames = ["sponebob.jpg", "sandy.jpeg", "patrick.png", "plankton.jpg", "mrkrabs.png"]
    var pizzas = [Pizza]()
    
    override func loadView() {
        super.loadView()

        // create a tableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        // create constraints
        let topConstraint = NSLayoutConstraint(item: self.view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: tableView, attribute: .top,
                                               multiplier: 0.5, constant: 0.0)
        // nts: figure out what the 0.5 does.
        let leadingConstraint = NSLayoutConstraint(item: self.view, attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: tableView, attribute: .leading,
                                                   multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: tableView, attribute: .trailing,
                                                    multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: self.view, attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: tableView, attribute: .bottom,
                                                  multiplier: 1.0, constant: 0.0)
        // activate constraints
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // nib = NeXTSTEP Interface Builder file
        let nib = UINib(nibName: "BikiniBottomerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BikiniBottomerTableViewCell")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the JSON file as Data
        let bundle = Bundle.main
        let jsonPath = bundle.path(forResource: "pizzas", ofType: "json")
        let jsonURL = URL(fileURLWithPath: jsonPath!)
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData,
                                                            options: .mutableLeaves) as! [[String:Any]]
            
            for pizzaDict in jsonDict {
                let toppings = pizzaDict["toppings"] as! [String]
                let price = pizzaDict["price"] as? Int
                let pizza = Pizza.init(toppings: toppings, price: price)
                
                // add pizza to container to show in tableView
                pizzas.append(pizza)
            }
        }
        catch {
            print(error)
        }
        
        // create pizzas from the JSON
        // put pizzas in tableView
        
    }
}
/*
 IndexPath = two parts: section & row
 // examples: News Site
 SECTION A  (category)
    -> ROW 1    (items within category)
    -> ROW 2
    -> ROW 3
 SECTION B      (POLITICS)
    -> ROW 1
    -> ROW 2
 SECTION C      (SPORTS)
    -> ROW 1    (NBA)
    -> ROW 2    (NFL)
    -> ROW 3    (LoL)
    -> ROW 4
 SECTION D (no rows)
 SECTION E      (ENTERTAINMENT)
*/
extension KrustyKrabViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return self.pizzas.count
        }
        return bikiniBottomers.count
    }
    // customize each cell (item)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            // get a cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // customize my cell
            cell.textLabel?.text = bikiniBottomers[indexPath.row]
            cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
            
            // return cell
            return cell
        }
        else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikiniBottomerTableViewCell", for: indexPath) as! BikiniBottomerTableViewCell
            
            cell.label.text = bikiniBottomers[indexPath.row]
            cell.imageV.image = UIImage(named: imageNames[indexPath.row])
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = pizzas[indexPath.row].toppings.joined(separator: "\n")
            cell.textLabel?.numberOfLines = 0
            cell.imageView?.image = nil
            
            return cell
        }
    }
    
}


extension KrustyKrabViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        gotToIndex = indexPath
        performSegue(withIdentifier: "Pizza", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
        var destVC: PizzaViewController = segue.destination as! PizzaViewController
        destVC.pizzaTopping = pizzas[gotToIndex.row].toppings.joined(separator: "")
        
    }
        
        // when I select a pizza
        // display a new VC
        // with labels displaying
        // the toppings
        
        // if the toppings include pepperoni, also display a custom image
        // otherwise, just show the labels
    
}

