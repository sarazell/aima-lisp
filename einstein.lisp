"http://weitz.de/einstein.html"

"Here's the function SOLVE that is built by PREPARE"

  (DEFUN SOLVE ()
    (LET ((MOUSE-PERMUTATIONS
           (MAPCAR #'(LAMBDA (PERMUTATION) (MAKE-ARRAY 3 :INITIAL-CONTENTS PERMUTATION))
                   (PERMUTE '(MICKEY MINNY MIGHTY))))
          (CHEESE-FLAVOR-PERMUTATIONS
           (MAPCAR #'(LAMBDA (PERMUTATION) (MAKE-ARRAY 3 :INITIAL-CONTENTS PERMUTATION))
                   (PERMUTE '(EMMENTAL GOUDA BRIE))))
          (TV-SHOW-PERMUTATIONS
           (MAPCAR #'(LAMBDA (PERMUTATION) (MAKE-ARRAY 3 :INITIAL-CONTENTS PERMUTATION))
                   (PERMUTE '(SEINFELD SIMPSONS ER)))))
      (DOLIST (MICE MOUSE-PERMUTATIONS)
        (LET ((RESULT (POSSIBLE-P MICE)))
          (WHEN RESULT
            (DOLIST (CHEESE-FLAVORS CHEESE-FLAVOR-PERMUTATIONS)
              (LET ((RESULT (POSSIBLE-P MICE CHEESE-FLAVORS)))
                (WHEN RESULT
                  (DOLIST (TV-SHOWS TV-SHOW-PERMUTATIONS)
                    (LET ((RESULT (POSSIBLE-P MICE CHEESE-FLAVORS TV-SHOWS)))
                      (WHEN RESULT (PPRINT RESULT))))))))))
      (VALUES))))
which uses the predicate POSSIBLE-P that is built at the same time:

  (DEFUN POSSIBLE-P
         (&OPTIONAL (MICE *NOT-YET-DEFINED*)
                    (CHEESE-FLAVORS *NOT-YET-DEFINED*)
                    (TV-SHOWS *NOT-YET-DEFINED*))
    (DOTIMES (M 3)
      (SETF (MOUSE (SVREF *SELECTION* M)) (SVREF MICE M))
      (SETF (CHEESE-FLAVOR (SVREF *SELECTION* M)) (SVREF CHEESE-FLAVORS M))
      (SETF (TV-SHOW (SVREF *SELECTION* M)) (SVREF TV-SHOWS M)))
    (WHEN (AND (COND1 *SELECTION*)
               (COND2 *SELECTION*)
               (COND3 *SELECTION*)
               (COND4 *SELECTION*)
               (COND5 *SELECTION*))
      *SELECTION*))




"problem domain/constraints"

(prepare einstein
  ((nation '(british swedish norwegian german danish))
    (house '(red green yellow blue white))
   (animal '(dog horse cat bird fish))
   (cigarette '(marlboro winfield rothmans pallmall dunhill))
   (drink '(tea coffee milk beer water)))
  ((cond-position-first-norwegian :position 0 nation 'norwegian)
   (cond-left-green-white house 'green house 'white :distance 1 :directed t)
   (cond-british-red nation 'british house 'red)
   (cond-neighbor-norwegian-blue nation 'norwegian house 'blue :distance 1)
   (cond-swedish-dog nation 'swedish animal 'dog)
   (cond-german-rothmans nation 'german cigarette 'rothmans)
   (cond-yellow-dunhill house 'yellow cigarette 'dunhill)
   (cond-green-coffee house 'green drink 'coffee)
   (cond-danish-tea nation 'danish drink 'tea)
   (cond-bird-pallmall animal 'bird cigarette 'pallmall)
   (cond-neighbor-cat-marlboro animal 'cat cigarette 'marlboro :distance 1)
   (cond-neighbor-horse-dunhill animal 'horse cigarette 'dunhill :distance 1)
   (cond-winfield-beer cigarette 'winfield drink 'beer)
   (cond-neighbor-marlboro-water cigarette 'marlboro drink 'water :distance 1)
   (cond-position-middle-milk :position 2 drink 'milk)))

