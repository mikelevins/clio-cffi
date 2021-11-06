;;;; clio-cffi.asd

(asdf:defsystem #:clio-cffi
  :description "Describe clio-cffi here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:cffi)
  :components ((:file "package")
               (:file "clio-cffi")))

#+nil (asdf:load-system :clio-cffi)
