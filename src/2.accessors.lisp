(in-package :ammunition)

;; note: useful functions
;; (swank-backend:who-calls 'alexandria:plist-alist)
;; (swank-backend:find-definitions 'alexandria:plist-alist)
;; (swank-backend:find-source-location 'alexandria:plist-alist)
;; (symbol-package 'alexandria:plist-alist)
;; asdf/component:component-pathname
;; asdf/component:component-children
;; (asdf:registered-systems)
;; (asdf:map-systems fn)
;; cl:FIND-ALL-SYMBOLS

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

(defun symbol-system (symbol)
  (source-system
   (package-source
    (symbol-package symbol))))

(defun symbol-author (symbol)
  (asdf:system-author (symbol-system symbol)))
(defun package-author (pkg-designator)
  (asdf:system-author (symbol-system symbol)))
