(in-package :sc-plugins)

(sc::defugen (pll "PLL")
    (in &key (algorithm 1) (lag 0.1) (center-freq 440) (freq-gain 440))
  ((:ar (sc::multinew sc::new 'sc::ugen in algorithm lag center-freq freq-gain
                      ))))

(sc::defugen (safety-limiter "SafetyLimiter")
    (in &key (releaseTime 0.5) (holdTime 0.1))
  ((:ar (sc::multinew sc::new 'sc::ugen input releaseTime holdTime))))


