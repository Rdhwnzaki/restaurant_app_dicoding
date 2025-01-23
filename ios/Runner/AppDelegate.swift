import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    if !UserDefaults.standard.bool(forKey: "Notification") {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
      }
      UserDefaults.standard.set(true, forKey: "Notification")
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
