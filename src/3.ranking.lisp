(in-package :ammunition.impl)

#|  symbols are inferred in this order:

 ^^^ stronger
 accessible symbols (incl. imported)
 preferred symbols
 preferred packages
 preferred system
 -----^^^mandatory rankings^^^-----
 personal reference count: 自分がauthorであるsystem中に現れる関数は、高く評価する。
 preferred symbol relevance : preferred symbols と同じsystemに属する関数は、高く評価する。
 preferred symbol relevance : preferred symbols と同じsystemに属する関数は、高く評価する。
 global reference count
 >> weaker

|#

;; map over the db of pseudo-symbols
(defun symbol-impact (psym)
  "compute the impact factor of each pseudo symbol"
  (vector (accessible-symbol-p psym)
          ;; predicates based on custom configurations
          (preferred-symbol-p psym)
          (preferred-package-p psym)
          (preferred-system-p psym)
          ;; relevance to the preferred symbols
          (preferred-symbol-relevance psym)
          (preferred-package-relevance psym)
          (preferred-system-relevance psym)
          ;; relevance to yourself
          (personal-relevance psym)
          (personal-reference psym)
          (global-references psym)))


;;;; predicates based on custom configurations


(defun accessible-symbol-p (psym)
  (if (find-symbol (pseudo-symbol-name psym))
      t nil))

(defun preferred-symbol-p (psym)
  (if (find psym
            *preferred-symbols*
            :test #'equalp)
      t nil))

(defun preferred-package-p (psym)
  (if (find (pseudo-symbol-package psym)
            *preferred-packages*
            :test #'string-equal)
      t nil))

(defun preferred-system-p (psym)
  (if (find (pseudo-symbol-system psym)
            *preferred-systems*
            :test #'string-equal)
      t nil))

(defun preferred-author-p (psym)
  (if (find (pseudo-symbol-author psym)
            *preferred-authors*
            :test #'string-equal)
      t nil))

;;;; relevance

(defun preferred-symbol-relevance (psym)
  "Count the number of preferred symbols which are in the same package as PSYM"
  (count (pseudo-symbol-package psym)
         *preferred-symbols*
         :test #'string-equal
         :key #'pseudo-symbol-package))

(defun preferred-package-relevance (psym)
  "Count the number of preferred packages which are in the same system as PSYM"
  (count (pseudo-symbol-system psym)
         *preferred-packages*
         :test #'string-equal
         :key (compose #'asdf:component-name #'package-system)))

(defun preferred-system-relevance (psym)
  "Count the number of preferred systems which are written by the same author as PSYM"
  (count (pseudo-symbol-author psym)
         *preferred-systems*
         :test #'string-equal
         :key (compose #'asdf:system-mailto #'asdf:find-system)))




