#include "win32_window.h"

#include <dwmapi.h>
#include <flutter_windows.h>

#include "resource.h"

namespace {

class WindowClassRegistrar {
 public:
  ~WindowClassRegistrar() {
    if (class_registered_) {
      UnregisterClass(window_class_name_.c_str(), nullptr);
    }
  }

  const wchar_t* GetWindowClass(HINSTANCE instance) {
    if (!class_registered_) {
      WNDCLASS window_class = {};
      window_class.hCursor = LoadCursor(nullptr, IDC_ARROW);
      window_class.lpszClassName = window_class_name_.c_str();
      window_class.style = CS_HREDRAW | CS_VREDRAW;
      window_class.cbClsExtra = 0;
      window_class.cbWndExtra = 0;
      window_class.hInstance = instance;
      window_class.hIcon = LoadIcon(instance, MAKEINTRESOURCE(IDI_APP_ICON));
      window_class.hbrBackground = 0;
      window_class.lpfnWndProc = Win32Window::WndProc;
      if (RegisterClass(&window_class) == 0) {
        return nullptr;
      }
      class_registered_ = true;
    }
    return window_class_name_.c_str();
  }

  static WindowClassRegistrar& GetInstance() {
    static WindowClassRegistrar instance;
    return instance;
  }

 private:
  WindowClassRegistrar() = default;
  bool class_registered_ = false;
  std::wstring window_class_name_ = L"FLUTTER_RUNNER_WIN32_WINDOW";
};

}  // namespace

Win32Window::Win32Window() {}

Win32Window::~Win32Window() {
  Destroy();
}

bool Win32Window::Create(const std::wstring& title,
                         const Point& origin,
                         const Size& size) {
  Destroy();

  const wchar_t* window_class =
      WindowClassRegistrar::GetInstance().GetWindowClass(GetModuleHandle(nullptr));
  if (!window_class) {
    return false;
  }

  HWND window = CreateWindow(
      window_class, title.c_str(), WS_OVERLAPPEDWINDOW,
      Scale(origin.x, GetDpiForHWND(nullptr)),
      Scale(origin.y, GetDpiForHWND(nullptr)),
      Scale(size.width, GetDpiForHWND(nullptr)),
      Scale(size.height, GetDpiForHWND(nullptr)),
      nullptr, nullptr, GetModuleHandle(nullptr), this);

  if (!window) {
    return false;
  }

  UpdateTheme(window);

  return true;
}

bool Win32Window::Show() {
  return ShowWindow(window_handle_, SW_SHOWNORMAL) != 0;
}

void Win32Window::Destroy() {
  if (window_handle_) {
    DestroyWindow(window_handle_);
    window_handle_ = nullptr;
  }
}

void Win32Window::SetChildContent(HWND content) {
  child_content_ = content;
  SetParent(content, window_handle_);
  RECT frame = GetClientArea();
  MoveWindow(content, 0, 0, frame.right - frame.left, frame.bottom - frame.top, TRUE);
  SetFocus(content);
}

HWND Win32Window::GetHandle() {
  return window_handle_;
}

void Win32Window::SetQuitOnClose(bool quit_on_close) {
  quit_on_close_ = quit_on_close;
}

RECT Win32Window::GetClientArea() {
  RECT frame;
  GetClientRect(window_handle_, &frame);
  return frame;
}

LRESULT CALLBACK Win32Window::WndProc(HWND const window,
                                       UINT const message,
                                       WPARAM const wparam,
                                       LPARAM const lparam) noexcept {
  if (message == WM_NCCREATE) {
    auto window_struct = reinterpret_cast<CREATESTRUCT*>(lparam);
    auto win32_window = static_cast<Win32Window*>(window_struct->lpCreateParams);
    SetWindowLongPtr(window, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(win32_window));
    win32_window->window_handle_ = window;
  } else if (Win32Window* that = GetThisFromHandle(window)) {
    return that->MessageHandler(window, message, wparam, lparam);
  }

  return DefWindowProc(window, message, wparam, lparam);
}

LRESULT Win32Window::MessageHandler(HWND window,
                                    UINT const message,
                                    WPARAM const wparam,
                                    LPARAM const lparam) noexcept {
  switch (message) {
    case WM_DESTROY:
      window_handle_ = nullptr;
      if (quit_on_close_) {
        PostQuitMessage(0);
      }
      return 0;

    case WM_DPICHANGED: {
      auto rect = reinterpret_cast<RECT*>(lparam);
      SetWindowPos(window, nullptr, rect->left, rect->top,
                   rect->right - rect->left, rect->bottom - rect->top,
                   SWP_NOZORDER | SWP_NOACTIVATE);
      return 0;
    }

    case WM_SIZE: {
      RECT rect = GetClientArea();
      if (child_content_ != nullptr) {
        MoveWindow(child_content_, 0, 0, rect.right - rect.left,
                   rect.bottom - rect.top, TRUE);
      }
      return 0;
    }

    case WM_ACTIVATE:
      if (child_content_ != nullptr) {
        SetFocus(child_content_);
      }
      return 0;
  }

  return DefWindowProc(window, message, wparam, lparam);
}

bool Win32Window::OnCreate() {
  return true;
}

void Win32Window::OnDestroy() {}

Win32Window* Win32Window::GetThisFromHandle(HWND const window) noexcept {
  return reinterpret_cast<Win32Window*>(GetWindowLongPtr(window, GWLP_USERDATA));
}

void Win32Window::UpdateTheme(HWND const window) {
  BOOL dark_mode = FALSE;
  DwmSetWindowAttribute(window, DWMWA_USE_IMMERSIVE_DARK_MODE, &dark_mode, sizeof(dark_mode));
}
