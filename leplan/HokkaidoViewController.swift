//
//  HokkaidoViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/29.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class HokkaidoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate{
    
    
    private var myTableView:UITableView!
    
    var regionlist = ["札幌エリア","小樽・余市・積丹エリア","ニセコ・洞爺・登別エリア","函館エリア","富良野・美瑛・旭川エリア","稚内・利尻・礼文エリア","帯広・十勝エリア","網走・知床エリア","釧路・阿寒エリア"]
    var listfir = [["name":"大通公園","latitude":43.0596959 ,"longitude":141.345453],
    ["name":"さっぽろテレビ塔","latitude":43.0611047,"longitude":141.3542359],
    ["name":"JRタワー展望室T38","latitude":43.0683639,"longitude":141.3488419],["name":"北海道庁旧本庁舎","latitude":43.0637576,"longitude":141.3461078],["name":"札幌市時計台","latitude":43.062562,"longitude":141.3514613],["name":"サッポロビール博物館","latitude":43.0714671,"longitude":141.3667237],["name":"札幌市円山動物園","latitude":43.0514641,"longitude":141.3056561],["name":"大倉山展望台","latitude":43.0508527,"longitude":141.2857884],["name":"白い恋人パーク","latitude":43.0889167,"longitude":141.2695557],["name":"藻岩山","latitude":43.0230796,"longitude":141.3136128],["name":"さっぽろ羊ヶ丘展望台","latitude":42.9990682,"longitude":141.3923186],["name":"千歳アウトレットモール・レラ","latitude":42.8114877,"longitude":141.6733801],["name":"新千歳空港","latitude":42.7821844,"longitude":141.6868587]]
    var listsec = [["name":"小樽運河","latitude":43.1989788,"longitude":141.0002459],["name":"青の洞窟","latitude":43.2137003,"longitude":140.9152414],["name":"ニッカウヰスキー余市蒸溜所","latitude":43.185662,"longitude":140.7875324]]
    var listthird = [["name":"登別温泉","latitude":42.4984281,"longitude":141.109832],["name":"のぼりべつ クマ牧場","latitude":42.492857,"longitude":141.1423418],["name":"登別マリンパークニクス","latitude":42.4547242,"longitude":141.1802575],["name":"室蘭港","latitude":42.3501151,"longitude":140.9503832],["name":"洞爺湖","latitude":42.6099672,"longitude":140.7087091],["name":"洞爺湖温泉","latitude":42.5705895,"longitude":140.7776995],["name":"レイクトーヤランチ","latitude":42.5939807,"longitude":140.7778213],["name":"羊蹄山","latitude":42.8269741,"longitude":140.7893114],["name":"第2有島ダチョウ牧場","latitude":42.781134,"longitude":140.7295495],["name":"Youtei Outdoor","latitude":42.8824618,"longitude":140.775509],["name":"ニセコ温泉郷","latitude":42.8814113,"longitude":140.7099986]]
    var listforth = [["name":"函館山","latitude":41.7592923,"longitude":140.6864074],["name":"函館ハリストス正教会","latitude":41.7628007,"longitude":140.7099986],["name":"旧函館区公会堂","latitude":41.7650242,"longitude":140.7067455],["name":"金森赤レンガ倉庫","latitude":41.7661566,"longitude":140.714371],["name":"五稜郭公園","latitude":41.7946274,"longitude":140.7492645],["name":"湯の川温泉","latitude":41.7774748,"longitude":140.7832829],["name":"トラピスチヌ修道院","latitude":41.787636,"longitude":140.8197592]]
    var listfifth = [["name":"旭川市旭山動物園","latitude":41.787636,"longitude":140.8197592],["name":"層雲峡","latitude":43.6834719,"longitude":142.7452821],["name":"層雲峡温泉","latitude":43.6777617,"longitude":142.8720982],["name":"大雪山国立公園","latitude":43.6839984,"longitude":142.7787287],["name":"パッチワークの路","latitude":43.6034554,"longitude":142.4513302],["name":"青い池","latitude":43.4935017,"longitude":142.6119378],["name":"ファーム富田","latitude":43.4134694,"longitude":142.4304545],["name":"雲海テラス","latitude":43.0884394,"longitude":142.8323042],["name":"北竜町ひまわりの里","latitude":43.7412634,"longitude":141.8691657]]
    var listsixth = [["name":"宗谷岬","latitude":45.522078,"longitude":141.9348204],["name":"利尻島","latitude":45.1785109,"longitude":141.9348204],["name":"礼文島","latitude":45.522078,"longitude":141.9348204]]
    var listseventh = [["name":"十勝川温泉","latitude":42.945781,"longitude":143.2645786],["name":"池田ワイン城","latitude":42.9191135,"longitude":143.4556315],["name":"パラグライディング十勝","latitude":42.7522585,"longitude":143.739486],["name":"ばんえい十勝 帯広競馬場","latitude":42.9210643,"longitude":143.1800465],["name":"十勝牧場","latitude":43.0043397,"longitude":142.6110323],["name":"タウシュベツ川橋梁","latitude":43.415497,"longitude":143.1872358]]
    var listeigth = [["name":"メルヘンの丘","latitude":43.9229281,"longitude":144.1884528],["name":"博物館網走監獄","latitude":43.9962498,"longitude":144.2274295],["name":"能取湖","latitude":44.0586884,"longitude":144.0777278],["name":"知床ネイチャークルーズ","latitude":44.0180658,"longitude":145.1898283],["name":"知床国立公園","latitude":44.1440529,"longitude":145.1355771],["name":"流氷砕氷船ガリンコ号Ⅱ","latitude":44.334391,"longitude":143.3726012]]
    var listninth = [["name":"釧路湿原国立公園","latitude":43.1390186,"longitude":144.4436145],["name":"鶴居・伊藤タンチョウサンクチュアリ","latitude":43.2281639,"longitude":144.3291873],["name":"阿寒湖温泉","latitude":43.4510375,"longitude":144.0307345],["name":"阿寒湖アイヌコタン","latitude":43.4336471,"longitude":144.0876644],["name":"阿寒湖","latitude":43.4559395,"longitude":144.0636577],["name":"摩周湖","latitude":43.5791462,"longitude":144.4688458],]
    var label:[Bool] = []
    var listlist:[Int:[[String:Any]]] = [:]
    var spots = [[String:Any]]()
    var start = [String:Any]()
    var choosenindexpath = [IndexPath]()
    
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("hokkaidostart\(start)")
        print("hokkaidospots\(spots)")
        
       
        
        listlist = [0:listfir,1:listsec,2:listthird,3:listforth,4:listfifth,5:listsixth,6:listseventh,7:listeigth,8:listninth]
        
        for i in 0..<regionlist.count{
            label.append(false)
        }
        self.navigationController!.navigationBar.tintColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        self.view.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        
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
        
        //let preNC = self.presentingNavigationController  as! UINavigationController
        //let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! PreviousViewController
        //preVC.spots = self.spots  //ここで値渡し
        navigationController?.delegate = self
        
        
    }
    /*override func viewWillAppear(_ animated: Bool) {
        myTableView.selectRow =
       
    }*/
    func navigationController(_ navigationController:UINavigationController,willShow viewController : UIViewController,animated:Bool){
        if let controller = viewController as? PrefectureViewController{
            controller.spots = spots
            //spots = [[String:Any]]()
            controller.hokkaidochoosenindexpath = choosenindexpath
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
        /*for i in 0..<choosenindexpath.count{
            var cell = tableView.cellForRow(at: choosenindexpath[i])
            cell?.accessoryType = .checkmark
        }*/
        //myTableView.reloadData()
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
        print("hokkaido\(spots)")
        
        var deleteindexpath = choosenindexpath.firstIndex(of: indexPath)
        choosenindexpath.remove(at:deleteindexpath!)
        print(choosenindexpath)
       // myTableView.reloadData()
        
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
        }else if section == 5  && validsections.contains(section){
            return listsixth.count
        }else if section == 6  && validsections.contains(section){
            return listseventh.count
        }else if section == 7  && validsections.contains(section){
            return listeigth.count
        }else if section == 8  && validsections.contains(section){
            return listninth.count
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
        }else if indexPath.section == 5 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listsixth[indexPath.row]["name"] as? String
        }else if indexPath.section == 6 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listseventh[indexPath.row]["name"] as? String
        }else if indexPath.section == 7 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listeigth[indexPath.row]["name"] as? String
        }else if indexPath.section == 8 && validsections.contains(indexPath.section){
            cell.textLabel?.text = listninth[indexPath.row]["name"] as? String
        }
        
        cell.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell.textLabel!.font = UIFont(name: "Avenir", size: 20.0)
        cell.textLabel!.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        
        return cell
    }
    
    
    @IBAction func goMapAction(_ sender: Any) {
        performSegue(withIdentifier: "HokkaidoToMap", sender: nil)
        choosenindexpath = [IndexPath]()
        spots = [[String:Any]]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HokkaidoToMap"{
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


