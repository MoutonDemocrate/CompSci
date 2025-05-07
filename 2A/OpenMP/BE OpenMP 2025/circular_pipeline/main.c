#include "aux.h"
#include "omp.h"


int main(int argc, char **argv){
  long t_start, t_end;
  int  i, s, I, S;
  Token token;
  
  if ( argc == 3 ) {
    I = atoi(argv[1]);    /* number of iterations */
    S = atoi(argv[2]);    /* number of stages */
  } else {
    printf("Usage:\n\n ./main I S\n\nsuch that I is the number of iterations and S the number of stages.\n");
    return 1;
  }

  init(&token, I, S);

  for(i=0; i<I; i++){
    printf("Iteration %2d\n",i);

    #pragma omp parallel num_threads(S)
    {
      #pragma omp for ordered
      for(s=0; s<S; s++){
        #pragma omp ordered
        process(&token, s);
      }
    }
  }
  
  check(&token, I, S);
  
  
  return 0;
}

// This seem to be entirely sequential ?
// I do not understand the use of OpenMP here.