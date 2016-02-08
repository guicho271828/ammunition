#|
  This file is a part of ammunition project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage ammunition.impl
  (:use :cl :trivia :alexandria :iterate)
  (:export
   #:package-source
   #:source-system
   #:symbol-system
   #:symbol-author
   #:package-author
   #:system-source))

