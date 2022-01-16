//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 허두영 on 2022/01/15.
//

// 네비게이션 컨트롤바 기반으로 버튼 만들기

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    //var images = [UIImage?]()
    var fetchResults: PHFetchResult<PHAsset>?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallery App"
        makeNavigtionItem()
        
        //collectionview 레이아웃 설정 추가
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2 - 0.5, height: 200)
        
        //셀 양옆 간격 조절
        layout.minimumInteritemSpacing = 1
        //셀 위아래 간격 조절
        layout.minimumLineSpacing = 1
        
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
        
        
    }
    
    
    
    func makeNavigtionItem () {
        
        //sf.symbols에서 아이콘 이름 복사 커맨드 쉬프트 c
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = UIColor.black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"),style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = UIColor.black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited{
            //화면에서 ui가 바뀌거나 하면 메인스레드에서 실행되야함
            DispatchQueue.main.async {
                self.showGallery()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .denied {
            DispatchQueue.main.async {
                //이미지 권한 설정 받기
                self.showAuthorizationDeniedAlert()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            
            PHPhotoLibrary.requestAuthorization { status in
                //[!매우중요] 권한설정을 받을때 Info.plist에서 privacy - photo usage ~ <string> : 권한설정이 필요한 이유를 추가해야 앱심사에서 허용해줌
                //권한설정을 받았으니 다시한번 체크필요
                self.checkPermission()
                
            }
        }
    }
    
    func showAuthorizationDeniedAlert() {
        let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else{
                return
            }
            
            //내 앱에대한 설정으로 가기
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showGallery() {
        //싱글톤 형태??
        let library = PHPhotoLibrary.shared()
        
        
        //selection image 설정을 건드리는데 유용한 configuration 사용
        var configuration = PHPickerConfiguration(photoLibrary: library)
        //이미지 10개까지 선택가능
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }

}
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
       if let asset = self.fetchResults?[indexPath.row] {
            cell.loadImage(asset: asset)
       }
        //cell.photoImageView
        return cell
        
    }
    
    
    
    
}

//이미지를 선택하고 작업을 완료했을때 delegate를 통해 데이터가 옴
extension ViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.map{
            $0.assetIdentifier ?? ""
        }
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
//       fetchAssets.enumerateObjects { asset, index, stop in
//            let imageManager = PHImageManager()
//            let scale = UIScreen.main.scale
//            //150에 해당하는 픽셀을 곱하려면 scale을 곱해줘야함
//            let imgSize = CGSize(width: 150 * scale, height: 150 * scale)
//            imageManager.requestImage(for: asset, targetSize: imgSize, contentMode: .aspectFill, options: nil){ image,info in
//                self.images.append(image) //image가 저화질 한번 고화질 한번 총 두번들어감
//                //그러니까 이 로직을 셀에서 처리하자 셀에 저화질을 그려주고 다시 고화질 그리기
                
//            }
//        }
        self.photoCollectionView.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

