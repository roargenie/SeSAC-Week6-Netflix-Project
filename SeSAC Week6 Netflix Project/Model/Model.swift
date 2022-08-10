
import UIKit

struct MoviePopular: Codable {
    var adult: Bool
    var backdrop_path: String
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var genre_ids: [Int]
    var release_date: String
}

struct MoviePopularList: Codable {
    var page: Int
    var results: [MoviePopular]
    var total_pages: Int
    var total_results: Int
}

struct MovieUpcoming: Codable {
    var adult: Bool
    var backdrop_path: String
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var genre_ids: [Int]
    var release_date: String
}

struct MovieUpcomingList: Codable {
    var dates: String
    var page: Int
    var results: [MovieUpcoming]
    var total_pages: Int
    var total_results: Int
}

struct MovieRecommendation: Codable {
    var adult: Bool
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var backdrop_path: String
    var genre_ids: [Int]
}

struct TVPopular: Codable {
    var id: Int
    var name: String
    var backdrop_path: String
    var first_air_date: String
    var genre_ids: [Int]
    var overview: String
    var poster_path: String
}

struct TVPopularList: Codable {
    var page: Int
    var results: [TVPopular]
    var total_pages: Int
    var total_results: Int
}

struct TVOnScreen: Codable {
    var backdrop_path: String
    var first_air_date: String
    var genre_ids: [Int]
    var id: Int
    var name: String
    var overview: String
    var poster_path: String
}

struct TVOnScreenList: Codable {
    var page: Int
    var results: [TVOnScreen]
    var total_pages: Int
    var total_results: Int
}

struct MovieCast: Codable {
    var name: String
    var character: String
    var profile_path: String?
}

struct MovieCrew: Codable {
    var name: String
    var job: String
    var profile_path: String?
}

struct MovieCastList: Codable {
    var id: Int
    var cast: [MovieCast]
    var crew: [MovieCrew]
}

