//
//  ViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import UIKit

class LaunchViewController: UIViewController, Storyboarded, LoaderPresentable {
  
  @IBOutlet weak var tableView : UITableView!
  @IBOutlet weak var tittleLabel: UILabel!
  
  var launchViewModel = LaunchViewModel()
  
  private weak var coordinator: LaunchCoordinator?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchAPI()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setTableView()
    setTextAndStyles()
  }
  

  func setup(coordinator : LaunchCoordinator){
    self.coordinator = coordinator
  }
  
  func setTextAndStyles(){
    self.title = "Space X 🚀"
    tittleLabel.text = "Launches Past"
    tittleLabel.apolloAzureBigTitleBold()
  }
  
  private func fetchAPI(){
    presentLoader { [self] in
      launchViewModel.delegate = self
      launchViewModel.fetchLaunchList()
    }
  }
  
  private func setTableView(){
    self.tableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchTableViewCell")
    tableView.separatorColor = UIColor.clear

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
    return 150
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
      self.showMessage(body: errorMessage , title: "Error")
    }
  }
}
