//
//  DetailLaunchViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

class DetailLaunchViewController: UIViewController, Storyboarded, LoaderPresentable {
  
  
  @IBOutlet weak var detailTitleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var siteNameLongLabel: UILabel!
  @IBOutlet weak var rocketNameLabel: UILabel!
  @IBOutlet weak var rocketType: UILabel!
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var detailLabel: UILabel!

  @IBOutlet weak var playVideoButton: UIButton!
  @IBOutlet weak var infoLaunchButton: UIButton!
  private weak var coordinator: LaunchCoordinator?
  
  var item : LaunchesQuery.Data.Launch?
  
  private var pages: Int = 0
  
  var timer = Timer()
  
  var counter = 0
  
  var flickrImages: [String?]?
  
  
  private var currentPage = 0 {
    didSet {
      pageControl.currentPage = currentPage
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.isHidden = true
    pageControl.isHidden = true
    setDelegates()
    setCollection()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setTextAndStyles()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    getCarrouselPhotos()
  }
  
  func setup(coordinator : LaunchCoordinator, item : LaunchesQuery.Data.Launch){
    self.coordinator = coordinator
    self.item = item
    flickrImages = item.links?.flickrImages
    
  }
  
  func setTextAndStyles(){
    self.title = item?.missionName
    
    detailTitleLabel.text = "Details"
    dateLabel.text = "Date: " + Date().changeDateFormat(dateString: item?.launchDateLocal ?? "", fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ" , toFormat: "MMM d, h:mm a")
    siteNameLongLabel.text = "Site: " + (item?.launchSite?.siteNameLong ?? "- - -")
    rocketNameLabel.text = "Rocket name: " + (item?.rocket?.rocketName ?? "- - -")
    rocketType.text = "Rocket type: " + (item?.rocket?.rocketType ?? "- - -")
    detailLabel.text = item?.details

    detailTitleLabel.apolloAzureBigTitleBold()
    detailLabel.darkTitleBold()
    dateLabel.graySubTitle()
    siteNameLongLabel.graySubTitle()
    rocketNameLabel.graySubTitle()
    rocketType.graySubTitle()
    detailLabel.graySubTitle()
    
    dateLabel.lineBreakMode = .byWordWrapping
    dateLabel.numberOfLines = 0
    
    siteNameLongLabel.lineBreakMode = .byWordWrapping
    siteNameLongLabel.numberOfLines = 0
    
    detailLabel.lineBreakMode = .byWordWrapping
    detailLabel.numberOfLines = 0
    
    rocketType.lineBreakMode = .byWordWrapping
    rocketType.numberOfLines = 0
    
    playVideoButton.configButton()
    infoLaunchButton.configButton()
    
    playVideoButton.setTitle("YT Video", for: .normal)
    infoLaunchButton.setTitle("Launch Info", for: .normal)
  }
  
  func setDelegates() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func getCarrouselPhotos() {
    collectionView.isHidden =  flickrImages?.count == 0
    self.pages = flickrImages?.count ?? .zero
    setupPageControl()
    dispatchTimer()
    collectionView.reloadData()
  }
  
  func dispatchTimer() {
    guard flickrImages?.count ?? .zero > 0 else {
      return
    }
    self.timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] timer in
      self?.changeImage()
    }
  }
  
  @objc func changeImage() {
    pageControl.isHidden = pages <= 1
    if counter < pages {
      let index = IndexPath.init(item: counter, section: 0)
      self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
      pageControl.currentPage = counter
      counter += 1
    } else {
      counter = 0
      let index = IndexPath.init(item: counter, section: 0)
      self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
      self.collectionView.setNeedsLayout()
      pageControl.currentPage = counter
      counter = 1
    }
  }
  
  
  func setupPageControl() {
    pageControl.pageIndicatorTintColor = .gray
    pageControl.currentPageIndicatorTintColor = UIColor(named: "Primary") ?? UIColor.blue
    pageControl.isHidden = pages < 2
    pageControl.numberOfPages = pages
  }
  
  func setCollection() {
    let height = UIScreen.main.bounds.size.height
    let wiidth = UIScreen.main.bounds.size.width
    let flowLayout = ZoomAndSnapFlowLayout(itemSize: CGSize(width: wiidth / 1.1, height: height / 8))
    collectionView.collectionViewLayout = flowLayout
    collectionView.isScrollEnabled = true
    let nib = UINib(nibName: "CarrouselCollectionViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "CarrouselCell")
  }
  
  @IBAction func ytVideoAction(_ sender: Any) {
    coordinator?.presentYTPlayer(urlVideo: item?.links?.videoLink ?? "")
  }
  
  @IBAction func infoLaunchAction(_ sender: Any) {
    coordinator?.presentWebView(urlInfo: item?.links?.articleLink ?? "")
  }
  
}


extension DetailLaunchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    flickrImages?.count ?? .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrouselCell", for: indexPath) as? CarrouselCollectionViewCell,
          let imageLaunch = flickrImages?[indexPath.row]
    else { return UICollectionViewCell() }
    cell.flickrImage = imageLaunch
    return cell
  }
  
  func getCurrentPage() -> Int {
    
    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
      return visibleIndexPath.row
    }
    
    return currentPage
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentPage = getCurrentPage()
    counter = getCurrentPage()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    currentPage = getCurrentPage()
    counter = getCurrentPage()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    currentPage = getCurrentPage()
    counter = getCurrentPage()
  }
}
