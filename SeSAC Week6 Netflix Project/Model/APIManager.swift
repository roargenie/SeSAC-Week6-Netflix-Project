



import UIKit

import Alamofire
import SwiftyJSON

class MovieAPIManager {
    
    static let shared = MovieAPIManager()
    
    private init() { }
    
    typealias moviePopularCompletionHandler = (Int, [MoviePopular]) -> Void
    typealias movieUpcomingCompletionHandler = (Int, [MovieUpcoming]) -> Void
    typealias movieRecommendationCompletionHandler = ([MovieRecommendation]) -> Void
    typealias movieGenreCompletionHandler = ([Int: String]) -> Void
    typealias movieCastCompletionHandler = ([MovieCast], [MovieCrew]) -> Void
    
    typealias tvPopularCompletionHandler = (Int, [TVPopular]) -> Void
    typealias tvOnScreenCompletionHadler = (Int, [TVOnScreen]) -> Void
    typealias tvRecommendationCompletionHandler = ([TVRecommendation]) -> Void
    typealias tvGenreCompletionHandler = ([Int: String]) -> Void
    typealias tvCastCompletionHandler = ([TVCast], [TVCrew]) -> Void
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func getMoviePopular(start: Int, completionHandler: @escaping moviePopularCompletionHandler) {
        print(#function)
        let url = "\(EndPoint.movie.requestURL)" + "popular?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MoviePopularList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let totalCount = value.total_results
                let result = value.results
                
                completionHandler(totalCount, result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieUpcoming(start: Int, completionHandler: @escaping movieUpcomingCompletionHandler) {
        print(#function)
        let url = "\(EndPoint.movie.requestURL)" + "upcoming?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MovieUpcomingList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let totalCount = value.total_results
                let result = value.results
                
                completionHandler(totalCount, result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieRecommendation(movie_id: Int, completionHandler: @escaping movieRecommendationCompletionHandler) {
        
        let url = "\(EndPoint.movie.requestURL)" + "\(movie_id)/recommendations?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MovieRecommendationList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                //let totalCount = value.total_results
                let result = value.results
                
                completionHandler(result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieCast(movie_id: Int, completionHandler: @escaping movieCastCompletionHandler) {
        
        let url = "\(EndPoint.movie.requestURL)" + "\(movie_id)/credits?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MovieCastList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let castResult = value.cast
                let crewResult = value.crew
                
                completionHandler(castResult, crewResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVPopular(start: Int, completionHandler: @escaping tvPopularCompletionHandler) {
        
        let url = "\(EndPoint.tv.requestURL)" + "popular?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TVPopularList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let totalCount = value.total_results
                let result = value.results
                
                completionHandler(totalCount, result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVOnScreen(start: Int, completionHandler: @escaping tvOnScreenCompletionHadler) {
        
        let url = "\(EndPoint.tv.requestURL)" + "on_the_air?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TVOnScreenList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let totalCount = value.total_results
                let result = value.results
                
                completionHandler(totalCount, result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVRecommendation(movie_id: Int, completionHandler: @escaping tvRecommendationCompletionHandler) {
        
        let url = "\(EndPoint.tv.requestURL)" + "\(movie_id)recommendations?api_key=\(APIKey.TMDB)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TVRecommendationList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
//                let totalCount = value.total_results
                let result = value.results
                
                completionHandler(result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVCast(movie_id: Int, completionHandler: @escaping tvCastCompletionHandler) {
        
        let url = "\(EndPoint.tv.requestURL)" + "\(movie_id)/credits?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TVCastList.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let castResult = value.cast
                let crewResult = value.crew
                
                completionHandler(castResult, crewResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieGenre(completionHandler: @escaping movieGenreCompletionHandler) {
        
        let url = "\(EndPoint.genre.requestURL)" + "movie/list?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var genresDic: [Int: String] = [:]
                
                for item in json["genres"].arrayValue {
                    let id = item["id"].intValue
                    let name = item["name"].stringValue
                    
                    genresDic.updateValue(name, forKey: id)
                }
                
                completionHandler(genresDic)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVGenre(completionHandler: @escaping tvGenreCompletionHandler) {
        
        let url = "\(EndPoint.genre.requestURL)" + "tv/list?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var genresDic: [Int: String] = [:]
                
                for item in json["genres"].arrayValue {
                    let id = item["id"].intValue
                    let name = item["name"].stringValue
                    
                    genresDic.updateValue(name, forKey: id)
                }
                
                completionHandler(genresDic)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}







