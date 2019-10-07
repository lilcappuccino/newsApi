//
//  FavouriteVC.swift
//  NewsApi
//
//  Created by dewill on 05/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import Lottie

class FavouriteVC: UIViewController {

    @IBOutlet weak var anitationView: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showModalView(isPlay: true)

        // Do any additional setup after loading the view.
    }

    private func showModalView(isPlay: Bool){
           if isPlay {
               anitationView.play()
           } else {
               anitationView.isHidden = true
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
