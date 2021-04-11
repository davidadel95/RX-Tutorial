//
//  RemoteExampleVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 06/04/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Moya_ModelMapper

class RemoteExampleVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<Github>!
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx
            .text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
    }


    func setupRx() {
        provider = MoyaProvider<Github>()
        
        // Here we tell table view that if user clicks on a cell,
        // and the keyboard is still visible, hide it
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            if self.searchBar.isFirstResponder == true {
                self.view.endEditing(true)
            }
        }).disposed(by: disposeBag)
    }

}
