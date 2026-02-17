$PROBLEM [PROJECT_NAME] - 2-Compartment First-Order Absorption
; Run: [RUN_NUMBER]
; Based on: [PARENT_RUN]
; Description: [DESCRIPTION]
; Analyst: [ANALYST]
; Date: [DATE]

$INPUT ID TIME DV AMT MDV EVID CMT WT SEX AGE
$DATA ../data/derived/[DATASET].csv IGNORE=@

$SUBROUTINES ADVAN4 TRANS4

$PK
  TVCL  = THETA(1)
  TVV2  = THETA(2)
  TVQ   = THETA(3)
  TVV3  = THETA(4)
  TVKA  = THETA(5)

  CL = TVCL * EXP(ETA(1))
  V2 = TVV2 * EXP(ETA(2))
  Q  = TVQ  * EXP(ETA(3))
  V3 = TVV3 * EXP(ETA(4))
  KA = TVKA * EXP(ETA(5))

  S2 = V2

$ERROR
  IPRED = F
  W     = SQRT(THETA(6)**2 * IPRED**2 + THETA(7)**2)
  IF (W.EQ.0) W = 0.0001
  IRES  = DV - IPRED
  IWRES = IRES / W
  Y     = IPRED + W * EPS(1)

$THETA
  (0, 10)    ; CL (L/h)
  (0, 100)   ; V2 (L) - central volume
  (0, 5)     ; Q (L/h) - intercompartmental clearance
  (0, 200)   ; V3 (L) - peripheral volume
  (0, 1.5)   ; KA (1/h)
  (0, 0.1)   ; Proportional error
  (0, 0.5)   ; Additive error

$OMEGA
  0.09       ; IIV on CL
  0.09       ; IIV on V2
  0.09       ; IIV on Q
  0.09       ; IIV on V3
  0.09       ; IIV on KA

$SIGMA
  1 FIX      ; Scaled by W in $ERROR

$ESTIMATION METHOD=1 INTER MAXEVAL=9999 PRINT=5 NOABORT SIGDIGITS=3
$COVARIANCE PRINT=E UNCONDITIONAL
$TABLE ID TIME DV IPRED PRED CWRES IWRES ETA1 ETA2 ETA3 ETA4 ETA5 CL V2 Q V3 KA
       ONEHEADER NOPRINT FILE=sdtab[RUN_NUMBER]
