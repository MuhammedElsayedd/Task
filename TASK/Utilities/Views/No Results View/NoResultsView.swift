//
//  NoResultsView.swift
//
//  Created by Muhammed Elsayed on 28/2/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit

class NoResultsView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    private var title: String = "No Results"
    private var subtitle: String = ""
    private var image: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let nibName = "NoResultsView"
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func draw(_ rect: CGRect) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
    }
    
    func config(with title: String = "No Results", subtitle: String = "", image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }

}
