(in-package :sc-plugins)

;; TODO Rates Checking required
;; - rongs
;; - string-voice

;; An array is passed in
;; - harmonic osc
;; 

;; TODO ChowDSP (separate file)

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

(sc::defugen (chen "Chen")
    (&key (speed 0.5) (a 0.5) (b 0.3) (c 0.28))
  ((:ar (sc::multinew sc::new 'sc::ugen speed a b c))
   (:kr (sc::multinew sc::new 'sc::ugen speed a b c)))
  :check-fn (sc::check-rates :audio '((:control :scalar) (:control :scalar) (:control :scalar) (:control :scalar))
                             :control '((:control :scalar) (:control :scalar) (:control :scalar) (:control :scalar))))

;; mutable instruments var saw
(sc::defugen (lockhart-wavefolder "LockhartWavefolder")
    (in &key (num-cells 4) )
  ((:ar (sc::multinew sc::new 'sc::ugen in num-cells))
   (:kr (sc::multinew sc::new 'sc::ugen in num-cells))))

;; Ported from DairyDSP library
(sc::defugen (d-compressor "DCompressor")
    (in &key (side-chain-in 0) (side-chain 0) (ratio 4) (threshold -40) (attack 0.1) (release 100.1) (makeup 0.5) (auto-makeup t))
  ((:ar (sc::multinew sc::new 'sc::ugen in side-chain-in side-chain ratio threshold attack release makeup
                      (if auto-makeup 1.0 0.0)))))

(sc::defugen (fverb "Fverb")
    (in0 in1 &key (pre-delay 0) (input-amount 100) (input-lowpass-cutoff 10000) (input-highpass-cutoff 100)
         (input-diffusion1 75) (input-diffusion2 62.5) (tail-density 70) (decay 50) (damping 5500)
         (modulator-frequency 1) (modulator-depth 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in0 in1 pre-delay input-amount input-lowpass-cutoff input-highpass-cutoff 
                      input-diffusion1 input-diffusion2 tail-density decay damping
                      modulator-frequency modulator-depth))
   (:kr (sc::multinew sc::new 'sc::ugen in0 in1 pre-delay input-amount input-lowpass-cutoff input-highpass-cutoff 
                      input-diffusion1 input-diffusion2 tail-density decay damping
                      modulator-frequency modulator-depth)))
  :check-fn (sc::check-rates :audio '(:audio :audio)))


(sc::defugen (lpg "LPG")
    (in control-input &key (control-offset 0) (control-scale 1) (vca 1) (resonance 1.5) (low-pass-mode 1) (linearity 1))
  ((:ar (sc::multinew sc::new 'sc::ugen in control-input control-offset control-scale vca resonance low-pass-mode linearity)))
  :check-fn (sc::check-rates :audio '(:audio (:audio :control) (:control :scalar) (:control :scalar)
                                      (:control :scalar) (:control :scalar) (:control :scalar) (:control :scalar))))

;; mutable instruments
;; formant oscillator with aliasing free phase reset
(sc::defugen (neo-formant "NeoFormant")
    (&key (formant-freq 100) (carrier-freq 200) (phase-shift 0.5) )
  ((:ar (sc::multinew sc::new 'sc::ugen formant-freq carrier-freq phase-shift))
   (:kr (sc::multinew sc::new 'sc::ugen formant-freq carrier-freq phase-shift))))

;; NeoVarSaw
;; This is the mutable instruments variable saw
(sc::defugen (mutable-var-saw "NeoVarSawOsc")
    (freq &key (pw 0.5) (waveshape 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen freq pw waveshape))
   (:kr (sc::multinew sc::new 'sc::ugen freq pw waveshape))))

;; Chowdhury Non Linear filter with nice saturation. Very flexible
;; saturation in the feedback loop
(sc::defugen (non-linear-filter "NonLinearFilter")
    (in &key (freq 500) (q 0.5) (gain 1) (shape 'low-pass) (saturation 'hypertan))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq q gain
                      (cond ((eq 'bell shape) 0)
                            ((eq 'notch shape) 1)
                            ((eq 'high-shelf shape) 2)
                            ((eq 'low-shelf shape) 3)
                            ((eq 'high-pass shape) 4)
                            ((eq 'low-pass shape) 5)
                            (t (error "saturation should be on of the following: 'bell 'notch 'high-shelf 'low-shelf 'high-pass 'low-pass")))
                      (cond ((eq 'none saturation) 0)
                            ((eq 'hard saturation) 1)
                            ((eq 'soft saturation) 2)
                            ((eq 'hypertan saturation) 3)
                            ((eq 'ahypsin shape) 4)
                            (t (error "saturation should be on of the following: 'none 'hard 'soft 'hypertan 'ahypsin")))))
   (:kr (sc::multinew sc::new 'sc::ugen in freq q gain
                      (cond ((eq 'bell shape) 0)
                            ((eq 'notch shape) 1)
                            ((eq 'high-shelf shape) 2)
                            ((eq 'low-shelf shape) 3)
                            ((eq 'high-pass shape) 4)
                            ((eq 'low-pass shape) 5)
                            (t (error "saturation should be on of the following: 'bell 'notch 'high-shelf 'low-shelf 'high-pass 'low-pass")))
                      (cond ((eq 'none saturation) 0)
                            ((eq 'hard saturation) 1)
                            ((eq 'soft saturation) 2)
                            ((eq 'hypertan saturation) 3)
                            ((eq 'ahypsin shape) 4)
                            (t (error "saturation should be on of the following: 'none 'hard 'soft 'hypertan 'ahypsin")))))))


;; An oscillator bank in the style of divide-down organs
;; From mutable instruments.
(sc::defugen (osc-bank "OscBank")
    (&key (freq 100) (gain 1) (saw8 0.5) (square8 0.5) (saw4 0.5) (square4 0.5) (saw2 0.5) (square2 0.5) (saw1 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen freq gain saw8 square8 saw4 square4 saw2 square2 saw2))
   (:kr (sc::multinew sc::new 'sc::ugen freq gain saw8 square8 saw4 square4 saw2 square2 saw2))))

;; A resonant body simulation.
;; From mutable instruments.
(sc::defugen (resonator "Resonator")
    (in &key (freq 100) (position 0.001) (resolution 24) (structure 0.5) (brightness 0.5) (damping 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq position resolution structure brightness damping))))


;; Extended Karplus-Strong.
;; Taken from mutable instruments
(sc::defugen (string-voice "StringVoice")
    (&key (trig 0) (inf-sustain 0) (freq 100) (accent 0.5) (structure 0.5) (brightness 0.5) (damping 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen trig inf-sustain freq accent structure brightness damping))))

;; Odin2 filter, based upon work of Will Pirkle and Zavalishin.
;; Virtual Analog 1 pole filter
;; feedback coefficient can also be negative
(sc::defugen (va-1pole "VA1Pole")
    (in &key (freq 500) (feedback 0.5) (type 'lpf))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq feedback
                      (cond ((eq 'lpf type) 0)
                            ((eq 'hpf type) 1)
                            (t (error "type must be either 'lpf for low-pass or 'hpf for high pass")))))
   (:kr (sc::multinew sc::new 'sc::ugen in freq feedback
                      (cond ((eq 'lpf type) 0)
                            ((eq 'hpf type) 1)
                            (t (error "type must be either 'lpf for low-pass or 'hpf for high pass")))))))

;; Odin2 filter, based upon work of Will Pirkle and Zavalishin.
;; This filter's analog pendant was originally developed to work around a patent on the well
;; established ladder filter. While still being 24dB/Oct, the characteristic of this filter is said
;; to be more aggressive and wild compared to the classic ladder, especially when invoking
;; resonance.
;; Classic acid and 303 sound, plus the VCS3.
(sc::defugen (va-diode-filter "VADiodeFilter")
    (in &key (freq 500) (res 0.1) (overdrive 0))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq res overdrive))
   (:kr (sc::multinew sc::new 'sc::ugen in freq res overdrive))))


;; Odin2 filter, based upon work of Will Pirkle and Zavalishin.
;; This filter comes in a lowpass and highpass variant.
;; Cranking up the resonance on these filters reveals a dirty, aggressive sound.
;; Note that while the filters are named KRG-35, their slope is 12dB/Oct.
(sc::defugen (va-korg35 "VAKorg35")
    (in &key (freq 500) (res 0.1) (overdrive 0) (type 'lpf))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq res overdrive
                      (cond ((eq 'lpf type) 0)
                            ((eq 'hpf type) 1)
                            (t (error "type must be either 'lpf for low-pass or 'hpf for high pass")))))
   (:kr (sc::multinew sc::new 'sc::ugen in freq res overdrive
                      (cond ((eq 'lpf type) 0)
                            ((eq 'hpf type) 1)
                            (t (error "type must be either 'lpf for low-pass or 'hpf for high pass")))))))

;; Odin2 filter, based upon work of Will Pirkle and Zavalishin.
;; A Moog filter. If you want a Moog filter, then this is the one.
;; This filter comes in a lowpass and highpass variant.
;; Cranking up the resonance on these filters reveals a dirty, aggressive sound.
;; Note that while the filters are named KRG-35, their slope is 12dB/Oct.
(sc::defugen (va-ladder "VALadder")
    (in &key (freq 500) (res 0.1) (overdrive 0) (type 'lpf4))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq res overdrive
                      (cond ((eq 'lp4 type) 0)
                            ((eq 'lp2 type) 1)
                            ((eq 'bp4 type) 2)
                            ((eq 'bp2 type) 3)
                            ((eq 'hp4 type) 4)
                            ((eq 'hp2 type) 5)
                            (t (error "type must be either 'lp4, 'lp2, 'bp4, 'bp2, 'hp4, or 'lp2. 2 is 12 db slope, 4 is 24 db slop")))))
   (:kr (sc::multinew sc::new 'sc::ugen in freq res overdrive
                      (cond ((eq 'lp4 type) 0)
                            ((eq 'lp2 type) 1)
                            ((eq 'bp4 type) 2)
                            ((eq 'bp2 type) 3)
                            ((eq 'hp4 type) 4)
                            ((eq 'hp2 type) 5)
                            (t (error "type must be either 'lp4, 'lp2, 'bp4, 'bp2, 'hp4, or 'lp2. 2 is 12 db slope, 4 is 24 db slop")))))))


;; Odin2 filter, based upon work of Will Pirkle and Zavalishin.
;; This filter can transition gradually between low pass and high pass, with a notch in between.
;; 0.0 is high pass, 1.0 is low pass (check).
;; 12 db slope obviously
;; based upon the Oberheim classic.

(sc::defugen (va-sem12 "VASEM12")
    (in &key (freq 500) (res 0.1) (transition 0.0))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq res transition))
   (:kr (sc::multinew sc::new 'sc::ugen in freq res transition))))

;; Based upon work of Zavalishin.
;; a good and cheap filter, that sounds analog and handles modulation well (and is accurate across spectrum)
(sc::defugen (vadim-filter "VadimFilter")
    (in &key (freq 500) (res 0.1) (type 'lpf4))
  ((:ar (sc::multinew sc::new 'sc::ugen in freq res 
                      (cond ((eq 'lp2 type) 0)
                            ((eq 'lp4 type) 1)
                            ((eq 'bp2 type) 2)
                            ((eq 'bp4 type) 3)
                            ((eq 'hp2 type) 4)
                            ((eq 'hp4 type) 5)
                            (t (error "type must be either 'lp4, 'lp2, 'bp4, 'bp2, 'hp4, or 'lp2. 2 is 12 db slope, 4 is 24 db slop")))))
   (:kr (sc::multinew sc::new 'sc::ugen in freq res
                      (cond ((eq 'lp2 type) 0)
                            ((eq 'lp4 type) 1)
                            ((eq 'bp2 type) 2)
                            ((eq 'bp4 type) 3)
                            ((eq 'hp2 type) 4)
                            ((eq 'hp4 type) 5)
                            (t (error "type must be either 'lp4, 'lp2, 'bp4, 'bp2, 'hp4, or 'lp2. 2 is 12 db slope, 4 is 24 db slop")))))))

;; Variable shape oscillator. Mutable Instruments originally.
;; sync sets sync when t, otherwise ignored.
;; waveshape Blend between waveshapes. 0.0 is saw/ramp/tri and 1.0 is square.
;; pw is applied to the square wave component
;; This is the mutable instruments variable saw
(sc::defugen (var-shape-osc "VarShapeOsc")
    (freq &key (pw 0.5) (waveshape 0.5) (sync t) (syncFreq 105))
  ((:ar (sc::multinew sc::new 'sc::ugen freq pw waveshape (if sync 1.0 0.0) syncFreq))
   (:kr (sc::multinew sc::new 'sc::ugen freq pw waveshape (if sync 1.0 0.0) syncFreq))))


;; Mutable Instruments
;; Two sinewaves multiplied by and sync'ed to a carrier. Sounds cool
;; Waveshaping. -1.0 to 1.0. Investigate further...
(sc::defugen (vosim-osc "VosimOsc")
    (freq &key (form1-freq 951) (form2-freq 919) (shape 0))
  ((:ar (sc::multinew sc::new 'sc::ugen freq form1-freq form2-freq shape))
   (:kr (sc::multinew sc::new 'sc::ugen freq form1-freq form2-freq shape))))

;; Mutable Instruments
;; Sinewave multiplied by and sync'ed to a carrier.
;; shape - Adjust contour of waveform. 0.0 to 1.0.
;; mode - Set the offset amound and phase shift. < 1/3 is just phaseshaft and above 2/3 is just offset, between them is both. -1.0 to 1.0.
(sc::defugen (z-osc "ZOsc")
    (freq &key (formant-freq 91) (shape 0.5) (mode 0.5))
  ((:ar (sc::multinew sc::new 'sc::ugen freq formant-freq shape mode))
   (:kr (sc::multinew sc::new 'sc::ugen freq freq formant-freq shape mode))))
