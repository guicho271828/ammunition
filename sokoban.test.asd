#|
  This file is a part of sokoban project.
  Copyright (c) 2014 guicho
|#


(in-package :cl-user)
(defpackage sokoban.test-asd
  (:use :cl :asdf))
(in-package :sokoban.test-asd)


(defsystem sokoban.test
  :author "guicho"
  :license ""
  :depends-on (:sokoban
               :fiveam)
  :components ((:module "t"
                :components
                ((:file ""))))
  :perform (load-op :after (op c) (PROGN (EVAL (READ-FROM-STRING "(fiveam:run! :sokoban)")) (CLEAR-SYSTEM C))))
