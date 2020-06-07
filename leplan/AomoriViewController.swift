//
//  AomoriViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/30.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class AomoriViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

     private var myTableView:UITableView!
        
        var regionlist = ["津軽","下北","南部"]
        var listfir = [["name":"ねぶたの家 ワ・ラッセ","latitude":40.8294877 ,"longitude":140.7346629],
        ["name":"青森県立美術館","latitude":40.807354,"longitude":140.6984913],
        ["name":"弘前公園","latitude":40.6077107,"longitude":140.4621788],
        ["name":"浅虫水族館","latitude":40.897504,"longitude":140.8605891],
        ["name":"立佞武多の館","latitude":40.8109542,"longitude":140.4411462],
        ["name":"太宰治記念館「斜陽館」","latitude":40.9026375,"longitude":140.4530499],
        ["name":"津軽三味線会館","latitude":40.9030736,"longitude":140.4519183],
        ["name":"千畳敷海岸","latitude":40.7678264,"longitude":140.0498574],]
        var listsec = [["name":"恐山","latitude":41.3083916,"longitude":141.0530363],["name":"仏ヶ浦","latitude":41.3117063,"longitude":140.8020555],["name":"尻屋崎灯台","latitude":41.4093606,"longitude":141.4102197],["name":"大間崎","latitude":41.543875,"longitude":140.9089683]]
      var listthird = [["name":"種差海岸","latitude":40.4996552,"longitude":141.5884434],["name":"八食センター","latitude":40.5266122,"longitude":141.4509661],["name":"奥入瀬渓流","latitude":40.5645132,"longitude":140.9567031],["name":"十和田市現代美術館","latitude":40.6140962,"longitude":141.206950],["name":"青函連絡船メモリアルシップ","latitude":40.8316936,"longitude":140.7343003],["name":"青森県立三沢航空科学館","latitude":40.708236,"longitude":41.3882953]]
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
            
            listlist = [0:listfir,1:listsec,3:listthird]
            
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
               controller.aomoriChoosenindexpath = choosenindexpath
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
            
            if section == 0 && validsections.contains(section){
                return listfir.count
            }else if section == 1  && validsections.contains(section){
                return listsec.count
            }else if section == 2 && validsections.contains(section){
                return listthird.count
            }else{
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
            
            if indexPath.section == 0  && validsections.contains(indexPath.section){
                cell.textLabel?.text = listfir[indexPath.row]["name"] as? String
            }else if indexPath.section == 1 && validsections.contains(indexPath.section){
                cell.textLabel?.text = listsec[indexPath.row]["name"] as? String
            }else if indexPath.section == 2 && validsections.contains(indexPath.section){
                cell.textLabel?.text = listthird[indexPath.row]["name"] as? String
            }
           
            cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
            cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
            cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
            
            return cell
        }
    
    @IBAction func toMap(_ sender: Any) {
        performSegue(withIdentifier: "AomoritoMap", sender: nil)
               choosenindexpath = [IndexPath]()
               spots = [[String:Any]]()
           }
           
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "AomoritoMap"{
                   let nextVC = segue.destination as! MapViewController
                   nextVC.spotsfin = spots
                   //nextVC.startingpoint=startingpoint
                   nextVC.start=start
                   
               }
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
