$PROBLEM [PROJECT_NAME] - 1-Compartment First-Order Absorption
; Run: [RUN_NUMBER]
; Based on: [PARENT_RUN]
; Description: [DESCRIPTION]
; Analyst: [ANALYST]
; Date: [DATE]

$INPUT ID TIME DV AMT MDV EVID CMT WT SEX AGE
$DATA ../data/derived/[DATASET].csv IGNORE=@

$SUBROUTINES ADVAN2 TRANS2

$PK
  TVCL = THETA(1)
  TVV  = THETA(2)
  TVKA = THETA(3)

  CL = TVCL * EXP(ETA(1))
  V  = TVV  * EXP(ETA(2))
  KA = TVKA * EXP(ETA(3))

  S2 = V

$ERROR
  IPRED = F
  W     = SQRT(THETA(4)**2 * IPRED**2 + THETA(5)**2)
  IF (W.EQ.0) W = 0.0001
  IRES  = DV - IPRED
  IWRES = IRES / W
  Y     = IPRED + W * EPS(1)

$THETA
  (0, 10)    ; CL (L/h)
  (0, 100)   ; V (L)
  (0, 1.5)   ; KA (1/h)
  (0, 0.1)   ; Proportional error
  (0, 0.5)   ; Additive error

$OMEGA
  0.09       ; IIV on CL
  0.09       ; IIV on V
  0.09       ; IIV on KA

$SIGMA
  1 FIX      ; Scaled by W in $ERROR

$ESTIMATION METHOD=1 INTER MAXEVAL=9999 PRINT=5 NOABORT SIGDIGITS=3
$COVARIANCE PRINT=E UNCONDITIONAL
$TABLE ID TIME DV IPRED PRED CWRES IWRES ETA1 ETA2 ETA3 CL V KA
       ONEHEADER NOPRINT FILE=sdtab[RUN_NUMBER]
