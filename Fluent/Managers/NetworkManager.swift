//
//  NetworkManager.swift
//  Fluent
//
//  Created by scalxrd on 07/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import Foundation

struct ResponseModal: Codable
{
    let id:       Int?
    let text:     String?
    let meanings: [Meaning]?

    struct Meaning: Codable
    {
        let id: Int?
        let partOfSpeechCode: String?
        let translation: Translation?
        let transcription: String?
        let soundUrl: String?
    }

    struct Translation: Codable
    {
        let text: String?
        let note: String?
    }
}

enum FError: Error
{
    case unableToComplete
    case invalidData
    case invalidResponse
    case invalidURL
}

class NetworkManager
{
    static let  shared  = NetworkManager()
    private let baseURL = "http://dictionary.skyeng.ru/api/public/v1/"

    //    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getMeanings(for ids: [Int], completed: @escaping (Result<[Meaning], Error>) -> Void) {
        let endpoint = baseURL + "meanings?_format=json&ids=\(ids)"

    }

    func search(for word: String, page: Int, pageSize: Int,
                completed: @escaping (Result<[ResponseModal], FError>) -> Void) {
        let endpoint
                = baseURL + "words/search?search=\(word)&page=\(page)&pageSize=\(pageSize)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            if let _ = error {
                print(error)
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder(context: PersistenceManager.shared.viewContext)
                let followers = try decoder.decode([ResponseModal].self, from: data)
                completed(.success(followers))
            } catch let error {
                print("Decoder failed: \(error)")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

}

//
//    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
//        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
//
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Follower].self, from: data)
//                completed(.success(followers))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//
//        task.resume()
//    }
//
//
//    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
//        let endpoint = baseURL + "\(username)"
//
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let user = try decoder.decode(User.self, from: data)
//                completed(.success(user))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//
//        task.resume()
//    }
//}
