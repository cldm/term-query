(defpackage :duologue/tests
  (:use :cl :stefil :duologue))

(in-package :duologue/tests)

(deftest prompt-test ()
  (with-input-from-string (*query-io* "something
")
    (is (string= (prompt) "something")))

  (signals error
    (with-input-from-string (*query-io* "something")
      (prompt "Integer:" :parser #'parse-integer)))

  (with-input-from-string (*query-io* "22")
    (is (= (prompt "Integer:" :parser #'parse-integer) 22)))

  (with-input-from-string (*query-io* "aa")
    (is (string= (prompt "Integer:" :parser #'parse-integer :if-invalid "Not an integer") "Not an integer")))
  
  (signals error (with-input-from-string (*query-io* "lala
")
    (prompt-integer))))
