(in-package :ammunition.impl)

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
  (pathname
   (second
    (assoc :file
           (cdr (swank-backend:find-source-location
                 (find-package pkg-designator)))))))

(defun source-system (path)
  (let ((path (pathname path)))
    (labels ((contains-file-p (component)
               (or (equal (asdf:component-pathname component) path)
                   (some #'contains-file-p
                         (ignore-errors (asdf:component-children component))))))
      (asdf:map-systems
       (lambda (sys)
         (when (contains-file-p sys)
           (return-from source-system sys)))))))

;; system > source > package > symbol

(defun system-source (system)
  (asdf:system-source-file system))

