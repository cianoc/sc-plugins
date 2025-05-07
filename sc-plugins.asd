(asdf:defsystem #:sc-plugins
  :name "sc-plugins"
  :author "Cian O'Connor. cian.oconnor@gmail.com"
  :description "3rd party ugen extensions for CL-Collider"
  :licence "Public Domain / 0-clause MIT"
  :version "2018.7.15"
  :depends-on (#:cl-collider)
  :serial t
  :components ((:file "package")
               (:file "nhthn")
               (:file "ported-plugins")
               (:file "chow-dsp")
               (:file "utils")))
