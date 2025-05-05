(in-package :sc-plugins)

;; Easy
;; - Werner (rename as it's a filter)

;; This plugin is an analog tape chew emulation algorithm by Jatin Chowdhury
;; - Depth controls how deep the tape is chewed. 0.0 to 1.0.
;; - freq Frequency controls how much space there is between bits of tape that have been chewed up. Useful to toggle randomly between 0 and 1.
;; - variance Variance determines how much randomness there is in determining the amount of space between chewed up sections.  0.0 to 1.0.
(sc::defugen (analog-chew "AnalogChew")
    (in &key (depth 0.5) (freq 0.5) (variance 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in depth freq variance))))

;; This plugin is an analog tape degradation emulation algorithm by Jatin Chowdhury,
;; depth
;; Depth controls the intensity of the wear on the tape. 0.0 to 1.0.

;; amount
;; Amount controls the amount of wear, typically corresponding to the age of the tape. 0.0 to 1.0.

;; variance
;; Variance adds a time-varying randomness to the degradatation. 0.0 to 1.0.

;; ARGUMENT::envelope
;; Envelope applies an amplitude envelope to the tape noise. 0.0 to 1.0.
(sc::defugen (analog-degrade "AnalogDegrade")
    (in &key (depth 0.5) (amount 0.5) (variance 0.5) (envelope 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in depth amount variance envelope))))

;; This plugin is an analog tape loss emulation algorithm by Jatin Chowdhury,
;; This smaller version is mostly useful as a tape loss. It works mainly as a filter. Note that it uses high CPU whe modulating parameters.
;; Gap controls the width of the playhead gap, measured in millimeters. 0.0 to 1.0.
;; Thick controls the thickness of the tape, measured in centimeters. 0.0 to 1.0.
;; Space controls the amount of space between the playhead and the tape, measured in centimeters.  0.0 to 1.0.
;; Speed controls the tape speed as it effects the above loss effects, measured in inches per second (ips).  0.0 to 1.0.
(sc::defugen (analog-loss "AnalogLoss")
    (in &key (gap 0.5) (thick 0.5) (space 0.5) (speed 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in gap thick space speed))))


;;This phaser contains two modulating allpass stages arranged in a feedback architecture. 
;; 
;; A virtual analog feedback phaser by Jatin Chowdhury
;;
;; lfo-input
;;Input of the lfo used to modulate the sound. May be audio rate or control rate.
;;
;; skew
;; Emphasize different parts of the LFO's input. Inspired by the behaviour of light dependent resistors.
;; -1.0 to 1.0.
;; 
;; feedback 0.0 to 0.95
;;
;; modulation
;; A sort of dry/wet control for the internals of the phaser modulator, mixing between the dry lfo at lfoinput and the result of it passing through the phaser circuitry.
;; 0.0 to 1.0
;;
;; stages 1.0 to 50.0
;;
(sc::defugen (analog-phaser "AnalogPhaser")
    (in &key lfo-input (skew 0) (feedback 0.25) (modulation 0.5) (stages 8))
  ((:ar (sc::multinew sc::new 'sc::ugen in lfo-input skew feedback modulation stages))))


;; This plugin is the modulation section of AnalogPhaser which takes a modulation signal and passes it through a series of modulated virtual analog allpass stages.
;; Original by Jatin Chowdhury
;;
;; skew
;; Emphasize different parts of the LFO's input. Inspired by the behaviour of light dependent resistors.
;; -1.0 to 1.0.
;;
;; modulation
;; A sort of dry/wet control for the internals of the phaser modulator, mixing between the dry lfo at lfoinput and the result of it passing through the phaser circuitry.
;; 0.0 to 1.0
;;
;; stages
;; 1.0 to 50.0
(sc::defugen (analog-phaser-mod "AnalogPhaserMod")
    (in &key (skew 0) (modulation 0.5) (stages 8))
  ((:ar (sc::multinew sc::new 'sc::ugen in skew modulation stages))
   (:kr (sc::multinew sc::new 'sc::ugen in skew modulation stages))))

;; Mysterious...
(sc::defugen (analog-pulse-shaper "AnalogPulseShaper")
    (in &key (width 0.5) (decay 0.5) (double 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in width decay double))))


;; ARGUMENT::bias
;; Tape bias. 0.0 to 1.0.
;;
;; ARGUMENT::saturation
;; Tape saturation. 0.0 to 1.0 but may be pushed harder.
;;
;; ARGUMENT::drive
;; Tape drive. 0.0 to 1.0 but may be pushed harder.
;;
;; ARGUMENT::oversample
;; Set amount of oversampling
;;
;; 0 = No oversampling,
;; 1 = x2,
;; 2 = x4,
;; 3 = x8,
;; 4 = x16
;;
;; ARGUMENT::mode
;; Change the mode (solver type) of the tape algorithm:
;; 0 = RK2 (2nd order Runge Kutta)
;; 1 = RK4 (4th order Runge Kutta)
;; 2 = NR4 (4-iteration Newton Raphson)
;; 3 = NR8 (8-iteration Newton Raphson)
;;
;; The Runge-Kutta solvers are computationally cheaper, but
;; somewhat less accurate than the Newton-Raphson solvers.
;; Similarly, the higher-order solvers will be more accurate,
;; but will also consume more compute resources.
(sc::defugen (analog-tape "AnalogTape")
    (in &key (bias 0.5) (saturation 0.5) (drive 0.5) oversample (mode 'rk2))
  ((:ar (sc::multinew sc::new 'sc::ugen in bias saturation drive
                      (cond ((null oversample ) 0)
                            ((eq 'x2 oversample) 1)
                            ((eq 'x4 oversample) 2)
                            ((eq 'x8 oversample) 3)
                            ((eq 'x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16")))
                      (cond ((eq 'rk2 mode) 1)
                            ((eq 'rk4 mode) 2)
                            ((eq 'nr4 mode) 3)
                            ((eq 'nr8 mode) 4)
                            (t (error "Set mode to 'rk2, rk4, nr4, or nr8")))))))


;; A virtual analog EQ and distortion by Jatin Chowdhury
;;
;; The EQ circuit is based on the BaxandallEQ. The drive circuit is inspired by the Klon Centaur and Ibanez Tube Screamer  guitar pedals.
;;
;; drivegain
;; Gain of input drive, 0.0 to 1.0
;;
;; bias
;; Bias. 0.0 to 2.5
;; Controls the distribution of odd/even harmonics.
;;
;; lowgain
;; Gain of the lower part of the EQ, 0.0001 to 0.3 is appropriate. Use eg CODE::-10.dbamp:: if you want to control using decibels.
;;
;; highgain
;; Gain of the higher part of the EQ, 0.001 to 0.3 is appropriate. Use eg CODE::-10.dbamp:: if you want to control using decibels.
;;
;; shelvingfreq
;; The center frequency of the EQ filter
(sc::defugen (analog-vintage-distortion "AnalogVintageDistortion")
    (in &key (drive-gain 0.5) (bias 0) (low-gain 0.1) (high-gain 0.1) (shelving-freq 600) oversample)
  ((:ar (sc::multinew sc::new 'sc::ugen in drive-gain bias low-gain high-gain shelving-freq
                      (cond ((null oversample ) 0)
                            ((eq 'x2 oversample) 1)
                            ((eq 'x4 oversample) 2)
                            ((eq 'x8 oversample) 3)
                            ((eq 'x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16")))))))



;; Max Mathews phasor filter, a recursive filter that filters a single frequency, with a given damping factor and complex amplitude.
;;
;; This filter is guaranteed stable, and reacts well to real-time parameter changes. For more information, see: https://ccrma.stanford.edu/~jos/smac03maxjos/, and http://dafx2019.bcu.ac.uk/papers/DAFx2019_paper_48.pdf.
(sc::defugen (phasor-filter "PhasorModal")
    (in &key (freq 100) (decay 0.25) (damp 2.0) (amp 0.5) (phase 0))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq decay damp amp phase))))


;; Jatin Chowdhury writes in the documentation for his VCV-rack version of this:
;; "This filter is an implementation of a generalized State Variable Filter architecture (shown below), presented by Kurt James Werner and Russell McClellan at the 2020 Digital Audio Effects (DAFx) conference, with a couple nonlinear modifications. The filter has modular controls for the frequency, resonant feedback, passband damping, and nonlinear drive."
;; https://dafx2020.mdw.ac.at/proceedings/papers/DAFx2020_paper_70.pdf##Original DAFX paper about this filter::
;; https://dafx2020.mdw.ac.at/proceedings/presentations/paper_70.mp4##Kurt Werner's accompanying talk::

(sc::defugen (werner-filter "Werner")
    (in &key (freq 0.5) (damp 0.5) (feedback 0.5) (drive 0) (oversample 'x2))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq damp feedback drive
                      (cond ((null oversample ) 0)
                            ((eq 'x2 oversample) 1)
                            ((eq 'x4 oversample) 2)
                            ((eq 'x8 oversample) 3)
                            ((eq 'x16 oversample) 4)
                            (t (error "Either set oversample to nil, or use 'x2, 'x4, 'x8, or 'x16")))))))
