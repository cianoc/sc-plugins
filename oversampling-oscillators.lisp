(in-package :cl-collider)

;; Some more complexity (Do together as same approach)
;; - PMOscOS
;; - SquareOS
;; - TriOS
;; - VarSawOS
;; - BuchlaFoldOS
;; - SergeFoldOS
;; - SawBL
;; - SquareBL
;; - TriBL
;; - ImpulseBL
;; - ShaperOD

;; Fairly Complex
;; - ShaperOS2
;; - OscOS
;; - OscOS2


;; Quite Complex
;; - FM7OS
;; - FM7aOS
;; - FM7bOS

;; Very Complex
;; - PM7OS
;; - OscOS3


(sc::defugen (saw-os "SawOS")
    (freq &key (phase 0) (oversample :x2) (mul 1) (add 0))
  ((:ar (sc::madd (sc::multinew sc::new 'sc::ugen (sc-plug::ctrl-to-audio freq) (sc-plug::ctrl-to-audio phase)
                                (sc-plug::convert-os oversample)) mul add))))

;; Don't see the point of OscOS, so ignoring


(sc::defugen (pm-osc-os "PMOscOS")
    (&key (car-freq 440) (mod-freq 220) (pm-mul 1) (pm-mod-phase 0) (oversample :x2) (mul 1) (add 0))
  ((:ar (sc::madd (sc::multinew sc::new 'sc::ugen
                                (sc-plug::ctrl-to-audio car-freq)
                                (sc-plug::ctrl-to-audio mod-freq)
                                (sc-plug::ctrl-to-audio pm-mul)
                                (sc-plug::ctrl-to-audio pm-mod-phase)
                                (sc-plug::convert-os oversample)) mul add))))
