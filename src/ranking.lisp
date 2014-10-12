(in-package :sokoban)

#|  symbols are inferred in this order:

 ^^^ stronger
 explicitly imported symbols
 preferred symbols
 preferred packages
 -----^^^mandatory rankings^^^-----
 personal reference count: 自分がauthorであるsystem中に現れる関数は、高く評価する。
 personal relevance count: preferred symbols と同じsystemに属する関数は、高く評価する。
 global reference count
 >> weaker

|#

;;;; assume the symbol is already accessible in *package*

(defun current-package-p (sym)
  (multiple-value-match (find-symbol sym)
    (((symbol- (package (eq *package*))) :internal)
     ;; not imported
     nil)
    (((symbol- package) (or :internal :external :inherited))
     ;; explicitly imported/exported, or used
     t)))

;;;; pseudo symbol

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defstruct pseudo-symbol
    "cache the symbol metadata"
    (name (error "required!") :type string)
    (package (error "required!") :type string)
    (system (error "required!") :type string)
    (depends-on (error "required!") :type list)))

;;;; these are computed only when the symbol should be imported from elsewhere.

;; map over the db of pseudo-symbols
(defun symbol-impact (psym)
  "compute the impact factor of each pseudo symbol"
  (vector (preferred-symbol-p psym)
          (preferred-package-p psym)
          (personal-references psym)
          (personal-relevance psym)
          (global-references psym)))


;;;;; predicates based on custom configurations

(defun preferred-symbol-p (psym)
  (match psym
    ((guard (pseudo-symbol- name package)
            (find-if (lambda (cons)
                       (match cons
                         ((cons (equal name) (equal package))
                          t)))
                     *preferred-symbols*))
     t))) ;; make it a boolean

(defun preferred-package-p (psym)
  (if (find (pseudo-symbol-package psym)
            *preferred-packages*
            :key #'find-package
            :test #'string=)
      t nil))

(defun personal-relevance (psym)
  "Returns T if the psym is in the same package as one of preferred
  symbols."
  (match psym
    ((guard (pseudo-symbol- package)
            (find-if (lambda (cons)
                       (match cons
                         ((cons _ (equal package))
                          t)))
                     *preferred-symbols*))
     t)))

