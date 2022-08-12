
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var myContentsButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var movieDatas: MoviePopular?
    var tvDatas: TVPopular?
    var moviePopularData = [MoviePopular]()
    var movieUpcomingData = [MovieUpcoming]()
    var movieRecommendData = [MovieRecommendation]()
    var tvPopularData = [TVPopular]()
    var tvOnScreenData = [TVOnScreen]()
    var tvRecommendData = [TVRecommendation]()
    
    var movieGenreDic: [Int: String] = [:]
    var tvGenreDic: [Int: String] = [:]
    
    var startAndTotalCount: [String: (Int, Int)] = ["MoviePopular": (1, 0), "MovieUpcoming": (1, 0), "TVPopular": (1, 0), "TVOnScreen": (1, 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        //cell.contentCollectionView.prefetchDataSource = self
        
        getPopularMovie()
        getMovieGenre()
        getTVGenre()
        
    }
    
    func getPopularMovie() {
        MovieAPIManager.shared.getMoviePopular(start: startAndTotalCount["MoviePopular"]!.0) { totalCount, result in
            self.startAndTotalCount["MoviePopular"]!.1 = totalCount
            self.moviePopularData.append(contentsOf: result)
            
            self.getUpcomingMovie()
            self.getRecommendMovie()
            self.getPopularTV()
            self.getOnScreenTV()
            self.getRecommendTV()
            self.setHeaderUI()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            //dump(self.moviePopularData)
            
        }
    }
    
    func getUpcomingMovie() {
        MovieAPIManager.shared.getMovieUpcoming(start: startAndTotalCount["MovieUpcoming"]!.0) { totalCount, result in
            self.startAndTotalCount["MovieUpcoming"]!.1 = totalCount
            self.movieUpcomingData.append(contentsOf: result)
            dump(self.movieUpcomingData)
        }
        
    }
    
    func getRecommendMovie() {
        guard let movieID = self.movieDatas?.id else { return }
        
        MovieAPIManager.shared.getMovieRecommendation(movie_id: movieID) { result in
            self.movieRecommendData.append(contentsOf: result)
            //dump(self.movieRecommendData)
        }
        
    }
    
    func getPopularTV() {
        MovieAPIManager.shared.getTVPopular(start: startAndTotalCount["TVPopular"]!.0) { totalCount, result in
            self.startAndTotalCount["TVPopular"]!.1 = totalCount
            self.tvPopularData.append(contentsOf: result)
            //dump(self.tvPopularData)
        }
        
    }
    
    func getOnScreenTV() {
        MovieAPIManager.shared.getTVOnScreen(start: startAndTotalCount["TVOnScreen"]!.0) { totalCount, result in
            self.startAndTotalCount["TVOnScreen"]!.1 = totalCount
            self.tvOnScreenData.append(contentsOf: result)
            //dump(self.tvOnScreenData)
        }
        
    }
    
    func getRecommendTV() {
        guard let tvID = self.tvDatas?.id else { return }
        
        MovieAPIManager.shared.getTVRecommendation(movie_id: tvID) { result in
            self.tvRecommendData.append(contentsOf: result)
            //dump(self.tvRecommendData)
        }
        
    }
    
    func getMovieGenre() {
        MovieAPIManager.shared.getMovieGenre { result in
            self.movieGenreDic = result
            //dump(self.movieGenreDic)
        }
    }
    
    func getTVGenre() {
        MovieAPIManager.shared.getTVGenre { result in
            self.tvGenreDic = result
            //dump(self.tvGenreDic)
        }
    }
    
    func setHeaderUI() {
        if let randomdata = moviePopularData.randomElement() {
//            var genreString: [String] = []
//            for id in randomdata.genre_ids {
//                if movieGenreDic.keys.contains(id) {
//                    if let genre = movieGenreDic[id] {
//                        genreString.append(genre)
//
//                        DispatchQueue.main.async {
//
//                        }
//                    }
//                }
//            }
            if let url = randomdata.poster_path {
                let image = URL(string: "\(MovieAPIManager.shared.imageURL)\(url)")
                
                DispatchQueue.main.async {
                    self.headerImageView.kf.setImage(with: image)
                    self.headerImageView.contentMode = .scaleToFill
                    
                }
            }
            
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return moviePopularData.count
        } else if collectionView.tag == 1 {
            return movieUpcomingData.count
        } else if collectionView.tag == 2 {
            return tvPopularData.count
        } else if collectionView.tag == 3 {
            return tvOnScreenData.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView.tag == 0 {
            let data = moviePopularData[indexPath.item]
            if let url = data.poster_path {
                let image = URL(string: "\(MovieAPIManager.shared.imageURL)\(url)")
                cell.cardView.posterImageView.kf.setImage(with: image)
            }
            
        } else if collectionView.tag == 1 {
            let data = movieUpcomingData[indexPath.item]
            print("셀 =================\(data)")
            if let url = data.poster_path {
                let image = URL(string: "\(MovieAPIManager.shared.imageURL)\(url)")
                cell.cardView.posterImageView.kf.setImage(with: image)
            }
            
        } else if collectionView.tag == 2 {
            let data = tvPopularData[indexPath.item]
            if let url = data.poster_path {
                let image = URL(string: "\(MovieAPIManager.shared.imageURL)\(url)")
                cell.cardView.posterImageView.kf.setImage(with: image)
            }
        } else if collectionView.tag == 3 {
            let data = tvOnScreenData[indexPath.item]
            if let url = data.poster_path {
                let image = URL(string: "\(MovieAPIManager.shared.imageURL)\(url)")
                cell.cardView.posterImageView.kf.setImage(with: image)
            }
        }
        cell.cardView.posterImageView.contentMode = .scaleToFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            
        }
        
        
    }
    
//    func collectionViewLayout() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        
        cell.contentCollectionView.register(UINib(nibName: CardCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        cell.contentCollectionView.tag = indexPath.section
        cell.contentsSortLabel.textColor = .white
        cell.contentsSortLabel.font = .boldSystemFont(ofSize: 23)
        
        if indexPath.section == 0 {
            cell.contentsSortLabel.text = "인기영화"
            
        } else if indexPath.section == 1 {
            cell.contentsSortLabel.text = "개봉 예정 영화"
            
        } else if indexPath.section == 2 {
            cell.contentsSortLabel.text = "인기 TV프로그램"
            
        } else if indexPath.section == 3 {
            cell.contentsSortLabel.text = "방영중인 TV프로그램"
            
        }
        cell.contentCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
