//
//  PhotoCollectionViewController.swift
//  Photo Collection
//
//  Created by Wyatt Harrell on 2/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController {

    let photoController = PhotoController()
    let themeHelper = ThemeHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowAddVC" {
            
            guard let AddPhotoVC = segue.destination as? PhotoDetailViewController else { return }
        
            AddPhotoVC.themeHelper = themeHelper
            AddPhotoVC.photoController = photoController
            
        } else if segue.identifier == "ShowDetailVC" {
            
            guard let PhotoDetailVC = segue.destination as? PhotoDetailViewController else { return }
            
            guard let selection = collectionView.indexPathsForSelectedItems else { return }
            
            PhotoDetailVC.photo = photoController.photos[selection[0].row]
            PhotoDetailVC.photoController = photoController
            PhotoDetailVC.themeHelper = themeHelper
                        #warning("is [0] the last selected?")
            
        } else if segue.identifier == "ModalSelectTheme" {
            
            guard let SelectThemeVC = segue.destination as? PhotoDetailViewController else { return }
            
            SelectThemeVC.themeHelper = themeHelper
        }
        
        
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
    
        cell.photo = photoController.photos[indexPath.item]
    
        return cell
    }
    
    func setTheme() {
        guard let theme = themeHelper.themePreference else { return }
        
        if theme == "Light" {
            view.backgroundColor = .white
        } else if theme == "Dark" {
            view.backgroundColor = .darkGray
        }
        
    }

}
