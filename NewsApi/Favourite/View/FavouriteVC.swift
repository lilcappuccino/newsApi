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
        self.title = "Favourite"
        if let layout = favArticleCollectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchDateFromDb()
        favArticleCollectionView.reloadData()
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
            .map({[weak self] article in
                if(!article.isEmpty){ self?.showModalView(isPlay: false)}
                for currentArticle in article {
                    self?.imageList.append(currentArticle.image)
                }
            })
            .subscribe().disposed(by: disposeBag)
        
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
        let scale = collectionView.contentSize.width / CGFloat(imageList[indexPath.row]?.width ?? 1)
        return CGFloat(imageList[indexPath.row]?.height ?? 240) * scale
    }
}
