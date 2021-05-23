//
//  MovieDetailModel.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import Foundation

struct MovieSynopsisResponse : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let belongs_to_collection : Belongs_to_collection?
    let budget : Int?
    let genres : [Genres]?
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let production_companies : [Production_companies]?
    let production_countries : [Production_countries]?
    let release_date : String?
    let revenue : Int?
    let runtime : Int?
    let spoken_languages : [Spoken_languages]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case belongs_to_collection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdb_id = "imdb_id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case production_companies = "production_companies"
        case production_countries = "production_countries"
        case release_date = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spoken_languages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        belongs_to_collection = try values.decodeIfPresent(Belongs_to_collection.self, forKey: .belongs_to_collection)
        budget = try values.decodeIfPresent(Int.self, forKey: .budget)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imdb_id = try values.decodeIfPresent(String.self, forKey: .imdb_id)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        production_companies = try values.decodeIfPresent([Production_companies].self, forKey: .production_companies)
        production_countries = try values.decodeIfPresent([Production_countries].self, forKey: .production_countries)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        spoken_languages = try values.decodeIfPresent([Spoken_languages].self, forKey: .spoken_languages)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }
    
}

struct Genres : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Production_companies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        logo_path = try values.decodeIfPresent(String.self, forKey: .logo_path)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin_country = try values.decodeIfPresent(String.self, forKey: .origin_country)
    }
    
}

struct Production_countries : Codable {
    let iso_3166_1 : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Spoken_languages : Codable {
    let english_name : String?
    let iso_639_1 : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case english_name = "english_name"
        case iso_639_1 = "iso_639_1"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        english_name = try values.decodeIfPresent(String.self, forKey: .english_name)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Belongs_to_collection : Codable {
    let id : Int?
    let name : String?
    let poster_path : String?
    let backdrop_path : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case poster_path = "poster_path"
        case backdrop_path = "backdrop_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
    }

}

