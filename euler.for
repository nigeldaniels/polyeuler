C Project Euler in Fortran
C John Evans <john@jpevans.com>

       PROGRAM EULER
           IMPLICIT NONE
           INTEGER:: EULER1, EULER2, EULER3, EULER4

           PRINT*, EULER1()
           PRINT*, EULER2()
           PRINT*, EULER3()
           PRINT*, EULER4()
           STOP
       END


C Euler #1
C Answer: 233168
C
C If we list all the natural numbers below 10 that are multiples of 3 or 5,
C we get 3, 5, 6 and 9. The sum of these multiples is 23.
C
C Find the sum of all the multiples of 3 or 5 below 1000.

       INTEGER FUNCTION EULER1 ()
           INTEGER :: I

           EULER1 = 0

           DO I = 3, 999
              IF (MODULO(I, 3) .EQ. 0 .OR. MODULO(I, 5) .EQ. 0) THEN
                  EULER1 = EULER1  + I
              END IF
           END DO
           RETURN
       END


C Euler #2
C Answer: 4613732
C
C Each new term in the Fibonacci sequence is generated by adding the previous
C two terms. By starting with 1 and 2, the first 10 terms will be:
C
C 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
C
C Find the sum of all the even-valued terms in the sequence which do not
C exceed four million.

       INTEGER FUNCTION EULER2 ()
           IMPLICIT NONE
           INTEGER :: LAST, NEXT, CUR

           EULER2 = 2
           LAST = 1
           CUR = 2

           DO WHILE (CUR < 4000000)
               NEXT = LAST + CUR
               IF (MODULO(NEXT, 2) .EQ. 0) THEN
                   EULER2 = EULER2 + NEXT
               END IF
               LAST = CUR
               CUR = NEXT
           END DO
           RETURN
       END


C Euler #3:
C Answer: 6857
C Pretty damn slow for how awesome Fortran is supposed to be at numerical
C work, but oh well.
C
C The prime factors of 13195 are 5, 7, 13 and 29.
C
C What is the largest prime factor of the number 600851475143 ?

       LOGICAL FUNCTION ISPRM(N)
            IMPLICIT NONE
            INTEGER :: N, I
            LOGICAL :: DONE

            DONE = .FALSE.
            I = CEILING(SQRT(REAL(N)))
            ISPRM = .TRUE.

            DO WHILE (.NOT. DONE)
                IF (MODULO(N, I) .EQ. 0) THEN
                    ISPRM = .FALSE.
                    DONE = .TRUE.
                END IF
                I = I - 1
                IF (I < 2) THEN
                    DONE = .TRUE.
                END IF
            END DO
            RETURN
       END

       INTEGER FUNCTION EULER3()
           IMPLICIT NONE
           INTEGER :: I, T, MAX_FACTOR
           LOGICAL :: DIVIS, PRIME, ISPRM

           T = 600851475143
           MAX_FACTOR = CEILING(SQRT(REAL(T)))
           DO I = MAX_FACTOR, 2, -1
               DIVIS = MODULO(T, I) .EQ. 0
               PRIME = ISPRM(I)
               IF (DIVIS .AND. PRIME) THEN
                   EULER3 = I
                   RETURN
               END IF
           END DO
           EULER3 = -1
           RETURN
       END


C Problem #4
C Answer: 906609
C
C A palindromic number reads the same both ways. The largest
C palindrome made from the product of two 2-digit numbers is 9009 =
C 91 99.
C
C Find the largest palindrome made from the product of two 3-digit
C numbers.

C      SUBROUTINE BACKWRDS(STR)
C      CHARACTER STR(10)
C      CHARACTER N
C 
C      J = 10
C      DO 100 K = 1,5
C      N = STR(K)
C      STR(K) = STR(J)
C      STR(J) = N
C      J = J - 1
C 100  CONTINUE
C      RETURN
C      END

      LOGICAL FUNCTION ISPAL(N)
          IMPLICIT NONE
          INTEGER :: N
          CHARACTER :: S(32), R(32)
          WRITE(S, '(I10)') N
          R = BACKWARDS(S)
          ISPAL = S .EQ. R
          RETURN
      END

      INTEGER FUNCTION EULER4()
           IMPLICIT NONE
           INTEGER :: I, J, P, RESULT
           LOGICAL ISPAL
           RESULT = 0
           DO I = 100, 999, 1
               DO J = 100, 999, 1
                   P = I * J
                   IF ((P .GT. RESULT) .AND. (ISPAL(P))) THEN
                       RESULT = P
                   END IF
               END DO
           END DO
           EULER4 = P
           RETURN
      END