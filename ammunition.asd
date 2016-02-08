#|
  This file is a part of ammunition project.
  Copyright (c) 2014 guicho
|#

#|
  Author: guicho
|#



(in-package :cl-user)
(defpackage ammunition-asd
  (:use :cl :asdf))
(in-package :ammunition-asd)


(defsystem ammunition
  :version "0.1"
  :author "guicho"
  :mailto ""
  :license ""
  :depends-on (:trivia :trivial-types :alexandria :iterate :swank :asdf :uiop)
  :components ((:module "src"
                :components
                ((:file :0.package)
                 (:file :1.special)
                 (:file :1.utility)
                 ;; analysis tools
                 (:file :2.db)
                 (:file :2.accessors)
                 (:file :3.ranking)
                 (:file :3.refcount)
                 ;; user level tools
                 (:file :3.hook))))
  :description ""
  
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"includes/README.org"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  
  :in-order-to ((test-op (load-op ammunition.test))))
