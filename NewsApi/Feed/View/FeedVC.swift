//
//  FeedVC.swift
//  NewsApi
//
//  Created by dewill on 03/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie


class FeedVC: UIViewController {
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: AnimationView!
    // button with text "go to favourite"
    @IBOutlet weak var errorButton: UIButton!
    
    private let viewModel = FeedViewModel()
    private var photo: [UIImage]?
    
    let disposeBag = DisposeBag()
    
    
    // MARK: -> Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        viewModel.checkIsNetworkAvaible()
        setupUI()
        setupBindings()
        viewModel.fetchDate()
    }
    
    
    //MARK: -> Setup UI
    private func setupUI(){
        self.title = "Top Articles"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        feedCollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    }
    
    
    
    
    //MARK: -> setupBindings
    private func setupBindings() {
        self.feedCollectionView.register(UINib(nibName: "PreviewItemVCell", bundle: nil), forCellWithReuseIdentifier: PreviewItemVCell.identifier)
        
        viewModel
            .topArticles
            .observeOn(MainScheduler.instance)
            .bind(to:
            self.feedCollectionView.rx.items(cellIdentifier: PreviewItemVCell.identifier, cellType: PreviewItemVCell.self)) { (item,article,cell) in
                cell.article = article
        }.disposed(by: disposeBag)
        self.feedCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        
        Observable.zip(feedCollectionView.rx.itemSelected ,feedCollectionView.rx.modelSelected(ArticleModel.self))
            .bind{ [weak self] indexPath, model in
                let cell = self?.feedCollectionView.cellForItem(at: indexPath) as? PreviewItemVCell
                let fullArticleVC =  FullArticleVC(nibName: "FullArticleVC", bundle: nil  )
                fullArticleVC.image = cell?.image.image
                fullArticleVC.article = model
                self?.present(fullArticleVC, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        viewModel.isLoadingSubject
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] isLoading in
                self?.showModalView(isPlay: isLoading)
                }
        ).disposed(by: disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] error in
                self?.errorButton.isHidden = false
                }
        ).disposed(by: disposeBag)
    }
    
    //MARK: -> Show MODAL view (Loading)
    private func showModalView(isPlay: Bool){
        if isPlay {
            loadingView.loopMode  = .loop
            loadingView.play()
        } else {
            loadingView.isHidden = true
            errorButton.isHidden = true
        }
        
    }
    //MARK: -> Click
    @IBAction func clickedGoToFavourite(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
    
}

//MARK: -> UICollectionViewDelegateFlowLayout
extension FeedVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize + 50)
    }
}

