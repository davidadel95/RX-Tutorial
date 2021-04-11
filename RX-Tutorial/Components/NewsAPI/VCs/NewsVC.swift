//
//  NewsVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NewsVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Good News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupRx()
    }
    
    func setupRx() {
        tableView.register(UINib(nibName: "NewsTVC", bundle: nil), forCellReuseIdentifier: "NewsTVC")
        viewModel.populateNews()
        viewModel.articlesSubject.bind(to: tableView.rx.items(cellIdentifier: "NewsTVC", cellType: NewsTVC.self)) { (row, track, cell) in
            cell.titleLabel.text = track.title
            cell.subtitleLabel.text = track.description
        }.disposed(by: disposeBag)
    }
}

