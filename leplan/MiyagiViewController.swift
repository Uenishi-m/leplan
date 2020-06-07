//
//  MiyagiViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/29.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//
import UIKit

class MiyagiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

    private var myTableView:UITableView!
     
     var regionlist = ["仙台","白石・蔵王","鳴子・大崎","松島・塩釜","石巻・気仙沼"]
     var listfir = [["name":"仙台駅","latitude":38.2601316 ,"longitude":140.8802488],
     ["name":"青葉城跡","latitude":38.252796,"longitude":140.8474116],
     ["name":"瑞鳳殿","latitude":38.2504786,"longitude":140.8579106],["name":"仙台市八木山動物公園","latitude":38.245601,"longitude":140.8446167],["name":"仙台うみの杜水族館","latitude":38.2711563,"longitude":140.9785234],["name":"秋保大滝","latitude":38.2749697,"longitude":140.60169]]
     var listsec = [["name":"御釜","latitude":38.1365139,"longitude":140.4472985],["name":"国営みちのく杜の湖畔公園","latitude":38.1853291,"longitude":140.669685],["name":"白石城","latitude":38.0026214,"longitude":140.6148314]]
    var listthird = [["name":"鳴子峡","latitude":38.7296499,"longitude":140.6885695],["name":"鳴子温泉郷","latitude":38.7297672,"longitude":140.6208829]]
    var listforth = [["name":"円通院","latitude":38.3712924,"longitude":141.0575943],["name":"松島湾","latitude":38.3713461,"longitude":141.0510443]]
    var listfifth = [["name":"石ノ森萬画館","latitude":38.3724994,"longitude":141.0662455],["name":"田代島","latitude":38.2986975,"longitude":141.4004581],["name":"金華山","latitude":38.291374,"longitude":141.5338155],["name":"御番所公園","latitude":38.2856026,"longitude":141.5157369]]
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
         
        listlist = [0:listfir,1:listsec,2:listthird,3:listforth,4:listfifth]
         
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
            controller.miyagichoosenindexpath = choosenindexpath
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
         }else if section == 2  && validsections.contains(section){
             return listthird.count
         }else if section == 3  && validsections.contains(section){
             return listforth.count
         }else if section == 4  && validsections.contains(section){
             return listfifth.count
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
         }else if indexPath.section == 3 && validsections.contains(indexPath.section){
             cell.textLabel?.text = listforth[indexPath.row]["name"] as? String
         }else if indexPath.section == 4 && validsections.contains(indexPath.section){
             cell.textLabel?.text = listfifth[indexPath.row]["name"] as? String
         }
        
         cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
         cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
         cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
         
         return cell
     }
     
    @IBAction func toMapAction(_ sender: Any) {
        performSegue(withIdentifier: "MiyagiToMap", sender: nil)
        choosenindexpath = [IndexPath]()
        spots = [[String:Any]]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MiyagiToMap"{
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
