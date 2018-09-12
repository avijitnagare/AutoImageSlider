//
//  ViewController.swift
//  AutoSlider
//
//  Created by Avijit Nagare on 29/04/18.
//  Copyright © 2018 Crystal Hitech IT Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,TAPageControlDelegate {
  
    var index = 0
    var timer = Timer()
    
    var customPageControl2 = TAPageControl()
    @IBOutlet weak var scrollView: UIScrollView!
    var imageData = NSArray()
    var lblArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageData = ["image1.jpg", "image2.jpg","image3.jpg"]
        ////Add label on Image
        self.lblArray = ["Forest","Sunshine","Sea"]
        
        for i in 0..<self.imageData.count {
            
            let xPos =  self.view.frame.size.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x:xPos, y: 0, width: self.view.frame.width, height: self.scrollView.frame.size.height))
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: self.imageData[i] as! String)
            
            //Add label on Image
//            let lbl = UILabel()
//            lbl.text = String("\(self.lblArray[i] as! String)")
//            lbl.textColor = UIColor.green
//            lbl.sizeToFit()
//            lbl.center = CGPoint(x: imageView.frame.size.width  / 2,
//                                 y: imageView.frame.size.height / 2);
//            imageView.addSubview(lbl)
         
            self.scrollView.addSubview(imageView)
        }
         self.scrollView.delegate = self
        index=0
        
        self.customPageControl2 = TAPageControl(frame: CGRect(x: 20, y: self.scrollView.frame.origin.y+self.scrollView.frame.size.height, width: self.scrollView.frame.size.width, height: 40))
        self.customPageControl2.delegate = self
        self.customPageControl2.numberOfPages =  self.imageData.count
        self.customPageControl2.dotSize = CGSize(width: 20, height: 20)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(self.imageData.count), height: self.scrollView.frame.size.height)
        self.view.addSubview(self.customPageControl2)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runImages), userInfo:nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runImages() {
        self.customPageControl2.currentPage = index
        if index == self.imageData.count - 1 {
            index=0
        }else{
            index = index + 1
        }
        self.taPageControl(self.customPageControl2, didSelectPageAt: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        self.customPageControl2.currentPage = Int(pageIndex)
        index = Int(pageIndex)
    }
    func taPageControl(_ pageControl: TAPageControl!, didSelectPageAt currentIndex: Int) {
        index = currentIndex
        self.scrollView.scrollRectToVisible(CGRect(x: self.view.frame.size.width * CGFloat(currentIndex), y: 0, width: self.view.frame.width, height: self.scrollView.frame.size.height), animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
