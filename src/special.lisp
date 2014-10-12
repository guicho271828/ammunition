(in-package :sokoban)

(defvar *preferred-packages* nil
  "List of package designators")

(defvar *preferred-symbols* nil
  "List of (string-desig . pkg-desig). Example:

 '((:match . :optima))

")

(defvar *cache-storage*
    (merge-pathnames ".cache/common-lisp/sokoban" (user-homedir-pathname))
  "List of package designators")
(ensure-directories-exist *cache-storage* :verbose t)
(defun reset-database ()
  (delete-file *cache-storage*)
  (ensure-directories-exist *cache-storage*  :verbose t))

(defvar *username*
    #+sbcl (sb-posix:getenv "USER")
    "Should be same as :author field in order to recognize your own
    library. Defaulted to the unix username.")


