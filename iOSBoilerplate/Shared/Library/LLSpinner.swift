//
//  LLSpinner.swift
//  LLSpinner
//
//  Created by Aleph Retamal on 9/22/16.
//  Copyright © 2016 lalafon. All rights reserved.
//

import UIKit

open class LLSpinner {
    internal static var spinnerView: UIActivityIndicatorView?

    public static var style: UIActivityIndicatorView.Style = .white
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)

    internal static var touchHandler: (() -> Void)?

    public static func spin(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil,
           let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.style = style
            window.addSubview(spinnerView!)
            spinnerView!.startAnimating()
        }

        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }

    public static func stop() {
        if let _ = spinnerView {
            spinnerView!.stopAnimating()
            spinnerView!.removeFromSuperview()
            spinnerView = nil
        }
    }
}
