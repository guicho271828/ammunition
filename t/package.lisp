#|
  This file is a part of ammunition project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage :ammunition.test
  (:use :cl
        :ammunition.impl
        :fiveam))
(in-package :ammunition.test)



(def-suite :ammunition)
(in-suite :ammunition)

;; run test with (run! test-name) 
;;   test as you like ...

(test ammunition
  (is (equal (asdf:system-relative-pathname :ammunition.test.dummy "dummy.lisp")
             (package-source :ammunition.test.dummy)))
  (is (equal (asdf:find-system :ammunition.test.dummy)
             (source-system
              (package-source :ammunition.test.dummy))))
  (is (equal (asdf:find-system :ammunition.test.dummy)
             (source-system
              (package-source
               (symbol-package 'ammunition.test.dummy:dummy))))))

