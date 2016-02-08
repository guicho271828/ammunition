(in-package :ammunition)

#|

computing the dependency with who-calls or who-references etc. is difficult
because we don't know which library (=system) depends on the symbol until
the library is loaded. there are thousands of libraries and it does not
seem a good idea to load all libraries in the same image.

For functions, list-callees and calls-who might be the candidates.
however, we do not want to see the functions called as a result of macroexpansion.
Therefore we have to implement a code walker that is generic to all types of forms.


since the evaluation normally proceeds left-to-right and depth-first,
symbols in the shallow layer usually have dependency to the deeper layer.


|#


;;; reference counters



(defun personal-references (psym)
  "Count the number of reference to this symbol
in the systems which you are the author of."
  )

(defun global-references (psym)
  "Count the number of reference to this symbol in all systems."
  )

      
