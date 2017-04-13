//
//  ViewController.swift
//  facebookLogin
//
//  Created by mac on 3/16/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Google

var x: Int?
class ViewController: UIViewController  , GIDSignInUIDelegate, GIDSignInDelegate {
    let loginManager = FBSDKLoginManager()
    var fbData = [String: AnyObject]()
    var twiData = [String: AnyObject]()
    var lnData = [String: AnyObject]()
    var gData = [String: AnyObject]()
    var image: String?
    var name: String?
    var email: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
        //dobavi
      //  GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()!.options.clientID

  }


    @IBAction func LoginWithGoogle(_ sender: Any) {
       x=2
        loginManager.logOut()
        GIDSignIn.sharedInstance().signIn()
        
        
    }
    
    //Facebook
    @IBAction func LoginWithFB(_ sender: Any) {
        x=1

        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            
            if error != nil
            {
                print("error occured with login \(error?.localizedDescription)")
            }
                
            else if (result?.isCancelled)!
            {
                print("login canceled")
            }
                
            else
            {
                if FBSDKAccessToken.current() != nil
                {
                    
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, userResult, error) in
                        
                        
                        if error != nil
                        {
                            print("error occured \(error?.localizedDescription)")
                        }
                        else if userResult != nil
                        {
                            print("Login with FB is success")
                            print(userResult! as Any)
                            //                            let email = userResult["email"] as? String
                            let email = userResult as? [String:[AnyObject]]
                            //                             let email = result?["email"]
                            print(email as Any)
                            self.performSegue(withIdentifier: "showMapController", sender: self)
                            //
                            //                    let img_URL: String = (userResult.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
                            //
                            //                            let email = (userResult.objectForKey("email") as? String)!
                            //                            //                            let password = "1234567890" //(userResult.objectForKey("id") as? String)!
                            //                            let password =  (userResult.objectForKey("id") as? String)!
                            //
                            //                            let name = (userResult.objectForKey("name") as? String)!
                            
                        }
                        
                    })
                }
                
            }
            
        }
        

    }
    /******************************************************/
    /****************** Google Delegates *******************/
    /******************************************************/
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            
            let userId = user.userID                  // For client-side use only!
            let fullName = user.profile.name
            let email = user.profile.email
            let image = user.profile.imageURL(withDimension: 40)
            // [START_EXCLUDE]
            
            gData.updateValue(userId as AnyObject, forKey: "userId")
            gData.updateValue(fullName as AnyObject, forKey: "fullName")
            gData.updateValue(email as AnyObject, forKey: "email")
            gData.updateValue(image as AnyObject, forKey: "image")
            
            print(gData)
          

            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
             self.performSegue(withIdentifier: "showMapGoogle", sender: self)
            
            // [END_EXCLUDE]
            
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //        myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //dobavil
//    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
//        
//        
//        if let authentication = user.authentication
//        {
//            let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//            
//            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) -> Void in
//                if error != nil
//                {
//                    print("Problem at signing in with google with error : \(error)")
//                    
//                }
//                else if error == nil{
//                    print("user successfully signed in through GOOGLE! uid:\(FIRAuth.auth()!.currentUser!.uid)")
//                    
//                }
//            })
//        }
//    }
    
    
    
    
    @IBAction func logOut(_ sender: Any) {
        
              GIDSignIn.sharedInstance().signOut()
    }
    
    
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
