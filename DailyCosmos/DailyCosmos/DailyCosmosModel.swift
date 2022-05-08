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
}
