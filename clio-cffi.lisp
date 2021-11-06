;;;; clio-cffi.lisp

(in-package #:clio-cffi)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter $webview-loader-pathname
    #+win32
    (namestring (asdf:system-relative-pathname :clio-cffi "../webview-mikelevins/dll/x64/WebView2Loader"))))

#+nil (probe-file $webview-loader-pathname)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter $webview-library-pathname
    #+win32
    (namestring (asdf:system-relative-pathname :clio-cffi "../webview-mikelevins/dll/x64/webview"))))

#+nil (probe-file $webview-loader-pathname)
#+nil (probe-file $webview-library-pathname)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::register-foreign-library 'webview2-loader-lib `((:win32 (:default ,$webview-loader-pathname)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::register-foreign-library 'webview2-lib `((:win32 (:default ,$webview-library-pathname)))))

(cffi:use-foreign-library webview2-loader-lib)
(cffi:use-foreign-library webview2-lib)

(cffi:defcfun (webview-create "webview_create" :library webview2-lib) :pointer
  (debug :int)
  (window :pointer))

#+(setf $wv (webview-create 1 (cffi:null-pointer)))
