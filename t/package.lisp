#|
  This file is a part of sokoban project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage :sokoban.test
  (:use :cl
        :sokoban
        :fiveam))
(in-package :sokoban.test)



(def-suite :sokoban)
(in-suite :sokoban)

;; run test with (run! test-name) 
;;   test as you like ...

(test sokoban

  )

