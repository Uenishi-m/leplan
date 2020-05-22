//
//  StartingViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/08.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    
    private var myTextField:UITextField!
    private var myItems=[String]()
    private var myTableView:UITableView!
    private var myButton:UIButton!
    var startingpoint:String=""
    var keysfin = [String]()
    var keyfin=""
    let userDefault = UserDefaults.standard
    var listfin=[[String:Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.navigationItem.hidesBackButton=true
        self.view.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        
        //startLabelの設定と表示
        var width:Int=Int(view.bounds.width)
        var height:Int=Int(view.bounds.height)/10
        var x:Int=Int(view.bounds.width)/2-width/2
        var y:Int=Int(view.bounds.height)/10
        let startLabel:UILabel=UILabel(frame: CGRect(x:x, y:y, width: width, height: height))
        startLabel.text="ルートを追加"
        startLabel.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        startLabel.textColor=UIColor.black
        startLabel.textAlignment=NSTextAlignment.center
        self.view.addSubview(startLabel)
        
        //textFieldの設定と表示
        width=width-100
        y=y+height
        height=height/2
        x=Int(view.bounds.width)/2-width/2
        myTextField=UITextField(frame: CGRect(x: x, y: y, width: width, height: height))
        myTextField.placeholder="出発地を入力"
        myTextField.delegate=self
        myTextField.borderStyle = .roundedRect
        myTextField.clearButtonMode = .whileEditing
        self.view.addSubview(myTextField)
        
        //myButtonの設定
        y=y+height*2
        width=70
        let myrouteLabel=UILabel(frame: CGRect(x: 0, y: Double(y)*0.9, width: Double(view.bounds.width)-Double(width), height: 50.0))
        myButton=UIButton(frame: CGRect(x:Double(view.bounds.width)-Double(width), y: Double(y)*0.9, width: Double(width), height: 50.0))
        myrouteLabel.text = "保存済みのルート"
        myrouteLabel.backgroundColor = UIColor.brown
        myrouteLabel.textColor=UIColor.white
        myButton.setTitle("編集", for: .normal)
        myButton.backgroundColor=UIColor.brown
        myButton.addTarget(self, action: #selector(edit), for: .touchDown)
        self.view.addSubview(myrouteLabel)
        self.view.addSubview(myButton)
    
        
        
        
        //UITableViewの生成
        myTableView=UITableView(frame: CGRect(x: 0, y: y+height, width: Int(view.bounds.width), height: Int(view.bounds.height)))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        self.view.addSubview(myTableView)
        
        
        //keysのデータを取り出す
        //var keysfin = [String]()
        let userDefault_keys = UserDefaults.standard
        
        /*userDefault_keys.set(keys,forKey: "keys")
        print(keys)
        keysfin=keys
        userDefault_keys.removeObject(forKey: "keys")
        userDefault_keys.set(keys,forKey: "keys")*/
        if let keys = userDefault_keys.stringArray(forKey:"keys"){
            print("keys\(keys)")
            keysfin = keys
        }
        myItems=keysfin
        //データを取り出す
        //let userDefault = UserDefaults.standard
        for key in keysfin{
            if let list : [[String:Any]] = userDefault.array(forKey: key) as? [[String : Any]]{
                print(list)
                //print(type(of: list))
                //userDefault.removeObject(forKey: "1日目")
            }
        }
       
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell",for: indexPath as IndexPath)
        cell.textLabel!.text="\(myItems[indexPath.row])"
        cell.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
        //performSegue(withIdentifier: "StartingToMap", sender: nil)
        keyfin = keysfin[indexPath.row]
        print(keyfin)
        if let list : [[String:Any]] = userDefault.array(forKey: keyfin) as? [[String : Any]]{
            listfin=list
            print("listfin\(listfin)")
        }
        performSegue(withIdentifier: "StartingToMap", sender: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        if let start = myTextField.text{
            print("startingViewcontroller\(start)")
            startingpoint=start
        }
        myTextField.text=""
        
        performSegue(withIdentifier: "goTable", sender: nil)
        
        return true
        
    }
    
    //セルの削除を許可
    func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    //セルの削除バタンが押されたとき
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //削除するだけなのでindexPath_row = indexPath.rowをする必要はない。
        //if editingStyle == UITableViewCell.EditingStyle.delete {
           // cellList[indexPath.section].remove(at: indexPath.row)
            //TableView.reloadData()
       // }
        var removeindex = indexPath.row
        print(removeindex)
        var removekey = keysfin[removeindex]
        print(removekey)
        keysfin.remove(at: removeindex)
        print(keysfin)
        //セルを削除
        if editingStyle == UITableViewCell.EditingStyle.delete {
             myItems.remove(at: indexPath.row)
             myTableView.reloadData()
        }
        //userdefaultでkeysfinを保存、removekeyに対応する経路を削除
        let defaults = UserDefaults.standard
        defaults.set(keysfin,forKey: "keys")
        defaults.removeObject(forKey: removekey)
        for key in keysfin{
            if let list : [[String:Any]] = userDefault.array(forKey: key) as? [[String : Any]]{
                print("削除後\(list)")
                //print(type(of: list))
                //userDefault.removeObject(forKey: "1日目")
            }
        }
        
        
    }
    @objc func edit(sender:UIButton){
        let string = sender.titleLabel!.text!
        if string == "編集"{
            myTableView.setEditing(true, animated: true)
            sender.setTitle("完了", for: .normal)
        }else{
            myTableView.setEditing(false, animated: true)
            sender.setTitle("編集", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goTable"{
            let nextVC=segue.destination as! ViewController
            nextVC.startingpoint=startingpoint
            
        }
        if segue.identifier=="StartingToMap"{
            let nextVC2=segue.destination as! MapViewController
            print(listfin)
            nextVC2.listfromstarting=listfin
            
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
