//
//  MyTableViewController.swift
//  RickAndMortyV2
//
//  Created by Владислав Вишняков on 22.05.2021.
//

import UIKit
import Kingfisher



class MyTableViewController: UIViewController, UITableViewDelegate {
    
    var networkservice = NetworkService()
    var images: ModelData? = nil
    var result: [Result] = [Result]()
    
    var isDataLoading: Bool = false
    var pageNo: Int = 1
    var limit: Int = 20
    var offset: Int = 0
    var didEndReached: Bool = false
    
    
    
    @IBOutlet var mainUIView: UIView!
    @IBOutlet weak var tableViewVisual: UITableView!
    
    func updatetable() {
        let myUrl: String = "https://rickandmortyapi.com/api/character?page=\(pageNo)"
        DispatchQueue.main.async {
            self.networkservice.getCoinData(urlString: myUrl) { [weak self] response in
                self!.result.append(contentsOf: response)
                self!.tableViewVisual.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        self.tableViewVisual.backgroundColor = UIColor.darkGray
        tableViewVisual.delegate = self
        tableViewVisual.dataSource = self
        updatetable()
    }
    
    
    
    
}

// MARK: - Table view data source
extension MyTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableViewVisual.contentOffset.y + tableViewVisual.frame.size.height) >= tableViewVisual.contentSize.height / 1.3)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo = self.pageNo + 1
                self.limit = self.limit + 20
                self.offset = self.limit * self.pageNo
                updatetable()
            }
        }
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! MyTableViewCell
        let model = result[indexPath.row]
        
        cell.backgroundColor = .gray
        cell.layer.cornerRadius = 13
        cell.layer.borderWidth = 7
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.textFullnamecell.text = model.name
        cell.cellLocation.text = model.location?.name
        cell.cellTextStatus.text = model.status
        if model.status == "Alive" {
            cell.cellStatusColor.backgroundColor = .green
        } else {
            cell.cellStatusColor.backgroundColor = .red
        }
        var images1 = [ImageResource]()
        networkservice.getImage(urlString: model.image!) { resourse in
            images1.append(resourse)
        }
        cell.imageViewCell.kf.setImage(with: images1.first)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seguePerform", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            destination.data = result[tableViewVisual.indexPathForSelectedRow!.row]
        }
    }
}
