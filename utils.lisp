(in-package :cl-collider)

(defun check-rates (&key audio control)
  (let ((audio-inputs (mapcar #'alexandria:ensure-list audio))
        (control-inputs (mapcar #'alexandria:ensure-list control)))
    (flet ((check (node inputs)
             (loop for valid in inputs
                   for node-input in (inputs node)
                   always (find node-input valid))))
      (lambda (ugen)
        (if (eq (rate ugen) :audio)
            (check ugen audio-inputs)
            (check ugen control-inputs))))))

