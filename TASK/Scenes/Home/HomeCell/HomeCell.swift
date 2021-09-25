//
//  HotspotsCell.swift
//  TASK
//
//  Created by Muhammed Elsayed on 3/31/21.
//

import UIKit

class HomeCell: UICollectionViewCell {

    // MARK:- Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configHotspot(with hotSpot: HotSpot){
        image.getImage(url: hotSpot.profile_photo ?? "")
        titleLabel.text = hotSpot.name ?? ""
        categoryLabel.text = hotSpot.arabic_name ?? ""
    }
    
    func configEvents(with events: Event){
        if events.profile_photo != nil{
        image.getImage(url: events.profile_photo ?? "")
        }
        titleLabel.text = events.name ?? ""
        categoryLabel.text = events.description ?? ""
    }
    
    func configAttractions(with attraction: Attraction){
        if attraction.profile_photo != nil{
            image.getImage(url: attraction.profile_photo ?? "")
        }
        titleLabel.text = attraction.name ?? ""
        categoryLabel.text = attraction.arabic_name ?? ""
    }

}
