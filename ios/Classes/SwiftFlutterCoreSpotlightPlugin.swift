import Flutter
import UIKit
import CoreSpotlight
import MobileCoreServices

public class SwiftFlutterCoreSpotlightPlugin: NSObject, FlutterPlugin {
  
  var channel: FlutterMethodChannel?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_core_spotlight", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterCoreSpotlightPlugin()
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "index_searchable_items":
      guard let arguments = call.arguments as? [[String: Any]] else {
        result(FlutterError())
        break
      }
      let searchableItems = arguments.map { itemMap -> CSSearchableItem in
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = itemMap["attributeTitle"] as? String
        attributeSet.contentDescription = itemMap["attributeDescription"] as? String
        
        let item = CSSearchableItem(uniqueIdentifier: "\(itemMap["uniqueIdentifier"] as? String ?? "")",
                                    domainIdentifier: itemMap["domainIdentifier"] as? String ?? "",
                                    attributeSet: attributeSet)
        return item
      }
      CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
        if let error = error {
          result(FlutterError(code: "500", message: error.localizedDescription, details: nil))
        } else {
          result("success")
        }
      }
      break
    case "delete_searchable_items":
      guard let arguments = call.arguments as? [String] else {
        result(FlutterError())
        break
      }
      CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: arguments) { error in
        if let error = error {
          result(FlutterError(code: "500", message: error.localizedDescription, details: nil))
        } else {
          result("success")
        }
      }
      break
    default:
      result(FlutterError())
      break
    }
  }
   
  public func application(_ application: UIApplication,
                         continue userActivity: NSUserActivity,
                         restorationHandler: @escaping ([Any]) -> Void) -> Bool {
    if userActivity.activityType == CSSearchableItemActionType {
      userActivity.resignCurrent()
      userActivity.invalidate()
      channel?.invokeMethod("onSearchableItemSelected",
                            arguments: [
                              "key": userActivity.activityType,
                              "uniqueIdentifier": userActivity.userInfo?[CSSearchableItemActivityIdentifier],
                              "userInfo": userActivity.userInfo
                            ])
    }
    return false
  }
}
