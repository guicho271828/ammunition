#|
  This file is a part of ammunition project.
  Copyright (c) 2014 guicho
|#


(in-package :cl-user)
(defpackage ammunition.test-asd
  (:use :cl :asdf))
(in-package :ammunition.test-asd)


(defsystem ammunition.test
  :author "guicho"
  :license ""
  :depends-on (:ammunition
               :fiveam)
  :components ((:module "t"
                :components
                ((:file ""))))
  :perform (load-op :after (op c) (PROGN (EVAL (READ-FROM-STRING "(fiveam:run! :ammunition)")) (CLEAR-SYSTEM C))))
