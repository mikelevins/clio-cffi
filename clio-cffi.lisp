;;;; clio-cffi.lisp

(in-package #:clio-cffi)

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

(cffi:defcfun (webview-create "webview_create" :library webview-lib) :pointer
  (debug :int)
  (window :pointer))

#+nil (setf $wv (webview-create 1 (cffi:null-pointer)))

;;; macos
;;; ---------------------------------------------------------------------

;;; linux
;;; ---------------------------------------------------------------------


