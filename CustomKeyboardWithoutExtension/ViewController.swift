//
//  ViewController.swift
//  CustomKeyboardWithoutExtension
//
//  Created by haranicle on 2014/12/11.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var sushiWindow:UIWindow?
    var sushiWindowKey: Void?
    var sushiButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configSushiButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        // キーボード表示、非表示の通知を受け取る。
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        // 通知を受け取らないようにする。
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**
    キーボードが表示された時の処理
    :param: notificaiton 通知
    */
    func keyboardDidShow(notificaiton:NSNotification) {
        println(__FUNCTION__)
        openSushiWindow()
    }
    
    /**
    キーボードが非表示になった時の処理
    :param: notificaiton 通知
    */
    func keyboardDidHide(notificaiton:NSNotification) {
        println(__FUNCTION__)
        closeShushiWindow()
    }
    
    func openSushiWindow() {
        sushiWindow = UIWindow(frame: CGRect(x: 230, y: 621, width: 42, height:42))
        sushiWindow?.windowLevel = UIWindowLevelNormal + 5
        sushiWindow?.makeKeyAndVisible()
        sushiWindow?.addSubview(sushiButton as UIView)
        sushiWindow?.backgroundColor = UIColor.orangeColor()
        
        objc_setAssociatedObject(UIApplication.sharedApplication(), &sushiWindowKey, sushiWindow, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
    func closeShushiWindow() {
        // ウインドウのRootViewControllerを破棄
        sushiWindow?.rootViewController?.view.removeFromSuperview()
        sushiWindow?.rootViewController = nil
        
        // ウインドウを破棄
        objc_setAssociatedObject(UIApplication.sharedApplication(), &sushiWindowKey, nil, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        sushiWindow = nil
        
        // メインウインドウをキーウインドウにする。
        UIApplication.sharedApplication().windows.first?.makeKeyAndVisible()
    }
    
    /**
    寿司ボタンの設定
    */
    func configSushiButton() {
        sushiButton.frame = CGRectMake(0, 0, 42, 42)
        sushiButton.setTitle("🍣", forState: UIControlState.Normal)
        sushiButton.addTarget(self, action: "sushiButtonPushed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /**
    寿司ボタンが押下された時の処理
    :param: sender センダー
    */
    func sushiButtonPushed(sender:AnyObject){
        println(__FUNCTION__)
        // ここテキトー　文字列の途中が選択されてたらいろいろしないといけない。
        textField.text = textField.text + "🍣"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }

}

