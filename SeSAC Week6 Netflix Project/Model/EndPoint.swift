

import Foundation

enum EndPoint {
    case movie
    case tv
    case genre
    case trending
    
    var requestURL: String {
        switch self {
        case .movie:
            return URL.makeEndPoint("movie/")
        case .tv:
            return URL.makeEndPoint("tv/")
        case .genre:
            return URL.makeEndPoint("genre/")
        case .trending:
            return URL.makeEndPoint("trending/")
        }
    }
}

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeEndPoint(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
