//
//  ViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView : UITableView!
  
  var launchViewModel = LaunchViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    fetchAPI()
    // Do any additional setup after loading the view.
  }

  private func fetchAPI(){
    launchViewModel.delegate = self
    launchViewModel.fetchLaunchList()
    
  }
  
  private func setTableView(){
    self.tableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchTableViewCell")
  }
  
  
  
  

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return launchViewModel.launchList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell {
      cell.configCell(item: launchViewModel.launchList[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
}

extension ViewController : LaunchViewModelDelegate {
  func didReceiveData() {
    self.tableView.reloadData()
  }
  
  func didFail(errorMessage: String) {
    debugPrint(errorMessage)
  }
}
