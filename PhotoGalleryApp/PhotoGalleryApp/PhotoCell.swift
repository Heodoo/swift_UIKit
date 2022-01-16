//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 허두영 on 2022/01/15.
//

import UIKit
import PhotosUI
class PhotoCell : UICollectionViewCell {
    
    
    func loadImage (asset: PHAsset){
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        //150에 해당하는 픽셀을 곱하려면 scale을 곱해줘야함
        let imgSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic // .high~고화질만 받기, .fast~ 저화질만, 나머지하나 기본옵션 저화질에서 고화질
        self.photoImageView.image = nil
        //options nil로 해도 같음 .opportunistic옵션이 기본옵션이므로
        imageManager.requestImage(for: asset, targetSize: imgSize, contentMode: .aspectFill, options: options){ image,info in
//            if (info?[PHImageResultIsDegradedKey] as? Bool) == true{
//                //저화질
//                self.photoImageView.image = image
//            }else{
//                //고화질
//            }
            self.photoImageView.image = image
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    
}
