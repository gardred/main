import UIKit
import UserNotifications
import SafariServices

class ViewController: UIViewController, UISearchBarDelegate {

    
//Notifications
    @IBAction func sendNotification (sender: UIButton) {
        scheduleNotifications(inSeconds: 10) {(success) in
            
        }
    }
    func scheduleNotifications(inSeconds seconds: TimeInterval, completion : (Bool) -> ()) {
        
        removeNotifications(withIdentifier: ["MyUniqueIdentifier"])
        
        let date = Date(timeIntervalSinceNow: seconds)
        print (Date ())
        print (date)
        
        let content = UNMutableNotificationContent ()
        content.title = "This is title of notification"
        content.body = "Notification"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month , .day , . hour , .minute , .second], from: date)
        let trigger = UNCalendarNotificationTrigger (dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    func removeNotifications (withIdentifier identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers : identifiers)
    }
    deinit {
        removeNotifications(withIdentifier: ["MyUniqueIdentifier"])
        
    }

    //Photo
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var button : UIButton!
    
    
    @IBAction func didTapButton () {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker , animated: true)
    }
    

    @IBAction func buttonTapped () {
        let vc = SFSafariViewController(url: URL(string: "http://www.google.com")!)
        
        present(vc , animated: true)
    }
//Animation
    
    var figure1: CAShapeLayer!
    var figure2 : CAShapeLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createShapes()
        let gesture = UITapGestureRecognizer(target: self, action: #selector (self.tapped(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func tapped(_ sender : UITapGestureRecognizer ) {
        
        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        pathAnimation.fromValue = figure1.path
        figure1.path = figure2.path
        pathAnimation.toValue = figure2.path
      
        
        figure1.add(pathAnimation , forKey: nil)
        
        let fillColorAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        fillColorAnimation.fromValue = figure1.fillColor
        figure1.fillColor = figure2.fillColor
        fillColorAnimation.toValue = figure2.fillColor
        
        
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 4 * Float.pi
        
        let group = CAAnimationGroup ( )
        group.duration = 1
        group.animations = [pathAnimation , rotateAnimation , fillColorAnimation]
        figure1.add(group , forKey: nil)
        
    }
    
    
    func createShapes() {
        figure1 = CAShapeLayer()
        let rect = CGRect(x: self.view.frame.width / 2 - 50,
                          y: self.view.frame.height / 2 - 50,
                          width: 100,
                          height: 100)
        figure1.path = UIBezierPath(roundedRect: rect , cornerRadius: 0).cgPath
        figure1.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(figure1)
        
        figure1.frame=self.view.bounds
        
        figure2 = CAShapeLayer()
        let rectForFigure2 = CGRect(x: self.view.frame.width / 2 - 75,
                          y: self.view.frame.height / 2 - 75,
                          width: 150,
                          height: 150)
        figure2.path = UIBezierPath(ovalIn: rectForFigure2).cgPath
        figure2.fillColor = UIColor.green.cgColor
        view.layer.addSublayer(figure1)
    
    }
    
  /*  override func viewDidAppear (_ animated : Bool) {
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    */
    
}

//Photo
extension ViewController : UIImagePickerControllerDelegate ,
                           UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated : true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else {
            return
        }
        imageView.image = image
    }
   
}


