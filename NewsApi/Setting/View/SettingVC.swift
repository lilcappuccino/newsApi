//
//  SettingVC.swift
//  NewsApi
//
//  Created by dewill on 09/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var labelBuildVersion: UILabel!
    @IBAction func removeFavourite(_ sender: Any) { showRemoveFavouriteAlert() }
    
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        showBuildVersion()
    }
    
    
    private func showBuildVersion(){
        if let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            
            labelBuildVersion.text = "Build: v\(ver) \n @lilcappucc"
        }else {
            labelBuildVersion.isHidden = true
        }
    }
    
    private func showRemoveFavouriteAlert(){
        let alert = UIAlertController(title: "Remove", message: "Do you want to remove all favourite items?", preferredStyle: .actionSheet)
        let removeAction =  UIAlertAction(title: "Remove", style: .destructive) { [weak self] (action:UIAlertAction) in
            self?.viewModel.removeAllFavourite()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
