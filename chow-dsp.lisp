(in-package :sc-plugins)

(sc::defugen (analog-chew "AnalogChew")
    (in &key (depth 0.5) (freq 0.5) (variance 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in depth freq variance))))

(sc::defugen (analog-degrade "AnalogDegrade")
    (in &key (depth 0.5) (amount 0.5) (variance 0.5) (envelope 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in depth amount variance envelope))))
.
(sc::defugen (analog-loss "AnalogLoss")
    (in &key (gap 0.5) (thick 0.5) (space 0.5) (speed 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in gap thick space speed))))

(sc::defugen (analog-phaser "AnalogPhaser")
    (in lfo-input &key (skew 0) (feedback 0.25) (modulation 0.5) (stages 8))
  ((:ar (sc::multinew sc::new 'sc::ugen in lfo-input skew feedback modulation stages))))

(sc::defugen (analog-phaser-mod "AnalogPhaserMod")
    (in &key (skew 0) (modulation 0.5) (stages 8))
  ((:ar (sc::multinew sc::new 'sc::ugen in skew modulation stages))
   (:kr (sc::multinew sc::new 'sc::ugen in skew modulation stages))))

;; Mysterious...
(sc::defugen (analog-pulse-shaper "AnalogPulseShaper")
    (in &key (width 0.5) (decay 0.5) (double 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in width decay double))))

(sc::defugen (analog-tape "AnalogTape")
    (in &key (bias 0.5) (saturation 0.5) (drive 0.5) oversample (mode :rk2))
  ((:ar (sc::multinew sc::new 'sc::ugen in bias saturation drive
                      (cond ((null oversample ) 0)
                            ((eql :x2 oversample) 1)
                            ((eql :x4 oversample) 2)
                            ((eql :x8 oversample) 3)
                            ((eql :x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16")))
                      (cond ((eql :rk2 mode) 1)
                            ((eql :rk4 mode) 2)
                            ((eql :nr4 mode) 3)
                            ((eql :nr8 mode) 4)
                            (t (error "Set mode to :rk2, :rk4, :nr4, or :nr8")))))))


(sc::defugen (analog-vintage-distort "AnalogVintageDistortion")
    (in &key (drive-gain 0.5) (bias 0) (low-gain 0.1) (high-gain 0.1) (shelving-freq 600) oversample)
  ((:ar (sc::multinew sc::new 'sc::ugen in drive-gain bias low-gain high-gain shelving-freq
                      (cond ((null oversample ) 0)
                            ((eq :x2 oversample) 1)
                            ((eq :x4 oversample) 2)
                            ((eq :x8 oversample) 3)
                            ((eq :x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use :x2, :x4, :x8, or :x16")))))))


(sc::defugen (phasor-filter "PhasorModal")
    (in &key (freq 100) (decay 0.25) (damp 2.0) (amp 0.5) (phase 0))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq decay damp amp phase))))

(sc::defugen (werner-filter "Werner")
    (in &key (freq 0.5) (damp 0.5) (feedback 0.5) (drive 0) (oversample :x2))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq damp feedback drive
                      (cond ((null oversample ) 0)
                            ((eq :x2 oversample) 1)
                            ((eq :x4 oversample) 2)
                            ((eq :x8 oversample) 3)
                            ((eq :x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16")))))))
