#lang simply-scheme

#|
(let ((port (open-output-file "songs")))
  (show '(all my loving) port)
  (show '(ticket to ride) port)
  (show '(martha my dear) port)
  (close-output-port port))
|#

(define in (open-input-file "songs"))
