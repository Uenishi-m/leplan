//
//  TitleViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/05/08.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    var timer:Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let width:Int=500
        let height:Int=100
        let titleLabel=UILabel(frame: CGRect(x:Int(self.view.bounds.height)/2-width/2 , y: Int(self.view.bounds.width)/2-height/2, width:width, height: height))
        titleLabel.text="leplan"
        titleLabel.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        titleLabel.textColor=UIColor.black
        //self.view.backgroundColor = UIColor.cyan
        titleLabel.textAlignment=NSTextAlignment.center*/
        self.view.backgroundColor=UIColor(red:245/255, green: 241/255, blue: 228/255, alpha: 1)
        //self.navigationController?.setNavigationBarHidden(true, animated:false)
        //self.view.addSubview(titleLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 2.0,target: self,selector:#selector(self.changeView),userInfo: nil,repeats: false)

        // Do any additional setup after loading the view.
        //self.view.backgroundColor=UIColor.white
    }
    @objc func changeView() {
        self.performSegue(withIdentifier: "goStarting", sender: nil)                        
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
