#|
  This file is a part of ammunition project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage :ammunition.test
  (:use :cl
        :ammunition
        :fiveam))
(in-package :ammunition.test)



(def-suite :ammunition)
(in-suite :ammunition)

;; run test with (run! test-name) 
;;   test as you like ...

(test ammunition

  )

