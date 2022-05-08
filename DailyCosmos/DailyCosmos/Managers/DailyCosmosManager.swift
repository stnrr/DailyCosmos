//
//  DailyCosmosManager.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import Foundation

class DailyCosmosManager: NSObject {
    func fetchDailyCosmosData(completion: @escaping ((Result<DailyCosmosModel, Error>) -> Void)) {
        if let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=ak1mBQTAJL2tYkv0pcrhRgFSYUiRZduiUBDQr6Gj") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                } else if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        let cosmosData = try decoder.decode(DailyCosmosModel.self, from: jsonData)
                        completion(.success(cosmosData))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
