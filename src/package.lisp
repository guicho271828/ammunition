#|
  This file is a part of sokoban project.
  Copyright (c) 2014 guicho
|#

(in-package :cl-user)
(defpackage sokoban
  (:use :cl :optima :alexandria :iterate))
(in-package :sokoban)

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


;; note: useful functions
;; (swank-backend:who-calls 'alexandria:plist-alist)
;; (swank-backend:find-definitions 'alexandria:plist-alist)
;; (swank-backend:find-source-location 'alexandria:plist-alist)
;; (symbol-package 'alexandria:plist-alist)

;; asdf/component:component-pathname
;; asdf/component:component-children
;; (asdf:registered-systems)
;; (asdf:map-systems fn)


;; cl:symbol-package

(defun package-source (pkg-designator)
  (second
   (assoc :file
          (cdr (swank-backend:find-source-location
                (find-package pkg-designator))))))
   
(defun source-system (path)
  (asdf:map-systems
   (lambda (sys)
     (when (ignore-errors
             (search (namestring
                      (asdf:component-pathname
                       (asdf:find-system sys))) path))
       (return-from source-system sys)))))

;; asdf:system-author

(defun symbol-system (symbol)
  (source-system
   (package-source
    (symbol-package symbol))))

(defun symbol-author (symbol)
  (asdf:system-author (symbol-system symbol)))
(defun package-author (pkg-designator)
  (asdf:system-author (symbol-system symbol)))

#|

 symbols are inferred in this order:

 ^^^ stronger

 current package
 ---------------
 preferred symbols
 -----------------
 preferred packages
 ------------------

 personal reference count: 自分がauthorであるsystem中に現れる関数は、高く評価する。
 personal relevance count: preferred symbols と同じsystemに属する関数は、高く評価する。

 global reference count

 >> weaker
sokoban


let's call the graph representing the dependencies between symbols as
dependency graph. The graph is directed and may be cyclic.

Fig.1

fn1<->fn2->-fn3
 |     +-->-fn4
 +-->--------+

for example, in fig.1, fn1 depends on fn4 i.e. fn1 uses fn4.

|#


;;;



;;;; XREF

;; (definterface who-calls (function-name)
;;   "Return the call sites of FUNCTION-NAME (a symbol).
;; The results is a list ((DSPEC LOCATION) ...)."
;;   (declare (ignore function-name))
;;   :not-implemented)

;; (definterface calls-who (function-name)
;;   "Return the call sites of FUNCTION-NAME (a symbol).
;; The results is a list ((DSPEC LOCATION) ...)."
;;   (declare (ignore function-name))
;;   :not-implemented)

;; (definterface who-references (variable-name)
;;   "Return the locations where VARIABLE-NAME (a symbol) is referenced.
;; See WHO-CALLS for a description of the return value."
;;   (declare (ignore variable-name))
;;   :not-implemented)

;; (definterface who-binds (variable-name)
;;   "Return the locations where VARIABLE-NAME (a symbol) is bound.
;; See WHO-CALLS for a description of the return value."
;;   (declare (ignore variable-name))
;;   :not-implemented)

;; (definterface who-sets (variable-name)
;;   "Return the locations where VARIABLE-NAME (a symbol) is set.
;; See WHO-CALLS for a description of the return value."
;;   (declare (ignore variable-name))
;;   :not-implemented)

;; (definterface who-macroexpands (macro-name)
;;   "Return the locations where MACRO-NAME (a symbol) is expanded.
;; See WHO-CALLS for a description of the return value."
;;   (declare (ignore macro-name))
;;   :not-implemented)

;; (definterface who-specializes (class-name)
;;   "Return the locations where CLASS-NAME (a symbol) is specialized.
;; See WHO-CALLS for a description of the return value."
;;   (declare (ignore class-name))
;;   :not-implemented)

;; ;;; Simpler variants.

;; (definterface list-callers (function-name)
;;   "List the callers of FUNCTION-NAME.
;; This function is like WHO-CALLS except that it is expected to use
;; lower-level means. Whereas WHO-CALLS is usually implemented with
;; special compiler support, LIST-CALLERS is usually implemented by
;; groveling for constants in function objects throughout the heap.

;; The return value is as for WHO-CALLS.")

;; (definterface list-callees (function-name)
;;   "List the functions called by FUNCTION-NAME.
;; See LIST-CALLERS for a description of the return value.")



