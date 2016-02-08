
(in-package :ammunition.impl)


(defun walk-tree (fn tree)
  "traverse the cons tree in a depth-first manner. FN is
a function of 2 arguments, the first one is a current branch,
and the second one is the continuation funtion of 1 argument.
When you want to further go down the tree, call the continuation with
the branch.

Example:
 (defun flatten (tree)
   (let ((acc nil))
     (walk-tree (lambda (branch cont)
                  (if (consp branch)
                      (funcall cont branch)
                      (push branch acc)))
                tree)
     (nreverse acc)))"
  (funcall fn tree
           (lambda (branch)
             (mapcar (lambda (branch)
                       (walk-tree fn branch))
                     branch))))

