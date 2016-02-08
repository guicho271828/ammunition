(in-package :ammunition.impl)

(defvar *old-hook* nil)
(defun %enable-ammunition ()
  (shiftf *old-hook*
          *macroexpand-hook*
          #'ammunition-hook))

(defun %disable-ammunition ()
  (shiftf *macroexpand-hook*
          *old-hook*
          nil))

(defmacro enable-ammunition ()
  `(eval-when (:compile-toplevel)
     ;; (defpackage ,temp)
     ;;   (in-package ,temp)
     (%enable-ammunition)))


;;;; hook

(defun ammunition-hook (expand-fn form environment)
  ;; now, after (enable-ammunition),
  ;; current package is set to a temporary package.
  ;; 
  (funcall expand-fn
           (walk-tree (lambda (node cont)
                        (typecase node
                          (cons (funcall cont node))
                          (symbol (convert-symbol node))
                          (t node)))
                      form)
           environment))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (setf (fdefinition 'symbol-p) #'symbolp))

(defun convert-symbol (sym)
  (reduce #'symbol-impact<
          (remove sym (find-all-symbols sym))
          :key #'symbol-impact))

