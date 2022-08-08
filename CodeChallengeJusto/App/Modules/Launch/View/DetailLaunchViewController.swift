//
//  DetailLaunchViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

class DetailLaunchViewController: UIViewController, Storyboarded, LoaderPresentable {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  @IBOutlet weak var detailLabel: UILabel!
  
  
  @IBOutlet weak var ytVideoButton: UIButton!
  
  
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
   // getCarrouselPhotos()
    
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
    detailLabel.text = item?.details
    detailLabel.lineBreakMode = .byWordWrapping
    detailLabel.numberOfLines = 0
    
    ytVideoButton.setTitle("YT Video", for: .normal)
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
