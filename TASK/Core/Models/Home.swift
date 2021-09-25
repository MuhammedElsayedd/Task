//
//  Home.swift
//  TASK
//
//  Created by Muhammed Elsayed on 2/28/21.
//

import Foundation

// MARK: - DataClass
struct Home: Codable {
    let attractions: [Attraction]?
    let events: [Event]?
    let hot_spots: [HotSpot]?
}

// MARK: - Attraction
struct Attraction: Codable {
    let id: Int?
    let name,profile_photo,arabic_name: String?
}


// MARK: - Event
struct Event: Codable {
    let id: Int?
    let name,profile_photo,description: String?
}

// MARK: - HotSpot
struct HotSpot: Codable {
    let id: Int?
    let name,arabic_name: String?
    let profile_photo: String?
}
