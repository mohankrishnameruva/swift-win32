
public struct Application {
  public static var shared: Application = Application()
  public var delegate: ApplicationDelegate?
}

public extension Application {
  struct LaunchOptionsKey: Hashable, Equatable, RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
      self.rawValue = rawValue
    }
  }
}

public extension Application.LaunchOptionsKey {
  static let annotation: Application.LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.Annotation")
  static let bluetoothCentrals: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.BluetoothCentrals")
  static let bluetoothPeripherals: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.BluetoothPeripherals")
  static let cloudKitShareMetadata: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.CloudKitShareMetadata")
  @available(*, deprecated)
  static let localNotification: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.LocalNotification")
  static let location: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.Location")
  static let newsstandDownloads: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.NewsStandDownloads")
  static let remoteNotification: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.RemoteNotification")
  static let shortcutItem: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.ShortCutItem")
  static let sourceApplication: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.SourceApplication")
   static let url: LaunchOptionsKey =
      Application.LaunchOptionsKey(rawValue: "Application.URL")
   static let userActivityDictionary =
      Application.LaunchOptionsKey(rawValue: "Application.UserActivityDictionary")
   static let userActivityType =
      ApplicationDelegate.LaunchOptionsKey(rawValue: "Application.UserActivityType")
}
