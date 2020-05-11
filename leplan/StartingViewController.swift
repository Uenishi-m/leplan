//
//  StartingViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/08.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController,UITextFieldDelegate {
    
    private var myTextField:UITextField!
    var startingpoint:String=""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.navigationItem.hidesBackButton=true
        self.view.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        
        //startLabelの設定と表示
        var width:Int=Int(view.bounds.width)
        var height:Int=70
        var x:Int=Int(view.bounds.width)/2-width/2
        var y:Int=Int(view.bounds.height)/2-height/2-100
        let startLabel:UILabel=UILabel(frame: CGRect(x:x, y:y, width: width, height: height))
        startLabel.text="どこから出発しますか？"
        startLabel.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        startLabel.textColor=UIColor.black
        startLabel.textAlignment=NSTextAlignment.center
        self.view.addSubview(startLabel)
        
        //textFieldの設定と表示
        width=width-100
        x=Int(view.bounds.width)/2-width/2
        myTextField=UITextField(frame: CGRect(x: x, y: y+100, width: width, height: height))
        //myTextField.text="名称または住所"
        myTextField.delegate=self
        myTextField.borderStyle = .roundedRect
        myTextField.clearButtonMode = .whileEditing
        self.view.addSubview(myTextField)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        if let start = myTextField.text{
            print("startingViewcontroller\(start)")
            startingpoint=start
        }
        
        performSegue(withIdentifier: "goTable", sender: nil)
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goTable"{
            let nextVC=segue.destination as! ViewController
            nextVC.startingpoint=startingpoint
            
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
