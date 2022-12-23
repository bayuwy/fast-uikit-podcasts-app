//
//  HomeViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 23/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath)
//
//        cell.textLabel?.text = "Row \(indexPath.row + 1)"
//        cell.detailTextLabel?.text = "Detail row \(indexPath.row + 1)"
//        cell.imageView?.image = UIImage(named: "tab_home")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recent_cell_id", for: indexPath) as! HomeRecentViewCell
        
        cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
        cell.thumbImageView.image = UIImage(named: "img_thumb_1")
        cell.titleLabel.text = "Row \(indexPath.row + 1)"
        cell.subtitleLabel.text = "Detail row \(indexPath.row + 1)"
        
        cell.delegate = self
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Recently Music"
//    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Row Selected", message: "Row \(indexPath.row + 1)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertAction.Style.default, handler: { (alertAction) in
            print("Cell at \(indexPath.row + 1) is selected")
            tableView.deselectRow(at: indexPath, animated: true)
        }))
        present(alert, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
}

    // MARK: - HomeRecentViewCellDelegate
extension HomeViewController: HomeRecentViewCellDelegate {
    func homeRecentViewCellMoreButtonTapped(cell: HomeRecentViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            let actionSheet = UIAlertController(title: "More at row \(indexPath.row + 1)", message: "Select an action bellow", preferredStyle: UIAlertController.Style.actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Oke", style: UIAlertAction.Style.default, handler: { _ in
                print("Oke action tapped at \(indexPath.row + 1)")
            }))
            actionSheet.addAction(UIAlertAction(title: "Baiklah", style: UIAlertAction.Style.default, handler: { _ in
                print("Baiklah action tapped at \(indexPath.row + 1)")
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                print("Cancel action tapped at \(indexPath.row + 1)")
            }))
            present(actionSheet, animated: true)
        }
    }
}
