(in-package :cl-collider)

(defun check-rates (&key audio control)
  (let ((audio-inputs (mapcar #'alexandria:ensure-list audio))
        (control-inputs (mapcar #'alexandria:ensure-list control)))
    (flet ((check (node inputs)
             (loop for valid in inputs
                   for node-input in (inputs node)
                     thereis (find node-input valid)
                   finally (return t))))
      (lambda (ugen)
        (if (eq (rate ugen) :audio)
            (check ugen audio-inputs)
            (check ugen control-inputs))))))

(defclass testgen ()
  ((rate
    :initarg :rate
    :accessor rate)
   (inputs
    :initarg :inputs
    :accessor inputs)))

(defparameter *test* (make-instance 'testgen :rate :audio :inputs '(:audio :control :audio :control :scalar)))

(find :audio (inputs  *test*))

      (funcall (check-rates :audio '((:audio :control) '(:control :scalar) :scalar)) *test*)

      (alexandria:ensure-list :audio)


      (if (eql (rate ugen) :audio)

          (loop for inputs in control-inputs
                for node-input in (inputs ugen)
                do (unless (find node-input inputs) (setf ok nil)))
          

          (find :hello '(:hello :friend))

          (defun check-when-audio (ugen)
            (when (and (eql (rate ugen) :audio) (not (eql (rate (nth 1 (inputs ugen))) :audio)))
              (error "~a's input is not audio rate (input: ~a rate: ~a)." ugen (nth 1 (inputs ugen)) (rate (nth 1 (inputs ugen))))))

          (loop for x in nil
                collect x)


          (unless (find :hello '(:hellof :my)) :hello)

          :audio 2)
      (:control 1)
      (:scalar 0)
      (:demand 3)))
