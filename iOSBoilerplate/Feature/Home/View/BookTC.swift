//
//  BookTC.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Kingfisher
import UIKit

class BookTC: UITableViewCell, CellInterface {
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var viewModel: BookTCVM? {
        didSet {
            bindViewModel()
        }
    }

    private func bindViewModel() {
        if let vm = viewModel {
            lblTitle.text = vm.titleVM
            lblSubTitle.text = vm.subTitleVM
            let url = URL(string: vm.previewVM)
            imgView.kf.setImage(with: url)
        }
    }
}
