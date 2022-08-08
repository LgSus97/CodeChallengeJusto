//
//  ViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import UIKit

class LaunchViewController: UIViewController, Storyboarded, LoaderPresentable {
  
  @IBOutlet weak var tableView : UITableView!
  
  var launchViewModel = LaunchViewModel()
  
  private weak var coordinator: LaunchCoordinator?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    fetchAPI()
    // Do any additional setup after loading the view.
  }

  func setup(coordinator : LaunchCoordinator){
    self.coordinator = coordinator
  }
  
  private func fetchAPI(){
    presentLoader { [self] in
      launchViewModel.delegate = self
      launchViewModel.fetchLaunchList()
    }
  }
  
  private func setTableView(){
    self.tableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchTableViewCell")
  }
  

}


extension LaunchViewController: UITableViewDataSource, UITableViewDelegate{

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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    coordinator?.presentDetailLaunch(item: launchViewModel.launchList[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  
}

extension LaunchViewController : LaunchViewModelDelegate {
  func didReceiveData() {
    dismissLoader {
      self.tableView.reloadData()
    }
  }
  
  func didFail(errorMessage: String) {
    dismissLoader {
      debugPrint(errorMessage)
    }
  }
}
