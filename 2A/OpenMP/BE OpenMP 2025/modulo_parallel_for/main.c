#include "aux.h"
#include <omp.h>


int main(int argc, char **argv){
  int    i, j, n, nthreads;
  int *x;
  long ts, te;

   /* Command line argument */
  if ( argc == 3 ) {
    n = atoi(argv[1]);    /* the size of x */
    nthreads = atoi(argv[2]);    /* the number of threads */
  } else {
    printf("Usage:\n\n ./main n nthreads\n\nwhere n is the size of the x array\n");
    printf("and nthreads the number of threads to be used\n");
    return 1;
  }

  x = (int*)calloc(n, sizeof(int));
  init(x, n, nthreads);
  printf("==================================================\n");
  printf("Starting loop\n\n");
  
  ts = usecs();
  int new_i = 0;
  int calc_count = n/nthreads + 1; // We calculate max update count per thread
  printf("Max update count per thread : %2d\n\n",calc_count);
  int t = 0;
  #pragma omp parallel num_threads(nthreads) firstprivate(new_i,i,t) shared(nthreads)
  {
    t = omp_get_thread_num();
    // #pragma omp for
    for(i=0; i<calc_count; i++) {
      // printf("Thread n°%2d enters i n°%2d\n",t, i);
      new_i = (i*nthreads) + t;
      // printf("Thread n°%2d finds new i n°%2d\n",t, new_i);
      if (new_i<n) {
        // printf("Thread n°%2d updates array at position %2d\n",t, new_i);
        x[new_i] = update(new_i, nthreads);
      }
    }
  }
  te = usecs()-ts;
  printf("Execution time: %6ld  msec.\n",te/1000);
  
  return 0;
}
