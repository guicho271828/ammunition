(in-package :sokoban)

(defvar *old-hook* nil)
(defun %enable-sokoban ()
  (shiftf *old-hook*
          *macroexpand-hook*
          #'sokoban-hook))

(defun %disable-sokoban ()
  (shiftf *macroexpand-hook*
          *old-hook*
          nil))

(defmacro enable-sokoban ()
  `(eval-when (:compile-toplevel)
     ;; (defpackage ,temp)
     ;;   (in-package ,temp)
     (%enable-sokoban)))


;;;; hook

(defun sokoban-hook (expand-fn form environment)
  ;; now, after (enable-sokoban),
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

