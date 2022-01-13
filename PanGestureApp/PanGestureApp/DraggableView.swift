//
//  DraggableView.swift
//  PanGestureApp
//
//  Created by 허두영 on 2022/01/13.
//

import UIKit

class DraggableView : UIView {
    
    var dragType = DragType.none
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
      //  fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        //누르는 순간
        case .began:
            print("began")
        //움직일떄
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            if dragType == .x{
                
                myPosition.x += delta.x
            }else if dragType == .y{
                
                myPosition.y += delta.y
            }else {
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            self.center = myPosition
            
            //참고 https://zeddios.tistory.com/356
            //다음 translation이 들어오기전에 translation 초기화
            pan.setTranslation(CGPoint.zero, in: superview)
            
        //끝내거나 다른작업으로 이동했을떄
        case .ended,.cancelled:
            print("ended or canceled")
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            if self.frame.minY < 0 {
                self.frame.origin.y = 0
            }
            if let hasSuperView = self.superview {
                if self.frame.maxX > hasSuperView.frame.maxX{
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
                if self.frame.maxY > hasSuperView.frame.maxY{
                    self.frame.origin.y = hasSuperView.frame.maxY - self.bounds.height
                }
                
            }
       
        default:
            break
        }
        
    }
    
}
