
import WinSDK
import dispatch

public func ApplicationMain(_ argc: Int32,
                            _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>,
                            _ application: Application?,
                            _ delegate: ApplicationDelegate?) -> Int32 {
  delegate?.application(application, willFinishLaunchingWithOptions: [])

  delegate?.application(application, didFinishLaunchingWithOptions: [])

  var msgMessage: MSG = MSG()
  while GetMessageW(&msgMessage, self.hWnd, 0, 0) != FALSE {
    TranslateMessage(&msgMessage)
    DispatchMessageW(&msgMessage)
  }
  return EXIT_SUCCESS
}
