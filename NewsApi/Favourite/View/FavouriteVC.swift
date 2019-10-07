//
//  FavouriteVC.swift
//  NewsApi
//
//  Created by dewill on 05/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import Lottie
import RxSwift
import RxCocoa
import RealmSwift

class FavouriteVC: UIViewController {
    @IBOutlet weak var favArticleCollectionView: UICollectionView!
    
    @IBOutlet weak var anitationView: AnimationView!
    @IBOutlet weak var emptyStateView: UIView!
    
    private var disposeBag = DisposeBag()
    
    
    let viewModel = FavouriteViewModel()
    var imageList = [ImageModel?]()
    
    
    override func viewDidLoad() {
         print(Realm.Configuration.defaultConfiguration.fileURL!)
        super.viewDidLoad()
        showModalView(isPlay: true)
        setupBinds()
             viewModel.fetchDateFromDb()
        self.title = "Favourite"
        if let layout = favArticleCollectionView?.collectionViewLayout as? PinterestLayout {
                 layout.delegate = self
               }
    }
    
    
    private func setupBinds(){
        self.favArticleCollectionView.register(UINib(nibName: "PreviewItemVCell", bundle: nil), forCellWithReuseIdentifier: PreviewItemVCell.identifier)
        
        viewModel
            .articlesSubject
            .observeOn(MainScheduler.instance)
            .bind(to:
            self.favArticleCollectionView.rx.items(cellIdentifier: PreviewItemVCell.identifier, cellType: PreviewItemVCell.self)) { (item, article,cell) in
                cell.article = ArticleModelToApiMapper.map(from: article)
        }.disposed(by: disposeBag)
        
        viewModel
            .articlesSubject
            .observeOn(MainScheduler.instance)
            .map({article in
                if(!article.isEmpty){ self.showModalView(isPlay: false)}
                for currentArticle in article {
                    print("current title \(currentArticle.title)")
                    self.imageList.append(currentArticle.image)
                }
            })
            .subscribe({print("ok \($0.isCompleted)")}).disposed(by: disposeBag)

    }
    
    private func showModalView(isPlay: Bool){
        if isPlay {
            emptyStateView.isHidden = false
            anitationView.play()
        } else {
            emptyStateView.isHidden = true
        }
        
    }
    
}

extension FavouriteVC :  PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return CGFloat(imageList[indexPath.row]?.height ?? 240)
    }
}
