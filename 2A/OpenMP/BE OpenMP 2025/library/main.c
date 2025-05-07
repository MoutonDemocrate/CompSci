#include "aux.h"
#include <omp.h>



int main(int argc, char **argv){
  int    i, j, n, nstudents, ndesks, nbooks, book, desk, student;
  int *books_list;
  long ts, te;
  omp_lock_t *book_locks, *desk_locks;
  
   /* Command line argument */
  if ( argc == 4 ) {
    nbooks    = atoi(argv[1]);    /* the number of books per student */
    if(nbooks>TBOOKS) {
      printf("The number of books per student must be <= %d\n",TBOOKS);
      return 1;
    }
    ndesks    = atoi(argv[2]);    /* the number of desks */
    nstudents = atoi(argv[3]);    /* the number of students */
  } else {
    printf("Usage:\n\n ./main nbooks ndesks nstudents, nwhere\n");
    printf("nbooks    is the number of books per student (<=%d)\n",TBOOKS);
    printf("ndesks    is the number of desks\n");
    printf("nstudents is the number of students\n");
    return 1;
  }


  book_locks = (omp_lock_t*)malloc(TBOOKS*sizeof(omp_lock_t));
  desk_locks = (omp_lock_t*)malloc(ndesks*sizeof(omp_lock_t));

  for(book=0; book<TBOOKS; book++) omp_init_lock(book_locks + book);
  for(desk=0; desk<ndesks; desk++) omp_init_lock(desk_locks + desk);
  
  init(nstudents, nbooks, ndesks);
  
  printf("\n==================================================\n");
  printf("Start reading\n\n");

  ts = usecs();
/* =================================================================================== */
  #pragma omp parallel num_threads(nstudents) firstprivate(student, books_list, book, desk, i) shared(book_locks,desk_locks, nbooks, ndesks)
  {
    student=omp_get_thread_num();
    #pragma omp critical
    books_list = get_my_books_list(student, nbooks);
    for(i=0; i<nbooks; i++){
      book = books_list[i];
      /* If book isn't free*/
      while (!omp_test_lock(&book_locks[book])) {
        /* Wait and do nothing yay */
      }
      /* At this point, book is gotten and lock is set */

      /* Get one available desk. Note that in the sequential code there
        is only one student and thus desk 0 is always available */
      desk = 0;

      while (!omp_test_lock(&desk_locks[desk])) {
        // Find a free desk
        desk = (desk+1)%ndesks;
      }
      
      /* Read book */
      printf("Student %2d reads book %2d (%2d/%2d) on desk %2d\n", student, book, i, nbooks, desk);
      read_book(student, book, desk, nbooks);
      omp_unset_lock(&desk_locks[desk]);
      omp_unset_lock(&book_locks[book]);
    }
  }
  #pragma omp barrier
/* =================================================================================== */

  te = usecs()-ts;
  printf("\nTotal reading time: %6ld  msec.\n",te/1000);

  check(nstudents,nbooks);
  
  return 0;
}
