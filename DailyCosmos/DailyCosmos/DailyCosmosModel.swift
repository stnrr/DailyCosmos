//
//  DailyCosmosModel.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import Foundation

struct DailyCosmosModel: Codable {
    var title: String?
    var imageUrl: String?
    var imageDescription: String?
    
    private enum CodingKeys : String, CodingKey {
        case title
        case imageUrl = "url"
        case imageDescription = "explanation"
    }
    
    func storeInCache() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(self) {
            UserDefaults.standard.set(encodedData, forKey: "cosmosData")
        }
    }
    
    static func getCacheCosmosData() -> DailyCosmosModel? {
        if let encodedData = UserDefaults.standard.object(forKey: "cosmosData") as? Data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(DailyCosmosModel.self, from: encodedData) {
                return model
            }
        }
        return nil
    }
}
