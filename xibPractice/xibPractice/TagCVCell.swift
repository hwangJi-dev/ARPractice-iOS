//
//  TagCVCell.swift
//  xibPractice
//
//  Created by 황지은 on 2021/10/29.
//

import UIKit

class TagCVCell: UICollectionViewCell {
    
    static let identifier = "TagCVCell"
    @IBOutlet var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 각 셀의 backgroundColor를 설정 -> 이부분을 원하는 회색으로 설정해주시면 됩니다 !! -> layer의 backgroundColor는 UIColor가 아닌 CGColor를 사용하므로 UIColor 사용시 cgColor로 변환해주어야합니다 ㅎㅎ
        self.layer.backgroundColor = UIColor.gray.cgColor
        // 각 셀의 cornerRadius(둥글기)를 설정 -> frame의 높이값의 1/2를 해주면 둥글둥글 모양이 되어요~!
        self.layer.cornerRadius = self.frame.height / 2
        // 각 셀의 border의 너비값을 설정
        self.layer.borderWidth = 1
        // 각 셀의 border의 Color를 설정 -> layer의 borderColor는 UIColor가 아닌 CGColor를 사용하므로 UIColor 사용시 cgColor로 변환해주어야합니다 ㅎㅎ
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func setAppData(tagText: String) {
        tagLabel.text = tagText
        tagLabel.sizeToFit()
    }
}
