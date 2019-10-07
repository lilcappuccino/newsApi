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
    
    private let viewModel = FeedViewModel()
    private var photo: [UIImage]?
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top Articles"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        feedCollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        setupBindings()
        viewModel.fetchDate()
        setNavBarAppearance()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavBarAppearance()
    }
    /// Customize navigation bar appearance for ios 13
    func setNavBarAppearance() {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    
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
        
        
        
        Observable.zip(feedCollectionView.rx.itemSelected ,feedCollectionView.rx.modelSelected(ArticleApi.self))
            .bind{ [weak self] indexPath, model in
                let cell = self?.feedCollectionView.cellForItem(at: indexPath) as? PreviewItemVCell
                let fullArticleVC =  FullArticleViewController(nibName: "FullArticleViewController", bundle: nil  )
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
        
        //
        //        feedCollectionView.rx.itemSelected
        //
        //        .subscribe(onNext: { [weak self] indexPath in
        //
        //            self?.present(fullArticleVC, animated: true, completion: nil)
        //        }).disposed(by: disposeBag)
        //
        //
    }
    
    //MARK: -> Show MODAL view (Loading)
    private func showModalView(isPlay: Bool){
        if isPlay {
            loadingView.loopMode  = .loop
            loadingView.play()
        } else {
            loadingView.isHidden = true
        }
        
    }
    
    //       func display(contentController content: UIViewController, on view: UIView) {
    //           self.addChild(content)
    //           content.view.frame = view.bounds
    //           view.addSubview(content.view)
    //           content.didMove(toParent: self)
    //       }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension FeedVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize + 50)
    }
}

