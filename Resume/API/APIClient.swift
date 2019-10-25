//
//  APIClient.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import Foundation
import Combine
import UIKit

public struct APIClientError : Error {
    
    let error: String
    
}

public class APIClient {
    
    public static let sharedClient = APIClient()
    
    func loadResume(url: URL = URL(string: "https://gist.githubusercontent.com/heyzooi/74e7728242770412d1d52d4cccb428fb/raw/resume.json")!) -> AnyPublisher<Resume, Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(3)
            .tryMap {
                guard let httpURLResponse = $0.response as? HTTPURLResponse else {
                    throw APIClientError(error: "Invalid Response")
                }
                switch httpURLResponse.statusCode {
                case 200:
                    return $0.data
                default:
                    throw APIClientError(error: "Resume can't be loaded!")
                }
            }
            .decode(type: Resume.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func loadImage(url: URL) -> AnyPublisher<UIImage?, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(3)
            .tryMap {
                guard let httpURLResponse = $0.response as? HTTPURLResponse else {
                    throw APIClientError(error: "Invalid Response")
                }
                switch httpURLResponse.statusCode {
                case 200:
                    return UIImage(data: $0.data)
                default:
                    throw APIClientError(error: "Resume can't be loaded!")
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
