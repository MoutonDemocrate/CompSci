#include <stdio.h>
#include <stdlib.h>
#include "aux.h"
#include "omp.h"

int main(int argc, char **argv){
  long   t_start, t_end;
  int    np, p, s;
  procedure_t procedure;

  if ( argc == 2 ) {
    np = atoi(argv[1]);
  } else {
    printf("Usage:\n\n ./main np\n\nwhere np is the number of procedures to execute.\n");
    return 1;
  }
  init(np);
  
  t_start = usecs();

  // Création de locks pour chaque ressource
  int nb_levels = 5;
  omp_lock_t *locks;
  locks = (omp_lock_t*)malloc(nb_levels*sizeof(omp_lock_t));
  for (int i=0; i < nb_levels; i++) {
    omp_init_lock(locks+i);
  }

  #pragma omp parallel
  {
  #pragma omp master
  {

  for(p=0; p<np; p++){

      get_procedure(&procedure);

      for(s=0; s<procedure.nsteps; s++){
        #pragma omp task firstprivate(procedure,s)    // Une tâche créée pour chaque étape de procédure
        {
          switch (procedure.steps[s]) {               // Chaque ressource est derrière un lock
          case PRINTER:
            //printf("%3d  %2d -- Asking for printer %d\n",p,s,procedure.data[s]);
            while(!omp_test_lock(&locks[(int)procedure.steps[s]]));
            //printf("%3d  %2d -- Using printer %d\n",p,s,procedure.data[s]);
            use_printer(procedure, s);
            omp_unset_lock(&locks[(int)procedure.steps[s]]);
            //printf("%3d  %2d -- Over with printer %d\n",p,s,procedure.data[s]);
            break;
          case CPU:
            //printf("%3d  %2d -- Asking for CPU     %d\n",p,s,procedure.data[s]);
            while(!omp_test_lock(&locks[(int)procedure.steps[s]]));
            //printf("%3d  %2d -- Using CPU     %d\n",p,s,procedure.data[s]);
            use_cpu(procedure, s);
            omp_unset_lock(&locks[(int)procedure.steps[s]]);
            //printf("%3d  %2d -- Over with CPU     %d\n",p,s,procedure.data[s]);
            break;
          case SCREEN:
            //printf("%3d  %2d -- Asking for screen  %d\n",p,s,procedure.data[s]);
            while(!omp_test_lock(&locks[(int)procedure.steps[s]]));
            //printf("%3d  %2d -- Using screen  %d\n",p,s,procedure.data[s]);
            use_screen(procedure, s);
            omp_unset_lock(&locks[(int)procedure.steps[s]]);
            //printf("%3d  %2d -- Over with screen  %d\n",p,s,procedure.data[s]);
            break;
          case DISK:
            //printf("%3d  %2d -- Asking for disk    %d\n",p,s,procedure.data[s]);
            while(!omp_test_lock(&locks[(int)procedure.steps[s]]));
            //printf("%3d  %2d -- Using disk    %d\n",p,s,procedure.data[s]);
            use_disk(procedure, s);
            omp_unset_lock(&locks[(int)procedure.steps[s]]);
            //printf("%3d  %2d -- Over with disk    %d\n",p,s,procedure.data[s]);
            break;
          case MEMORY:
            //printf("%3d  %2d -- Asking for memory  %d\n",p,s,procedure.data[s]);
            while(!omp_test_lock(&locks[(int)procedure.steps[s]]));
            //printf("%3d  %2d -- Using memory  %d\n",p,s,procedure.data[s]);
            use_memory(procedure, s);
            omp_unset_lock(&locks[(int)procedure.steps[s]]);
            //printf("%3d  %2d -- Over with memory  %d\n",p,s,procedure.data[s]);
            break;
          }
        }
      }
  }  

  }
  }

  t_end = usecs();
  printf("Execution time: %.4f\n",((double)t_end-t_start)/1000.0);
  check_result();

}
