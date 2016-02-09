(in-package :ammunition.impl)

(defvar *cache-storage*
    (merge-pathnames ".cache/common-lisp/ammunition/" (user-homedir-pathname))
  "A pathname for database directory")

(defun reset-database ()
  (delete-file *cache-storage*)
  (ensure-directories-exist *cache-storage*  :verbose t))

(ensure-directories-exist *cache-storage* :verbose t)

(defun db-filename (args)
  (merge-pathnames (format nil "~{~a~^/~}" args) *cache-storage*))

(defun db (&rest args)
  (handler-case
      (with-open-file (s (db-filename args))
        (read s))
    (file-error ()
      nil)))

(defun (setf db) (newval &rest args)
  (let ((path (db-filename args)))
    (with-open-file (s path :if-does-not-exist :create :if-exists :supersede)
      (write newval :stream s))))

(defvar *email*
    (or (db :email)
        (setf (db :email)
              (progn
                (format *query-io* "Enter your email address as a maintainer of ASDF systems")
                (finish-output *query-io*)
                (read *query-io*))))
    "Should be same as :mailto field you usually use in your asdf system in
    order to recognize your own library.")

(defvar *preferred-authors* (list *email*)
  "List of authors (by email address)")

(defvar *preferred-systems* nil
  "List of asdf system designators")

(defvar *preferred-packages* nil
  "List of package designators")

(defvar *preferred-symbols* nil
  "List of pseudo-symbols.")

;;; all symbols & dependency graph

(defun all-symbols ()
  (remove-duplicates
   (iter (for (var)
              in-packages (list-all-packages)
              having-access (:external :internal))
         (collect var))))

(defun all-external-symbols ()
  (remove-duplicates
   (iter (for (var)
              in-packages (list-all-packages)
              having-access (:external))
         (collect var))))

;;;; pseudo symbol

(defstruct pseudo-symbol
  "stores the symbol metadata"
  (name (error "required!") :type string)
  (package (error "required!") :type string)
  (system (error "required!") :type string)
  (author (error "required!") :type string)
  #+nil (depends-on (error "required!") :type list))
