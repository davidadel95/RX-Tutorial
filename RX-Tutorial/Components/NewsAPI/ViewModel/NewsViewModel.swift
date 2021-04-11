//
//  NewsViewModel.swift
//  RX-Tutorial
//
//  Created by David Adel on 08/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class NewsViewModel {
    // MARK: - Variables
    let disposeBag = DisposeBag()
    var articles: BehaviorRelay<[Article]> = BehaviorRelay(value: [])
    var articlesSubject: PublishSubject<[Article]> = PublishSubject()
    
    
    // MARK: - Methods
    func populateNews() {
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
            if let result = result {
                let articles = result.articles
                self?.articles.accept(articles)
                self?.articlesSubject.onNext(articles)
            }
        }).disposed(by: disposeBag)
    }
}
