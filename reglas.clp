;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1) Plantilla (deftemplate)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate dispositivo-energia
   "Plantilla para describir el estado de un dispositivo eléctrico en un hogar."
   (slot id)                        ;; Identificador del dispositivo
   (slot tipo)                      ;; Tipo de dispositivo (refrigerador, TV, etc.)
   (slot consumo (type INTEGER))    ;; Consumo energético en watts
   (slot prioridad (type SYMBOL))   ;; alta, media, baja
   (slot horario (type SYMBOL))     ;; dia, tarde, noche
   (slot costo-energia (type SYMBOL));; bajo, medio, alto
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 2) Hechos (deffacts) - 5 instancias
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts estado-energia
   "Cinco dispositivos/escenarios para diagnosticar."
   (dispositivo-energia
      (id "Refrigerador")
      (tipo "Electrodoméstico esencial")
      (consumo 150)
      (prioridad alta)
      (horario dia)
      (costo-energia bajo))

   (dispositivo-energia
      (id "Aire Acondicionado")
      (tipo "Confort")
      (consumo 2000)
      (prioridad media)
      (horario tarde)
      (costo-energia alto))

   (dispositivo-energia
      (id "TV")
      (tipo "Entretenimiento")
      (consumo 100)
      (prioridad baja)
      (horario noche)
      (costo-energia medio))

   (dispositivo-energia
      (id "Lavadora")
      (tipo "Electrodoméstico")
      (consumo 500)
      (prioridad media)
      (horario dia)
      (costo-energia alto))

   (dispositivo-energia
      (id "Computadora")
      (tipo "Trabajo")
      (consumo 300)
      (prioridad alta)
      (horario tarde)
      (costo-energia medio))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 3) Variables globales (defglobal)
;;;    - "consumo máximo permitido"
;;;    - "horario de mayor demanda"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*consumo-maximo* = 1000)
(defglobal ?*horario-pico* = tarde)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4) Reglas (defrule)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Regla 1: Dispositivos con consumo excesivo
(defrule consumo-excesivo
   (dispositivo-energia (id ?id) (consumo ?c&:(> ?c ?*consumo-maximo*)))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " tiene un consumo excesivo de " ?c " watts." crlf
             " -> Recomendación: Considerar reducir su uso durante horarios pico." crlf))

;;; Regla 2: Prioridad alta en horario pico
(defrule prioridad-alta-horario-pico
   (dispositivo-energia (id ?id) 
                        (prioridad alta) 
                        (horario ?h&:(eq ?h ?*horario-pico*)))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " tiene alta prioridad durante el horario pico." crlf
             " -> Recomendación: Mantener su uso moderado para evitar sobrecarga." crlf))

;;; Regla 3: Bajo costo de energía, pero alta demanda
(defrule bajo-costo-alta-demanda
   (dispositivo-energia (id ?id) 
                        (costo-energia bajo) 
                        (consumo ?c&:(> ?c 500)))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " tiene alta demanda con bajo costo de energía." crlf
             " -> Recomendación: Priorizar su uso en horarios de bajo costo." crlf))

;;; Regla 4: Uso recomendado en horario nocturno
(defrule uso-nocturno
   (dispositivo-energia (id ?id) (horario noche) (prioridad baja))
   =>
   (printout t "Recomendación: El dispositivo " ?id " es adecuado para uso nocturno debido a su baja prioridad." crlf))

;;; Regla 5: Dispositivos esenciales siempre activos
(defrule dispositivos-esenciales
   (dispositivo-energia (id ?id) (tipo "Electrodoméstico esencial"))
   =>
   (printout t "El dispositivo " ?id " es esencial y debe mantenerse activo sin interrupciones." crlf))

;;; Regla 6: Alta prioridad durante horarios de trabajo
(defrule prioridad-trabajo
   (dispositivo-energia (id ?id) 
                        (tipo "Trabajo") 
                        (horario ?h&:(eq ?h tarde)))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " es prioritario durante la tarde para tareas de trabajo." crlf
             " -> Recomendación: Asegurarse de que tenga suministro eléctrico constante." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 5) Ejecución
;;;    1. (load "sistema-energia.clp")
;;;    2. (reset)
;;;    3. (run)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
