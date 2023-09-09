//
//  ViewController.swift
//  UIKitMarathon3
//
//  Created by alexeituszowski on 07.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider()
    
    let rectView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(slider)
        view.addSubview(rectView)
        
        slider.frame.origin.y = 300
        slider.addTarget(self, action: #selector(sliderChangeValue), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        slider.frame.size = CGSize(width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right, height: 50)
        slider.center.x = view.bounds.midX
        sliderChangeValue()
    }
    
    @objc
    func sliderChangeValue() {
        let value = slider.value
        layoutRectView(value: CGFloat(value))
    }
    
    func layoutRectView(value: CGFloat) {
        rectView.transform = CGAffineTransform(scaleX: 1 + value/2, y: 1 + value/2).rotated(by: value/2 * .pi)
        let startX = self.view.frame.width - view.layoutMargins.left - rectView.frame.width - view.layoutMargins.right
        let centerX = startX * value + rectView.frame.width / 2 + view.layoutMargins.right
        rectView.center.x = centerX
    }
    
    @objc
    func sliderTouchUpInside() {
        UIView.animate(withDuration: 0.5) {
            self.rectView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).rotated(by: .pi / 2)
            self.rectView.center.x = self.view.frame.width - self.view.layoutMargins.right - self.rectView.frame.width / 2
        }
        slider.setValue(slider.maximumValue, animated: true)
    }
}

