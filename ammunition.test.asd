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
               :ammunition.test.dummy
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "package"))))
  :perform (test-op :after (op c) (eval (read-from-string "(fiveam:run! :ammunition)"))))
