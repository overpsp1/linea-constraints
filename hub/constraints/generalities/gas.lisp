(module hub)

;;;;;;;;;;;;;;;;;
;;             ;;
;;   4.4 Gas   ;;
;;             ;;
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   ;;
;;   4.4.1 Gas column generalities   ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint gas-columns---stamp-constancies ()
               (begin (hub-stamp-constancy GAS_EXPECTED)
                      (hub-stamp-constancy GAS_ACTUAL)
                      (hub-stamp-constancy GAS_COST)
                      (hub-stamp-constancy GAS_NEXT)))


;; TODO: should be debug
(defconstraint gas-columns---automatic-vanishing ()
               (begin
                 (if-zero   TX_EXEC
                            (begin
                              (vanishes! GAS_EXPECTED)
                              (vanishes! GAS_ACTUAL)
                              (vanishes! GAS_COST)
                              (vanishes! GAS_NEXT)))))

;; we drop the stack perspective preconditions
(defconstraint gas-columns---GAS_NEXT-vanishes-in-case-of-an-exception ()
               (if-not-zero   XAHOY
                              (vanishes!   GAS_NEXT)))

(defconstraint gas-columns---setting-GAS_NEXT-outside-of-CALLs-and-CREATEs (:perspective stack)
               (if-zero   XAHOY
                          (if-zero   (force-bool  (+  stack/CREATE_FLAG  stack/CALL_FLAG))
                                     (eq!  GAS_NEXT (- GAS_ACTUAL GAS_COST)))))

(defconstraint gas-columns---hub-stamp-transition-constraints ()
               (begin
                 (if-not-zero (will-remain-constant! HUB_STAMP)
                              (if-not-zero TX_EXEC
                                           (if-not-zero (next TX_EXEC)
                                                        (begin
                                                          (if-eq CN_NEW CN               (eq! (next GAS_ACTUAL) (next GAS_EXPECTED)))
                                                          (if-eq CN_NEW CALLER_CN        (eq! (next GAS_ACTUAL) (+ (next GAS_EXPECTED) GAS_NEXT)))
                                                          (if-eq CN_NEW (+ 1 HUB_STAMP)  (eq! (next GAS_ACTUAL) (next GAS_EXPECTED)))))))))
                                                                                           ;; can't define GAS_EXPECTED at this level of generality
