(in-package :sc-plug)

(defun check-rates (&key audio control)
  (let ((audio-inputs (mapcar #'alexandria:ensure-list audio))
        (control-inputs (mapcar #'alexandria:ensure-list control)))
    (flet ((check (node inputs)
             (loop for valid in inputs
                   for node-input in (cl-collider::inputs node)
                   always (find node-input valid))))
      (lambda (ugen)
        (if (eq (cl-collider::rate ugen) :audio)
            (check ugen audio-inputs)
            (check ugen control-inputs))))))

(defun ctrl-to-audio (input)
  (if (eq (cl-collider::rate input) :audio)
      input
      (k2a.ar input)))


(defun convert-os (oversample)
  (cond ((null oversample ) 0)
        ((eq :x2 oversample) 1)
        ((eq :x4 oversample) 2)
        ((eq :x8 oversample) 3)
        ((eq :x16 oversample) 4)
        (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16"))))
