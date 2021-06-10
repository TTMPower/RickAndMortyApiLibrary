import Foundation
import Alamofire
import Kingfisher
import UIKit

class NetworkService {
    
    func getCoinData(urlString: String, complition: @escaping ([Result]) -> Void) {
        AF.request(urlString).response { response in
            if let data = response.data {
                do {
                    let userResponse = try JSONDecoder().decode(ModelData.self, from: data)
                    complition(userResponse.results ?? [])
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
        }
    }
    
    func getEpisodes(url: String, complition: @escaping (EpisodeModel) -> Void) {
        AF.request(url).response { response in
            if let data = response.data {
                do {
                    let userResponse = try JSONDecoder().decode(EpisodeModel.self, from: data)
                    complition(userResponse)
                } catch {
                    print(error.localizedDescription)
                }
            
        }
            
    }
    
}
    
    func getImage(urlString: String, complition: @escaping(ImageResource) -> Void) {
        let resourse = ImageResource(downloadURL: URL(string: urlString)!, cacheKey: urlString)
        complition(resourse)
    }
}
