(in-package :sc-plugins)

;; TODO Rates Checking required
;; - lpg
;; - chen
;; - rongs
;; - string-voice

;; An array is passed in
;; - harmonic osc
;; 

;; TODO ChowDSP (separate file)

;; Easy
;; - FVerb
;; - OscBank
;; - Resonator
;; - va1pole
;; - VADiodeFilter
;; - VAKorg35
;; - VALadder
;; - VASem12
;; - VadminFilter
;; - VarShapeOsc
;; - VosimOsc
;; - ZOsc

;;
;; Other API stuff
;; - symbols for magic numbers (e.g. non-linear-filter)

(sc::defugen (kick-808 "AnalogBassDrum")
    (&optional (trig 0.0) &key (inf-sustain 0.0) (accent 0.5) (freq 50) (tone 0.5) (decay 0.5) (attack-fm 0.5) (self-fm 0.25))
  ((:ar (sc::multinew sc::new 'sc::ugen trig inf-sustain accent freq tone decay attack-fm self-fm))))

(sc::defugen (snare-808 "AnalogSnareDrum")
    (&optional (trig 0.0) &key (inf-sustain 0.0) (accent 0.1) (freq 200) (tone 0.5) (decay 0.5) (snappy 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen trig inf-sustain accent freq tone decay snappy))))

(sc::defugen (analog-fold-osc "AnalogFoldOsc")
    (freq &key (amp 1.0))
  ((:ar (sc::multinew sc::new 'sc::ugen freq amp))))

;; ported from faust
(sc::defugen (bl-osc "BLOsc")
    (&key (freq 100) (pulse-width 0.5) (waveform 0))
  ((:ar (sc::multinew sc::new 'sc::ugen freq pulse-width waveform))
   (:kr (sc::multinew sc::new 'sc::ugen freq pulse-width waveform))))

;; mutable instruments var saw
(sc::defugen (lockhart-wavefolder "LockhartWavefolder")
    (in &key (num-cells 4) )
  ((:ar (sc::multinew sc::new 'sc::ugen in num-cells))
   (:kr (sc::multinew sc::new 'sc::ugen in num-cells))))

;; Ported from DairyDSP library
(sc::defugen (d-compressor "DCompressor")
    (in &key (side-chain-in 0) (side-chain 0) (ratio 4) (threshold -40) (attack 0.1) (release 100.1) (makeup 0.5) (auto-makeup 1))
  ((:ar (sc::multinew sc::new 'sc::ugen in side-chain-in side-chain ratio threshold attack release makeup auto-makeup))))

;; mutable instruments
;; formant oscillator with aliasing free phase reset
(sc::defugen (neo-formant "NeoFormant")
    (&key (formant-freq 100) (carrier-freq 200) (phase-shift 0.5) )
  ((:ar (sc::multinew sc::new 'sc::ugen formant-freq carrier-freq phase-shift))
   (:kr (sc::multinew sc::new 'sc::ugen formant-freq carrier-freq phase-shift))))

;; NeoVarSaw
;; This is the mutable instruments variable saw
(sc::defugen (mut-var-saw "NeoVarSawOsc")
    (freq &key (pw 0.5) (waveshape 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen freq pw waveshape))
   (:kr (sc::multinew sc::new 'sc::ugen freq pw waveshape))))

;; Chowdhury Non Linear filter with nice saturation. Very flexible
;; saturation in the feedback loop
(sc::defugen (non-linear-filter "NonLinearFilter")
    (in &key (freq 500) (q 0.5) (gain 1) (shape 5) (saturation 3))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq q gain shape saturation))
   (:kr (sc::multinew sc::new 'sc::ugen in freq q gain shape saturation))))

