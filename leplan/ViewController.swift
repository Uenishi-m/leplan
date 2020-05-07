//
//  ViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/04/04.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var sightlist = [["name":"仙台駅","latitude": 38.2739452,"longitude":140.8530336],
                     ["name":"青葉城跡","latitude":38.252796,"longitude":140.8474116],
                     ["name":"瑞鳳殿","latitude":38.2504786,"longitude":140.8579106],
                     ["name":"松島","latitude":38.3680527,"longitude":141.0500819]]
 
    var label = ["false","false","false","false"]
    var spots = [[String:Any]]()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view
        //tableView.dateSource = self
        //tableView.delegate = self
        //tableView.allowsMultipleSelection = true
        
       }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sightlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel!.text = sightlist[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(sightlist[indexPath.row])
        //print(label[indexPath.row])
        
        if label[indexPath.row] == "false"{
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            label[indexPath.row] = "true"
            
        }else if label[indexPath.row] == "true"{
            
            let cell = tableView.cellForRow(at : indexPath)
            cell?.accessoryType = .none
            label[indexPath.row] = "false"
        }
        
        //print(label)
        var pins = [[String:Any]]()
        
        
       
        
        for i in 0..<sightlist.count{
            
            if label[i] == "true"{
                
                pins.append(sightlist[i])
            }
        }
        print(pins)
        
        spots = pins
    }
    
    
    
    @IBAction func goMapButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "gomap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "gomap"{
            
            let nextVC = segue.destination as! MapViewController
            
            //var b = "hogehoge"
            
            nextVC.spots = spots
            
           /*for i in 0..<pins.count{
                nextVC.spots.append = self.pins[i]
        }*/
    }
    
    
    /*func tableView(_ tableView: UITableView, didDeselectRowAt indexPath:IndexPath){
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .none
    }*/
    
}
}
