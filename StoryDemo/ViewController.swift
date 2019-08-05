//
//  ViewController.swift
//  StoryDemo
//
//  Created by Sneha Harke on 24/06/19.
//  Copyright © 2019 Sneha Harke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var storyHeaderCollectionView: UICollectionView!
    @IBOutlet weak var storyDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(storyHeaderCollectionView)
        
        self.storyDetailCollectionView.isPagingEnabled = true
        
        self.storyHeaderCollectionView.delegate = self
        self.storyHeaderCollectionView.dataSource = self
        
        self.storyDetailCollectionView.delegate = self
        self.storyDetailCollectionView.dataSource = self
        
        self.storyHeaderCollectionView.register(UINib(nibName: "StoryHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryHeaderCollectionViewCell")
        self.storyDetailCollectionView.register(UINib(nibName: "StoryDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryDetailsCollectionViewCell")
        
        self.storyHeaderCollectionView.reloadData()
        
        
        let layout = storyDetailCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: screenWidth, height: screenHeight)
        
        self.storyDetailCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyHeaderCollectionView {
            guard let cell = storyHeaderCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryHeaderCollectionViewCell", for: indexPath) as? StoryHeaderCollectionViewCell else { return UICollectionViewCell() }
            
            cell.countLabel.text = String(indexPath.row)
            
            return cell
        } else {
            guard let cell = storyDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryDetailsCollectionViewCell", for: indexPath) as? StoryDetailsCollectionViewCell else { return UICollectionViewCell() }
            cell.countLabel.text = String(indexPath.row)
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == storyDetailCollectionView {
            self.storyHeaderCollectionView.contentOffset.x = self.storyDetailCollectionView.contentOffset.x/4
        }
    }
    
}

