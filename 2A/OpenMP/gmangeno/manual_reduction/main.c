#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "omp.h"
#include "aux.h"

int sequential_reduction(int *x, int n);
int parallel_reduction(int *x, int n);


int main(int argc, char **argv){
  int  n, i, result;
  long t_start, t_end;
  int  *x;
  
  // Command line argument: array length
  if ( argc == 2 ) {
    n = atoi(argv[1]);    /* the length of the pref */
  } else {
    printf("Usage:\n\n ./main n\n\nwhere n is the length of the array to be used.\n");
    return 1;
  }


  x=(int *)malloc(sizeof(int)*n);

  
  /* Fill the array with random numbers */
  srand(1);
  for (i = 0; i < n; i++) {
    x[i] = rand() % n;
  }
  
  /* Sequential reduction */
  t_start = usecs();
  result = sequential_reduction(x, n);
  t_end = usecs();
  printf("Sequential time : %8.2f msec.  ---  Result: %d\n",((double)t_end-t_start)/1000.0, result);
  
  /* Parallel reduction */
  t_start = usecs();
  result = parallel_reduction(x, n);
  t_end = usecs();
  printf("Parallel   time : %8.2f msec.  ---  Result: %d\n",((double)t_end-t_start)/1000.0, result);

  
  return 0;
}



int sequential_reduction(int *x, int n){
  int i, res;

  res=init();
  
  for(i=0; i<n; i++)
    res = operator(res, x[i]);

  return res;
}


int parallel_reduction(int *x, int n){
  int i, res;

  res=init();

  #pragma omp parallel firstprivate(i)
  {
    
    int nth = omp_get_num_threads();
    int iam = omp_get_thread_num();

    int offset = n / nth;
    int start_i = iam*offset; // premier indice traité par ce thread (inclusif)
    int end_i = (iam==nth-1) ? n : (iam+1)*offset; // dernier indice traité par ce thread (exclusif)
                                                   // (nth n'est pas nécessairement divisible par n, donc le dernier thread va jusqu'à la fin du tableau)

    // calcul du résultat partiel (de start_i à end_i)
    int partial_res = init();
    for(i=start_i; i<end_i; i++) {
      partial_res = operator(partial_res, x[i]);
    }

    // opération sur les résultats partiels pour calcul le résultat global
    #pragma omp critical
    res = operator(res, partial_res);
  }
  
  return res;

}
