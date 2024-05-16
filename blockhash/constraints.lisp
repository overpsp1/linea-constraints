(module blockhash)

(defconstraint first-row (:domain {0})
  (vanishes! IOMF))

(defconstraint heartbeat ()
  (if-zero IOMF
           (begin (vanishes! IN_RANGE)
                  (vanishes! BLOCK_NUMBER_HI)
                  (vanishes! BLOCK_NUMBER_LO))
           (begin (eq! IOMF 1)
                  (eq! (next IOMF) IOMF))))

(defconstraint horizontal-byte-dec ()
  (begin (eq! BLOCK_HASH_HI
              (+ (* (^ 256 (- LLARGEMO 0))
                    [BYTE_HI 0])
                 (* (^ 256 (- LLARGEMO 1))
                    [BYTE_HI 1])
                 (* (^ 256 (- LLARGEMO 2))
                    [BYTE_HI 2])
                 (* (^ 256 (- LLARGEMO 3))
                    [BYTE_HI 3])
                 (* (^ 256 (- LLARGEMO 4))
                    [BYTE_HI 4])
                 (* (^ 256 (- LLARGEMO 5))
                    [BYTE_HI 5])
                 (* (^ 256 (- LLARGEMO 6))
                    [BYTE_HI 6])
                 (* (^ 256 (- LLARGEMO 7))
                    [BYTE_HI 7])
                 (* (^ 256 (- LLARGEMO 8))
                    [BYTE_HI 8])
                 (* (^ 256 (- LLARGEMO 9))
                    [BYTE_HI 9])
                 (* (^ 256 (- LLARGEMO 10))
                    [BYTE_HI 10])
                 (* (^ 256 (- LLARGEMO 11))
                    [BYTE_HI 11])
                 (* (^ 256 (- LLARGEMO 12))
                    [BYTE_HI 12])
                 (* (^ 256 (- LLARGEMO 13))
                    [BYTE_HI 13])
                 (* (^ 256 (- LLARGEMO 14))
                    [BYTE_HI 14])
                 (* (^ 256 (- LLARGEMO 15))
                    [BYTE_HI 15])))
         (eq! BLOCK_HASH_LO
              (+ (* (^ 256 (- LLARGEMO 0))
                    [BYTE_LO 0])
                 (* (^ 256 (- LLARGEMO 1))
                    [BYTE_LO 1])
                 (* (^ 256 (- LLARGEMO 2))
                    [BYTE_LO 2])
                 (* (^ 256 (- LLARGEMO 3))
                    [BYTE_LO 3])
                 (* (^ 256 (- LLARGEMO 4))
                    [BYTE_LO 4])
                 (* (^ 256 (- LLARGEMO 5))
                    [BYTE_LO 5])
                 (* (^ 256 (- LLARGEMO 6))
                    [BYTE_LO 6])
                 (* (^ 256 (- LLARGEMO 7))
                    [BYTE_LO 7])
                 (* (^ 256 (- LLARGEMO 8))
                    [BYTE_LO 8])
                 (* (^ 256 (- LLARGEMO 9))
                    [BYTE_LO 9])
                 (* (^ 256 (- LLARGEMO 10))
                    [BYTE_LO 10])
                 (* (^ 256 (- LLARGEMO 11))
                    [BYTE_LO 11])
                 (* (^ 256 (- LLARGEMO 12))
                    [BYTE_LO 12])
                 (* (^ 256 (- LLARGEMO 13))
                    [BYTE_LO 13])
                 (* (^ 256 (- LLARGEMO 14))
                    [BYTE_LO 14])
                 (* (^ 256 (- LLARGEMO 15))
                    [BYTE_LO 15])))))

(defconstraint constency ()
  (begin (eq! IN_RANGE (* LOWER_BOUND_CHECK UPPER_BOUND_CHECK))
         (eq! RES_HI (* IN_RANGE BLOCK_HASH_HI))
         (eq! RES_LO (* IN_RANGE BLOCK_HASH_LO))
         (if-zero (remained-constant! BLOCK_NUMBER_LO)
                  (begin (remained-constant! BLOCK_HASH_HI)
                         (remained-constant! BLOCK_HASH_LO)))))

