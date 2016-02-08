(in-package :ammunition)

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
