#|
  This file is a part of sokoban project.
  Copyright (c) 2014 guicho
|#

#|
  Author: guicho
|#



(in-package :cl-user)
(defpackage sokoban-asd
  (:use :cl :asdf))
(in-package :sokoban-asd)


(defsystem sokoban
  :version "0.1"
  :author "guicho"
  :mailto ""
  :license ""
  :depends-on (:optima :alexandria :iterate :swank :asdf)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "special"))))
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
  
  :in-order-to ((test-op (load-op sokoban.test))))
