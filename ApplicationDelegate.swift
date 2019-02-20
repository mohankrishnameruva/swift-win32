
public protocol ApplicationDelegate: class {
  func application(_: Application,
                   willFinishLaunchingWithOptions: [Application.LaunchOptionsKey:Any])
      -> Bool

  func application(_: Application,
                   didFinishLaunchingWithOptions: [Application.LaunchOptionsKey:Any])
      -> Bool
}

public extension ApplicationDelegate {
  func application(_: Application, willFinishLaunchingWithOptions: [Application.LaunchOptionsKey:Any]) -> Bool {
    return false
  }

  func application(_: Application, didFinishLaunchingWithOptions: [Application.LaunchOptionsKey:Any]) -> Bool {
    return false
  }
}