;;;; clio-cffi.lisp

(in-package #:clio-cffi)

;;; ---------------------------------------------------------------------
;;; windows
;;; ---------------------------------------------------------------------

#+win32
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter $webview-loader-pathname
    (namestring (asdf:system-relative-pathname :clio-cffi "../webview-mikelevins/dll/x64/WebView2Loader"))))

#+nil (probe-file $webview-loader-pathname)

#+win32
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter $webview-library-pathname
    (namestring (asdf:system-relative-pathname :clio-cffi "../webview-mikelevins/dll/x64/webview"))))


#+win32
(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::register-foreign-library 'webview-loader-lib `((:win32 (:default ,$webview-loader-pathname)))))

#+win32
(cffi:use-foreign-library webview-loader-lib)

#+win32
(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::register-foreign-library 'webview-lib `((:win32 (:default ,$webview-library-pathname)))))

#+win32
(cffi:use-foreign-library webview-lib)

;;; ---------------------------------------------------------------------
;;; API definitions
;;; ---------------------------------------------------------------------


(cffi:defcfun (webview-create "webview_create" :library webview-lib) :pointer
  (debug :int)
  (window :pointer))

(cffi:defcfun (webview-destroy "webview_destroy" :library webview-lib) :void
  (webview :pointer))

#+nil (setf $wv (webview-create 1 (cffi:null-pointer)))
#+nil (webview-destroy $wv)

(cffi:defcfun (webview-run "webview_run" :library webview-lib) :void
  (webview :pointer))

#+nil (setf $wv (webview-create 1 (cffi:null-pointer)))
#+nil (webview-run $wv)
#+nil (webview-destroy $wv)

(cffi:defcfun (webview-terminate "webview_terminate" :library webview-lib) :void
  (webview :pointer))

;;; skip this one for now; it needs us to pass a function pointer, so it's inconvenient to implement
;;; void webview_dispatch(webview_t w, void (*fn)(webview_t w, void *arg), void *arg);

 ;; Returns a native window handle pointer. When using GTK backend the pointer
 ;; is GtkWindow pointer, when using Cocoa backend the pointer is NSWindow
 ;; pointer, when using Win32 backend the pointer is HWND pointer.
(cffi:defcfun (webview-get-window "webview_get_window" :library webview-lib) :pointer
  (webview :pointer))

(cffi:defcfun (webview-set-title "webview_set_title" :library webview-lib) :pointer
  (webview :pointer)
  (title :string))

#+nil (setf $wv (webview-create 1 (cffi:null-pointer)))
#+nil (webview-set-title $wv "Hello!")
#+nil (webview-destroy $wv)



;;; ---------------------------------------------------------------------
;;; macos
;;; ---------------------------------------------------------------------

;;; ---------------------------------------------------------------------
;;; linux
;;; ---------------------------------------------------------------------


