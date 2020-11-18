//
//  ViewController.swift
//  Real
//
//  Created by MacBook Air on 09.06.2020.
//  Copyright © 2020 VardanMakhsudyan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NewViewControllerDelegate {
    
    var real = [RealModel(name: "Casillas", number: 1, country: "Spain", imageName: "Casillas"),
                RealModel(name: "Salgado",  number: 2, country: "Spain", imageName: "Salgado"),
                RealModel(name: "Hierro",    number: 4, country: "Spain", imageName: "Hierro"),
                RealModel(name: "Helguera", number: 6, country: "Spain", imageName: "Helguera"),
                RealModel(name: "R.Carlos", number: 3, country: "Brazil", imageName: "R.Carlos"),
                RealModel(name: "Beckham", number: 23, country: "England", imageName: "Beckham"),
                RealModel(name: "Zidane", number: 5, country: "France", imageName: "Zidane"),
                RealModel(name: "Guti", number: 14, country: "Spain", imageName: "Guti"),
                RealModel(name: "Figo", number: 10, country: "Portugal", imageName: "Figo"),
                RealModel(name: "Ronaldo", number: 11, country: "Brazil", imageName: "Ronaldo"),
                RealModel(name: "Raul", number: 7, country: "Spain", imageName: "Raul")]
    
    var isSearching = false
    var player = AVAudioPlayer()
    
    var realFiltered: [RealModel]  {
        return real.filter({ (footBallist) -> Bool in
            guard let name = footBallist.name, !searchKeyword.isEmpty else { return true }
            return name.localizedCaseInsensitiveContains(searchKeyword)
        })
        
    }
    
    var searchKeyword = "" {
        didSet {
            RealTableView.reloadData()
        }
    }
    
    @IBOutlet weak var RealTableView: UITableView!
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        RealTableView.tableHeaderView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RealTableView.delegate = self
        RealTableView.dataSource = self
        
        do {
            if let audio = Bundle.main.path(forResource: "UEFA CHAMPIONS LEAGUE", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio))
            }
        } catch {
            print("Error")
        }
        self.player.play()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return realFiltered.count
        }
        return real.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        var model = real[indexPath.row]
        if isSearching {
            model = realFiltered[indexPath.row]
        }
        cell?.realName.text = model.name
        cell?.realNumber.text = String(model.number)
        cell?.realCountry.text = model.country
        if let imageName = model.imageName {
            cell?.realImage.image = UIImage(named: imageName)
        }    else {
            cell?.realImage.image = model.image
        }
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? NewViewController
        vc?.delegate = self
    }
    
    
    @IBAction func playAction(_ sender: UIBarButtonItem) {
        self.player.play()
    }
    
    @IBAction func pauseAction(_ sender: UIBarButtonItem) {
        self.player.pause()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = real[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            if let index = self.real.firstIndex(where: { (model) -> Bool in
                delete.name == model.name
            }) {
                self.real.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return [deleteAction]
    }
    
    func newViewController(vc: NewViewController, didAddModel model: RealModel) {
        real.append(model)
        RealTableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text ?? ""
        isSearching = text.isEmpty ? false: true
        searchKeyword = text
    }
}
    
