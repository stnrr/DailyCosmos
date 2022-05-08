//
//  DailyCosmosViewModel.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import Foundation

class DailyCosmosViewModel: NSObject {
    
    var currentCosmosData: DailyCosmosModel?
    
    func getDailyCosmosData(completion: @escaping ((Result<DailyCosmosModel, Error>) -> Void)) {
        
    }
}
