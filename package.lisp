(defpackage #:sc-plugins
  (:use #:cl #:cl-collider)
  (:export #:safety-limiter
           #:safety-limiter
           
           ;; ported-plugins
           #:kick-808
           #:snare-808
           #:analog-fold-osc
           #:bl-osc
           #:chen
           #:d-compressor
           #:fverb
           #:harmonic-osc
           #:lockhart-wavefolder
           #:lpg
           #:mutable-var-saw
           #:neo-formant
           #:non-linear-filter
           #:osc-bank
           #:resonator
           #:rongs
           #:string-voice
           #:va-1pole
           #:va-diode-filter
           #:va-korg35
           #:va-ladder
           #:va-sem12
           #:vadim-filter
           #:var-shape-osc
           #:vosim-osc
           #:z-osc

           ;; Ported plugins (Jay Chowdhury
           #:analog-chew
           #:analog-degrade
           #:analog-loss
           #:analog-phaser
           #:analog-phaser-mode
           #:analog-pulse-shaper
           #:analog-tape
           #:analog-vintage-distort
           #:phasor-filter
           #:werner-filter

           ))
