//
//  IntrensicTableView.swift
//  
//
//  Created by Muhammed Elsayed on 28/2/21.
//  Copyright © 2021 . All rights reserved.
//

import UIKit
class IntrinsicTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return contentSize
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

}

