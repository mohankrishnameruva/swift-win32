/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import WinSDK

public protocol ButtonDelegate: class {
  func OnLeftButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
  func OnRightButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT
}

public extension ButtonDelegate {
  func OnLeftButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }

  func OnRightButtonPressed(_ hWnd: HWND?, _ wParam: WPARAM, _ lParam: LPARAM) -> LRESULT {
    return 1
  }
}

internal let SwiftButtonProc: SUBCLASSPROC = { (hWnd, uMsg, wParam, lParam, uIdSubclass, dwRefData) in
  let button: Button? = unsafeBitCast(dwRefData, to: AnyObject.self) as? Button
  switch uMsg {
  case UINT(WM_LBUTTONDOWN):
    if button?.delegate?.OnLeftButtonPressed(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  case UINT(WM_RBUTTONDOWN):
    if button?.delegate?.OnRightButtonPressed(hWnd, wParam, lParam) == 0 {
      return 0
    }
    break
  default:
    break
  }
  return DefSubclassProc(hWnd, uMsg, wParam, lParam)
}

public class Button: Control {
  public static let `class`: WindowClass = WindowClass(named: "BUTTON")

  public weak var delegate: ButtonDelegate?

  public override init(frame: Rect = .default, `class`: WindowClass = Button.class,
                       style: WindowStyle = (base: DWORD(WS_TABSTOP | WS_VISIBLE | BS_PUSHBUTTON),
                                             extended: 0)) {
    super.init(frame: frame, class: `class`, style: style)
    SetWindowSubclass(hWnd, SwiftButtonProc, UINT_PTR(1),
                      unsafeBitCast(self as AnyObject, to: DWORD_PTR.self))
  }

  public convenience init(frame: Rect = .zero, `class`: WindowClass = Button.class,
                          style: WindowStyle = (base: DWORD(WS_TABSTOP | WS_VISIBLE | BS_PUSHBUTTON),
                                                extended: 0),
                          title: String) {
    self.init(frame: frame, class: `class`, style: style)
    setTitle(title, forState: .normal)
  }

  // FIXME(compnerd) handle title setting for different states
  public func setTitle(_ title: String?, forState _: Control.State) {
    SetWindowTextW(hWnd, title?.LPCWSTR)
  }
}
