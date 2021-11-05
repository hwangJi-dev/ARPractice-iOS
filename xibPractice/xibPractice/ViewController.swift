//
//  ViewController.swift
//  xibPractice
//
//  Created by 황지은 on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tagCV: UICollectionView!
    var tagArray: [String] = ["gkgkgkgk", "ddd", "adadada", "adsda"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        tagCV.delegate = self
        tagCV.dataSource = self
    }

    func registerNib() {
        let xibName = UINib(nibName: TagCVCell.identifier, bundle:
                                nil)
        tagCV.register(xibName, forCellWithReuseIdentifier: TagCVCell.identifier)
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCV.dequeueReusableCell(withReuseIdentifier: "TagCVCell", for: indexPath)
        if let cell = cell as? TagCVCell {
            cell.setAppData(tagText: tagArray[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tagArray[indexPath.row].size(withAttributes: nil).width + 24, height: 50)
    }
}
