;;;; clio-cffi.lisp

(in-package #:clio-cffi)

;;; ---------------------------------------------------------------------
;;; windows
;;; ---------------------------------------------------------------------

(defparameter +WEBVIEW_HINT_NONE+ 0)  ; Width and height are default size
(defparameter +WEBVIEW_HINT_MIN+ 1)   ; Width and height are minimum bounds
(defparameter +WEBVIEW_HINT_MAX+ 2)   ; Width and height are maximum bounds
(defparameter +WEBVIEW_HINT_FIXED+ 3) ; Window size can not be changed by a user

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

(cffi:defcfun (webview-set-size "webview_set_size" :library webview-lib) :void
  (webview :pointer)
  (width :int)
  (height :int)
  (hints :int))

(cffi:defcfun (webview-navigate "webview_navigate" :library webview-lib) :void
  (webview :pointer)
  (url :string))

;;; Injects JavaScript code at the initialization of the new page. Every time
;;; the webview will open a the new page - this initialization code will be
;;; executed. It is guaranteed that code is executed before window.onload.
(cffi:defcfun (webview-init "webview_init" :library webview-lib) :void
  (webview :pointer)
  (js :string))

(cffi:defcfun (webview-eval "webview_eval" :library webview-lib) :void
  (webview :pointer)
  (js :string))

;;; Binds a native C callback so that it will appear under the given name as a
;;; global JavaScript function. Internally it uses webview_init(). Callback
;;; receives a request string and a user-provided argument pointer. Request
;;; string is a JSON array of all the arguments passed to the JavaScript
;;; function.
;; WEBVIEW_API void webview_bind(webview_t w, const char *name,
;;                               void (*fn)(const char *seq, const char *req,
;;                                          void *arg),
;;                               void *arg);

;;; Allows to return a value from the native binding. Original request pointer
;;; must be provided to help internal RPC engine match requests with responses.
;;; If status is zero - result is expected to be a valid JSON result value.
;;; If status is not zero - result is an error JSON object.
;; WEBVIEW_API void webview_return(webview_t w, const char *seq, int status,
;;                                 const char *result);



#+nil (setf $wv (webview-create 1 (cffi:null-pointer)))
#+nil (webview-set-title $wv "Hello!")
#+nil (webview-set-size $wv 800 600 +WEBVIEW_HINT_NONE+)
#+nil (webview-navigate $wv "http://en.wikipedia.org")
#+nil (webview-run $wv)
#+nil (webview-terminate $wv)
#+nil (webview-destroy $wv)


;;; ---------------------------------------------------------------------
;;; macos
;;; ---------------------------------------------------------------------

;;; ---------------------------------------------------------------------
;;; linux
;;; ---------------------------------------------------------------------


