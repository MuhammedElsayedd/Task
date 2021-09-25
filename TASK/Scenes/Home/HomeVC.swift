//
//  HomeVC.swift
//  TASK
//
//  Created by Muhammed Elsayed on 3/31/21.
//

import UIKit

class HomeVC: UIViewController {

    // MARk:- Outlets
    @IBOutlet weak var hotspotCollection: UICollectionView!
    @IBOutlet weak var eventCollection: UICollectionView!
    @IBOutlet weak var attractionsCollection: UICollectionView!
    @IBOutlet weak var holderView: UIView!
    
    // MARK: Variables
    var hotspot = [HotSpot]()
    var event = [Event]()
    var attraction = [Attraction]()
    var homeUseCase: BaseListUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        getHome()

    }
    
    func getHome() {
        homeUseCase = BaseListUseCase(tag: "api/home")
        self.hotspotCollection.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.eventCollection.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.attractionsCollection.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //MARk:- I will hash the next lines due to failure of domain.

//        animateLoaderView()
//        homeUseCase.execute(ResponseModel<Home>.self, completionHandler: {[weak self] (result) in
//            switch result {
//            case let .success(response):
//                self?.hotspot = response.data?.hot_spots ?? []
//                self?.event = response.data?.events ?? []
//                self?.attraction = response.data?.attractions ?? []
//                self?.hotspotCollection.reloadData()
//                self?.eventCollection.reloadData()
//                self?.attractionsCollection.reloadData()
//                self?.stopLoaderView()
//            case let .failure(error):
//                print(error)
//                self?.presentAlert(title: nil, message: error.localizedDescription)
//            }
//            self?.stopLoaderView()
//        })
    }
}
extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotspotCollection{
//            return hotspot.count
            return 8
        }else if collectionView == eventCollection{
//            return event.count
            return 8
        }else{
//            return attraction.count
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotspotCollection{
            if let cell = hotspotCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell {
//                cell.configHotspot(with: hotspot[indexPath.row])
                return cell
            }else {
                return HomeCell()
            }
        }else if collectionView == eventCollection{
            if let cell = eventCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell {
//                cell.configEvents(with: event[indexPath.row])
                return cell
            }else {
                return HomeCell()
            }
        }else{
            if let cell = attractionsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell {
//                cell.configAttractions(with: attraction[indexPath.row])
                return cell
            }else {
                return HomeCell()
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == hotspotCollection{
            return CGSize(width: hotspotCollection.frame.size.width / 2.5, height: hotspotCollection.frame.size.height)
            
        }else if collectionView == eventCollection{
            return CGSize(width: eventCollection.frame.size.width / 2.5, height: eventCollection.frame.size.height)
        }else{
            return CGSize(width: attractionsCollection.frame.size.width / 2.5, height: attractionsCollection.frame.size.height)
        }
    }
}
