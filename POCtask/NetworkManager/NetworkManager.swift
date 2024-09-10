//
//  NetworkManager.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import Foundation
import Combine

class ConfigStorage {
    
    static let shared = ConfigStorage()
    
    var config: AppConfig?
}

class NetworkManager {
    
    var cancellable = Set<AnyCancellable>()
    
    var config: AppConfig?
    
    func request<T: Codable>(urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func request<T: Codable>(url: URL) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: url)
        
        return self.request(urlRequest: request)
    }
    
    func requestEndpoint<T: Codable>(url: String) -> AnyPublisher<T, Error> {
        guard let config = config else {
            return Fail(error: NSError(domain: "",
                                       code: 0,
                                       userInfo: [NSLocalizedDescriptionKey: "Object does not exist"]))
            .eraseToAnyPublisher()
        }
        
        var baseURL = config.hardcodedEndpoints.compilerUrl
        baseURL = baseURL + "amcn/" + config.serviceId + "/" + url
        
        guard let url = URL(string: baseURL) else {
            print("INVALID URL")
            return Fail(error: NSError(domain: "Missing feed URL", code: -10001)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        // HERE SET DIFFERENT HTTP HEADER FIELDS
        request.setValue("Bearer token goes here", forHTTPHeaderField: "Authorization")
        
        return self.request(urlRequest: request)
    }
    
    func setupConfig(config: AppConfig) {
        self.config = config
    }
}
