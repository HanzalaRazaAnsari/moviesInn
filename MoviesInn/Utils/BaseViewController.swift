//
//  BaseViewController.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import UIKit
import SVProgressHUD

open class BaseViewController: UIViewController, UITextFieldDelegate, WebServiceDelegate {
    
    @IBOutlet public weak var scrollView: UIScrollView?
    var tapGesture: UITapGestureRecognizer!
    //    let progressLoader = JGProgressHUD(style: .dark)
    public var viewModel: BaseViewModel!
    public var refreshControl: UIRefreshControl?
    
    
//    let synthesizer = AVSpeechSynthesizer()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setStatusBar(backgroundColor: ThemeManager.shared.theme.primaryColour)
        //        self.navigationController?.navigationBar.setNeedsLayout()
        
        //Removing back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        let logoImage = UIImage.init(named: "tokriLogoNavImage")
        let logoImageView = UIImageView.init(image: logoImage)
        //logoImageView.frame = CGRect(x:0.0,y:0.0, width:60,height:25.0)
        logoImageView.frame = CGRect(x:0.0,y:0.0, width:60,height:25.0)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 80)
        let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 35)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.rightBarButtonItem =  imageItem
        
        // Do any additional setup after loading the view.
        self.scrollView?.keyboardDismissMode = .interactive
        
        if scrollView != nil{
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        }
        self.view.backgroundColor = .darkGray
        self.scrollView?.viewWithTag(100)?.backgroundColor = .lightGray
    }
    
    open func roundView(view:UIView){
        view.layer.cornerRadius = view.frame.height / 2
    }
    

    
    open func setPullToRefresh(tableView: UITableView, target: Any, refreshCallback: Selector){
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl?.addTarget(target, action: refreshCallback, for: .valueChanged)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.scrollView != nil{
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        }
        WebServiceManager.shared.delegate = self
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.scrollView != nil{
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        //        WebServiceManager.shared.delegate.hideLoader {
        //        }
    }
    
    open func registerTableViewCell(tableView: UITableView, cellXibName: String, id: String){
        tableView.register(UINib(nibName: cellXibName, bundle: nil), forCellReuseIdentifier: id)
    }
    open func registerCollectionViewCell(collection: UICollectionView, cellXibName: String, id: String){
        collection.register(UINib(nibName: cellXibName, bundle: nil), forCellWithReuseIdentifier: id)
    }
    
    
    @objc func tapAction(){
        self.view.endEditing(true)
        self.scrollView?.contentInset = .zero
    }
    
    open func showAlert(title: String?, message: String?){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

//        if var abc = UIApplication.shared.keyWindow?.rootViewController{
        if var abc = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
        
            while let xyz = abc.presentedViewController {
                abc = xyz
            }
            abc.present(alertVC, animated: true, completion: nil)
        }
    }
    
    open func showAlert(title: String?, message: String?, completion: @escaping ()->()){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            completion()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    open func showAlertForAction(title: String?, message: String?, buttonTitle:String , completion: @escaping ()->()){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            completion()
            
        }))
        
        if var abc = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController{
            while let xyz = abc.presentedViewController {
                abc = xyz
            }
            abc.present(alertVC, animated: true, completion: nil)
        }
    }
    
    open func showAlertForActionWithCancel(title: String?, message: String?, buttonTitle:String , completion: @escaping ()->()){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            completion()
        }))
        if var abc = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            while let xyz = abc.presentedViewController {
                abc = xyz
            }
            abc.present(alertVC, animated: true, completion: nil)
        }
        //        self.present(alertVC, animated: true, completion: nil)
    }
    
    open func showAlertWithTwoAction(title: String?, message: String?, buttonTitle:String ,buttonTwoTitle:String , completion: @escaping ()->() , completionTwo: @escaping ()->() ){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: buttonTwoTitle, style: .default, handler: { (action) in
            completionTwo()
        }))
        alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            completion()
            
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    open func showWarningAlert(title: String?, message: String?, warningButtonTitle: String, completion: @escaping ()->Void){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: warningButtonTitle, style: .default, handler: { (action) in
            completion()
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            guard let scroll = self.scrollView, let tap = self.tapGesture else {
                return
            }
            scroll.contentInset.bottom = keyboardSize.height
            scroll.addGestureRecognizer(tap)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil{
            guard let scroll = self.scrollView, let tap = self.tapGesture else {
                return
            }
            scroll.contentInset = .zero
            scroll.removeGestureRecognizer(tap)
        }
    }
    
    public func add(asChildViewController viewController: UIViewController, containerView: UIView) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    public func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    //MARK: WebServiceDelegate
    open func showLoader(message: String) {
        guard !SVProgressHUD.isVisible() else {
            return
        }
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    
    open func hideLoader(completed: @escaping ()->Void) {
        guard SVProgressHUD.isVisible() else {
            return
        }
        DispatchQueue.main.async {
            SVProgressHUD.dismiss(completion: completed)
        }
    }
    
    open func showMessage(message: String, isSuccess: Bool){
        self.showAlert(title: isSuccess ? "Success!": "Alert!", message: message)
    }
    open func showMessage(message: String, isSuccess: Bool, completion: @escaping ()->Void){
        self.showAlert(title: isSuccess ? "Success!": "Alert!", message: message)
    }
    
    
    public func cleanup() {
        self.viewModel = nil
    }
    open func textFieldDidEndEditing(_ textField: UITextField) { }
}
