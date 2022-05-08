//
//  DailyCosmosViewModel.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import Foundation

class DailyCosmosViewModel: NSObject {
    
    var currentCosmosData: DailyCosmosModel?
    var manager: DailyCosmosManager = DailyCosmosManager()
    
    func getDailyCosmosData(completion: @escaping ((Result<DailyCosmosModel, Error>) -> Void)) {
        manager.fetchDailyCosmosData { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
