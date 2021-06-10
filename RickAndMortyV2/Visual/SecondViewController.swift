//
//  SecondViewController.swift
//  RickAndMortyV2
//
//  Created by Владислав Вишняков on 28.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var s0s0: UILabel!
    @IBOutlet weak var nameEpisodes: UILabel!
    @IBOutlet weak var liveStatus: UIView!
    @IBOutlet weak var tableViewEpisodes: UITableView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var firstSeenlabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesAndgenderLabel: UILabel!
    @IBOutlet weak var liveStatusLabel: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    
    
    var networkservice = NetworkService()
    var data: Result? = nil
    var episodeData: [EpisodeModel] = [EpisodeModel]()
    var episodeName: [String] = []
    var episodeNumbers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for el in data!.episode {
            networkservice.getEpisodes(url: el){ response in
                self.episodeData.append(response)
                self.episodeName.append(response.name!)
                self.episodeNumbers.append(response.episode!)
                self.firstSeenlabel.text = self.episodeName.first
                self.tableViewEpisodes.reloadData()
            }
        }
        
        view.backgroundColor = .gray
        fullnameLabel.text = data?.name
        locationLabel.text = data?.location?.name
        speciesAndgenderLabel.text = data?.species
        liveStatusLabel.text = data?.status
        
        if data?.status == "Alive" {
            liveStatus.backgroundColor = .green
        } else {
            liveStatus.backgroundColor = .red
        }
        let image = data?.image
        let imageURL = URL(string: image!)
        secondImage.kf.base.sizeToFit()
        secondImage.kf.setImage(with: imageURL)
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (episodeNumbers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell") as! SecondTableViewCell
        tableView.backgroundColor = .lightGray
        cell.backgroundColor = .lightGray
        cell.nameSeria.text = episodeName[indexPath.row]
        cell.s0s0.text = episodeNumbers[indexPath.item]
        return cell
    }
}
