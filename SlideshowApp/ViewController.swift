//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 張翔 on 2017/09/20.
//  Copyright © 2017年 sho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var startAndStopUI: UIButton!
    @IBOutlet var nextPicUI: UIButton!
    @IBOutlet var backPicUI: UIButton!
    
    let images: [String] = ["neko1.jpg", "neko2.jpg", "neko3.jpg", "neko4.jpg", "neko5.jpg", "neko6.jpg", "neko7.jpg", "neko8.jpg"]
    var imageNumber: Int = 0
    
    var AutoPlay: Bool = false
    
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //imageの初期設定
        imageView.image = UIImage(named: images[imageNumber])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAndStop(){
        if AutoPlay == false{
            nextPicUI.isEnabled = false
            backPicUI.isEnabled = false
            startAndStopUI.setTitle("停止", for: .normal)
            
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextPic), userInfo: nil, repeats: true)
            
            AutoPlay = true
        }else{
            nextPicUI.isEnabled = true
            backPicUI.isEnabled = true
            startAndStopUI.setTitle("再生", for: .normal)
            
            timer.invalidate()
            
            AutoPlay = false
        }
    }
    
    @IBAction func nextPic(){
        
        //最後の一枚か判定
        if imageNumber != 7 {
            imageNumber += 1
        }else{
            imageNumber = 0
        }
        
        imageView.image = UIImage(named: images[imageNumber])
    }
    
    @IBAction func backPic(){
        //最初の一枚か判定
        if imageNumber != 0 {
            imageNumber -= 1
        }else{
            imageNumber = 7
        }
        
        imageView.image = UIImage(named: images[imageNumber])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController: DetailViewController = segue.destination as! DetailViewController
        detailViewController.image = UIImage(named: images[imageNumber])
        
        //スライドショーを一旦停止
        if AutoPlay == true{
            timer.invalidate()
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){
        //スライドショーを再開
        if AutoPlay == true{
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextPic), userInfo: nil, repeats: true)
        }
    }


}

