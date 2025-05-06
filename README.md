# sc-plugins
This package extends [Cl-Collider](https://github.com/byulparan/cl-collider) with third party supercollider ugens. Cl-Collider is a client for SuperCollider written in Common Lisp.

Currently this project is in the super early phases. The code _should_ work, but use at your own risk. Serious testing with follow implementation. Documentation is coming, but won't be here for a while. Feedback and help is welcome. At some point some, or all, of this this may get folded back into the main library as a pull request.

The API is currently in flux, as is the naming of ugens. I can be influenced by feedback and bribes ;)

Currently complete:
- [x] https://github.com/nhthn/supercollider-safety-limiter - a transparent brickwall limiter that's perfect for the end of your signal chain.

In progress:
- https://github.com/madskjeldgaard/portedplugins - a collection of really great, really high quality, analog modeled ugens from filters to distortions, to tape saturation and even 808 emulations. Amazing stuff. You can emulate a Buchla with this library. Also has some mutable instruments stuff that is nice and Jay Chowdhury's work.

The following are planned:
- [ ] https://github.com/cianoc/cian-plugins - something I wrote years about, and had totally forgotten about. Probably needs a cleanup, but improves on the regular FBOscillator in a couple of ways. Simple but fun.
- [ ] https://github.com/madskjeldgaard/guttersynth-sc - weird chaotic oscillator from Tom Mudd.
- [ ] https://github.com/spluta/OversamplingOscillators - modern oversampling oscillators, including some stuff you wouldn't expect.
- [ ] https://github.com/nhthn/supercollider-pll/tree/develop - interesting distortion effect

Don't see an extension that you really want on this list? Add an issue as I probably don't know about it.

The following are already in cl-collider, so aren't part of this project:
- mi-ugens
- foplugins
- miSCellaneous_lib

Under Consideration:
- https://github.com/elgiano/super-bufrd - ugens for when you need longer samples than the standard library can handle, and you need precise information.
- https://github.com/elgiano/XPlayBuf - for when super-bufrd is more complexity than you need
- https://github.com/tai-studio/steroids-ugens - has a fboscillator that I think is less useful than mine (but I should check) and a trigger demand ugen that seems like it should have been in the standard library in the first place...