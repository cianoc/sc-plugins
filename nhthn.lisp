(in-package :sc-plugins)

(sc::defugen (safety-limiter "SafetyLimiter")
    (&optional (input 0.0) (releaseTime 0.5) (holdTime 0.1))
  ((:ar (sc::multinew sc::new 'sc::ugen input releaseTime holdTime))))

