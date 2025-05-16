(in-package :sc-plugins)

;; Fairly Complex

(sc::defugen (gutter-synth "GutterSynth")
    (&key (inf-sustain 0.0) (accent 0.5) (freq 50) (tone 0.5) (decay 0.5) (attack-fm 0.5) (self-fm 0.25))
  ((:ar (sc::multinew sc::new 'sc::ugen trig inf-sustain accent freq tone decay attack-fm self-fm))))

GutterSynth : UGen {
*ar { |gamma=0.1, omega=0.02, c=0.1, dt=5, singlegain=1.0, smoothing=0.5, 
			togglefilters=0, distortionmethod=0, oversampling=1, enableaudioinput=0, audioinput, gains1=1, gains2=0,
			freqs1, qs1, freqs2, qs2|

^this.multiNewList(['audio', gamma, omega, c, dt, singlegain, smoothing, togglefilters, distortionmethod, oversampling, enableaudioinput, audioinput, gains1, gains2]
                             ++ ([freqs1.value, qs1.value].flop ++ [freqs2.value, qs2.value].flop).flatten
                             );
}

checkInputs {

// Index of first array argument. The rate of the array style arguments will be checked seperately
var firstArrayArgument = 11;
var expectedArrayArgRate = [\scalar, \control];

// This dictionary maps what rates are allowed for each parameter of the UGen
var allowedRates = IdentityDictionary[
\audioinput -> [\scalar, \control, \audio],          

\gamma -> [\scalar, \control], 
\omega -> [\scalar, \control], 
\c -> [\scalar, \control], 
\dt -> [\scalar, \control], 
\singlegain -> [\scalar, \control], 
\smoothing -> [\scalar, \control], 
\togglefilters -> [\scalar], 
\oversampling -> [\scalar], 

\distortionmethod -> [\scalar, \control], 

\enableaudioinput -> [\scalar],

];
