//
//  IssueTrackerModel.swift
//  RX-Tutorial
//
//  Created by David Adel on 06/04/2021.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct IssueTrackerModel {
    
    let provider: MoyaProvider<Github>
    let repositoryName: Observable<String>
    
//    func trackIssues() -> Observable<[Issue]>{
//        return repositoryName
//            .observeOn(MainScheduler.instance)
//            .flatMapLatest { (repository) -> Observable<[Issue]?> in
//                guard let repository = repository else { return Observable.just(nil) }
//                print("Repository: \(repository.fullName)")
//                return self.findIssues(repository)
//            }.replaceNilWith([])
//    }
    
    internal func findIssues(_ repository: Repository) -> Observable<[Issue]?> {
        return self.provider
            .rx
            .request(Github.issues(repositoryFullName: repository.fullName))
            .debug()
            .mapOptional(to: [Issue].self)
            .asObservable()
    }
}
