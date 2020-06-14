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
    var titleLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor(red:248/255, green: 248/255, blue: 248/255, alpha: 1)
        //self.view.backgroundColor=UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated:false)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor(red:112/255, green: 112/255, blue: 112/255, alpha: 1)
        let attributedString = NSMutableAttributedString(string:"le plan")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length:1 ))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 4, length: 1))
        titleLabel.attributedText = attributedString
        //titleLabel.backgroundColor = UIColor.gray
        titleLabel.font = UIFont(name: "Avenir", size:60.0 )
        let width:Int=200
        let height:Int=80
        titleLabel.frame=CGRect(x:Int(self.view.bounds.width)/2-width/2 , y: Int(self.view.bounds.height)/2-height/2, width:width, height: height)
        //titleLabel.frame=CGRect(x:0 , y:0, width:width, height: height)

        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
  
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
