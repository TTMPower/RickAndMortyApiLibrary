//
//  EpisodeModel.swift
//  RickAndMortyV2
//
//  Created by Владислав Вишняков on 02.06.2021.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelData = try? newJSONDecoder().decode(ModelData.self, from: jsonData)

import Foundation

// MARK: - ModelData
struct EpisodeModel: Codable {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
        case url = "url"
        case created = "created"
    }
}
