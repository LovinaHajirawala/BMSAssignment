//
//  MovieListModel.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 16/05/21.
//

import Foundation

struct MovieListResponse : Codable {
    let dates : Dates?
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?
}

struct Dates : Codable {
    let maximum : String?
    let minimum : String?
}

struct Results : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let genre_ids : [Int]?
    let id : Int?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let release_date : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?
}
