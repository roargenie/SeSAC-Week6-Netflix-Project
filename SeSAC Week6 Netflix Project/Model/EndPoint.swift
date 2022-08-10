

import Foundation

enum EndPoint {
    case movie
    case tv
    case genre
    case trending
    
    var requestURL: String {
        switch self {
        case .movie:
            return URL.makeEndPoint("movie")
        case .tv:
            return URL.makeEndPoint("tv")
        case .genre:
            return URL.makeEndPoint("genre")
        case .trending:
            return URL.makeEndPoint("trending")
        }
    }
}

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeEndPoint(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}


"https://api.themoviedb.org/3/movie/725201/credits?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR"
"https://api.themoviedb.org/3/trending/movie/week?api_key=02d814cdbbc52648edae9227b58c1049"
"https://api.themoviedb.org/3/movie/popular?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/movie/upcoming?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/movie/616037/recommendations?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/genre/movie/list?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR"

"https://api.themoviedb.org/3/trending/tv/week?api_key=02d814cdbbc52648edae9227b58c1049"
"https://api.themoviedb.org/3/tv/197067/credits?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR"
"https://api.themoviedb.org/3/tv/popular?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/tv/on_the_air?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/tv/197067/recommendations?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR&page=1"
"https://api.themoviedb.org/3/genre/tv/list?api_key=02d814cdbbc52648edae9227b58c1049&language=ko-KR"
