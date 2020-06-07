//
//  IbaragiViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class IbaragiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

 private var myTableView:UITableView!
    
    var regionlist = [""]
    var listfir = [["name":"竜神大吊橋","latitude":36.6828573 ,"longitude":140.4639862],
    ["name":"袋田の滝","latitude":36.7645529,"longitude":140.4050133],
    ["name":"茨城アサヒビール工場","latitude":35.9514854,"longitude":139.9656471],["name":"シャトーカミヤ","latitude":35.9775824,"longitude":140.2180715],["name":"牛久大仏","latitude":35.9826928,"longitude":141.0500819],["name":"国営ひたち海浜公園","latitude":36.4034211,"longitude":140.5959035],["name":"筑波山","latitude":36.2254393,"longitude":140.0725584],["name":"偕楽園","latitude":36.3726306,"longitude":140.4499932],["name":"日立駅","latitude":36.5908269,"longitude":140.6556598],["name":"大洗海岸","latitude":36.3139893,"longitude":140.5484971],["name":"かねふく 明太パーク大洗","latitude":36.3115146,"longitude":140.575887,],["name":"宇宙航空研究開発機構筑波宇宙センター","latitude":36.0655867,"longitude":140.1259232],["name":"つくばわんわんランド","latitude":36.2036856,"longitude":140.0730232],["name":"アクアワールド茨城県大洗水族館","latitude":36.3324113,"longitude":140.5917431],["name":"笠間美術の森公園","latitude":36.3720153,"longitude":140.2640683]]
    var listsec = [["name":"松島","latitude":38.3680527,"longitude":141.0500819],]
    var label:[Bool] = []
    var listlist:[Int:[[String:Any]]] = [:]
    var choosenlable:[Bool] = []
    var spots = [[String:Any]]()
    var start = [String:Any]()
    var choosenindexpath = [IndexPath]()
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("miyagistart\(start)")
        print("miyagispots\(spots)")
        
        listlist = [0:listfir]
        
        for i in 0..<regionlist.count{
            label.append(false)
        }
       
         self.view.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
       
       self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        // Do any additional setup after loading the view.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        

              // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView()

              // TableViewの生成( status barの高さ分ずらして表示 ).
        myTableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        
        myTableView.isScrollEnabled = true

              // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

              // DataSourceの設定をする.
        myTableView.dataSource = self

              // Delegateを設定する.
        myTableView.delegate = self
        
        myTableView.allowsMultipleSelection = true

              // Viewに追加する.
        self.view.addSubview(myTableView)
       
       navigationController?.delegate = self
    }
   
   func navigationController(_ navigationController:UINavigationController,willShow viewController : UIViewController,animated:Bool){
       if let controller = viewController as? PrefectureViewController{
           controller.spots = spots
           spots = [[String:Any]]()
           controller.ibaragiChoosenindexpath = choosenindexpath
        choosenindexpath = []
       }
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return regionlist.count
    }
       
    func tableView(_ tableView:UITableView,titleForHeaderInSection section:Int) -> String?{
        return regionlist[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section:Int) ->UIView?{
           let view = UITableViewHeaderFooterView()
           let gesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderDidTap(_:)))
           view.addGestureRecognizer(gesture)
           view.tag = section
           return view
    }
    
    var validsections:[Int] = []
    
    @objc func sectionHeaderDidTap(_ sender: UIGestureRecognizer) {
           validsections = []
           if let section = sender.view?.tag {
               //print(section)
               if label[section] == false{
                   label[section] = true
               }else if label[section] == true{
                   label[section] = false
               }
               //print(label)
           }
          
           for i in 0..<label.count{
               if label[i] == true{
                   validsections.append(i)
               }
           }
           //print("validsections\(validsections)")
           myTableView.reloadData()
       }
    
    func tableView(_ tableView :UITableView, didSelectRowAt indexPath:IndexPath){
        print(indexPath.section)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        choosenindexpath.append(indexPath)
        print(choosenindexpath)
        print(listlist[indexPath.section]![indexPath.row])
        spots.append(listlist[indexPath.section]![indexPath.row])
        print("spots\(spots)")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        var index:Int = 0
        for i in 0..<spots.count{
            if spots[i]["name"] as! String == listlist[indexPath.section]![indexPath.row]["name"] as! String{
                 index = i
            }
        }
        //print("index\(index)")
        spots.remove(at: index)
        print("miyagispots\(spots)")
       var deleteindexpath = choosenindexpath.firstIndex(of: indexPath)
       choosenindexpath.remove(at:deleteindexpath!)
       print(choosenindexpath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 /*&& validsections.contains(section)*/{
            return listfir.count
        }/*else if section == 1  && validsections.contains(section){
            return listsec.count
        }*/else{
            return 0
        }
        
    }
       
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell",for:indexPath)
       if choosenindexpath.contains(indexPath){
           cell.accessoryType = .checkmark
           myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
       }else{
           cell.accessoryType = .none
       }
        
        if indexPath.section == 0 /* && validsections.contains(indexPath.section)*/{
            cell.textLabel?.text = listfir[indexPath.row]["name"] as? String
        }/*else if indexPath.section == 1 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listsec[indexPath.row]["name"] as? String
        }*/
       
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    @IBAction func toMap(_ sender: Any) {
        performSegue(withIdentifier: "IbaragitoMap", sender: nil)
            choosenindexpath = [IndexPath]()
            spots = [[String:Any]]()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "IbaragitoMap"{
                let nextVC = segue.destination as! MapViewController
                nextVC.spotsfin = spots
                //nextVC.startingpoint=startingpoint
                nextVC.start=start
                
            }
        
    }
}
