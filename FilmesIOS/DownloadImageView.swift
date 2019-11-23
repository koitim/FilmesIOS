//
//  DownloadImageView.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit

class DownloadImageView: UIImageView {
    var progress: UIActivityIndicatorView!
    let queue = OperationQueue()
    let mainQueue = OperationQueue.main
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createProgress()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgress()
    }
    
    func createProgress() {
        progress = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        addSubview(progress)
    }
    
    override func layoutSubviews() {
        progress.center = convert(self.center, from: self.superview)
    }
    
    func setURL(_ url: String) {
        setURL(url, cache: true)
    }
    
    func setURL(_ url: String, cache: Bool) {
        self.image = nil
        queue.cancelAllOperations()
        progress.startAnimating()
        queue.addOperation {
            self.downloadImg(url, cache: true)
        }
    }
    
    func downloadImg(_ url: String, cache: Bool) {
        var data: Data!
        if (!cache) {
            data = try! Data(contentsOf: URL(string: url)!)
        } else {
            var path = url.replace("/", with: "_")
            path = path.replace("\\", with: "_")
            path = path.replace(":", with: "_")
            path = NSHomeDirectory() + "/Documents/" + path
            let exists = FileManager.default.fileExists(atPath: path)
            if (exists) {
                data = try? Data(contentsOf: URL(fileURLWithPath: path))
            } else {
                data = try? Data(contentsOf: URL(string: url)!)
                if (data != nil) {
                    try! data.write(to: URL(fileURLWithPath: path), options: .atomic)
                }
            }
        }
        if (data != nil) {
            mainQueue.addOperation {
                self.showImg(data)
            }
        }
    }
    
    func showImg(_ data: Data) {
        if data.count > 0 {
            self.image = UIImage(data: data)
        }
        progress.stopAnimating()
    }
}
