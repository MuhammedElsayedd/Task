//
//  Loader.swift
//
//  Created by Muhammed Elsayed on 28/2/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit
//import Lottie

class LoaderView: UIView {
//    let animationView = AnimationView()

    class func instanceFromNib() -> LoaderView {
        return UINib(nibName: "LoaderView",
                     bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoaderView
    }

    override func draw(_ rect: CGRect) {
//        let animation = Animation.named("loading", subdirectory: "")
//        animationView.frame.size = CGSize(width: 200, height: 200)
//        animationView.center = self.center
//
//        animationView.animation = animation
//        animationView.contentMode = .scaleAspectFit
//
//        self.addSubview(animationView)
//
//        animationView.backgroundColor = .clear
//        animationView.backgroundBehavior = .pauseAndRestore
//        animationView.animationSpeed = 0.7
//        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
//        animationView.play(fromProgress: 0,
//                           toProgress: 1,
//                           loopMode: LottieLoopMode.autoReverse,
//                           completion: { (finished) in
//                            if finished {
//                                print("Animation Complete")
//                            } else {
//                                print("Animation cancelled")
//                            }
//        })
    }

}
