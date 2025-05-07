#include "aux.h"
#include "omp.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

void parallel_ops(int n, int nops, int **board, operation_t *operations);
void sequential_ops(int n, int nops, int **board, operation_t *operations);

int main(int argc, char **argv) {
  long t_start, t_end;
  int n, nops, op, i, j;
  int **board;
  int **board_par;
  operation_t *operations;
  operation_t operation;

  if (argc == 3) {
    n = atoi(argv[1]);
    if (n > 10) {
      printf("Choose a value of n that is smaller or equal to 10\n");
      return 1;
    }
    nops = atoi(argv[2]);
  } else {
    printf(
        "Usage:\n\n ./main n nops\n\nwhere n is the size of the board and\n");
    printf("nops is the number of operations to execute.\n");
    return 1;
  }

  board = init_board(n);
  operations = init_operations(nops, n);

  board_par = (int **)malloc((n + 2) * sizeof(int *));
  for (i = 0; i < n + 2; i++) {
    board_par[i] = (int *)malloc((n + 2) * sizeof(int));
    for (j = 0; j < n + 2; j++)
      board_par[i][j] = board[i][j];
  }

  print_board(board, n);

  t_start = usecs();
  sequential_ops(n, nops, board, operations);
  t_end = usecs();
  printf("Execution time: %.4f\n", ((double)t_end - t_start) / 1000.0);

  printf("Sequential :\n");
  print_board(board, n);
  // print_board(board_par, n);
  // reinit_board(n, board);

  t_start = usecs();
  parallel_ops(n, nops, board_par, operations);
  t_end = usecs();
  printf("Execution time: %.4f\n", ((double)t_end - t_start) / 1000.0);

  printf("Parallel :\n");
  print_board(board_par, n);

  for (i = 0; i < n + 2; i++) {
    for (j = 0; j < n + 2; j++) {
      if (board[i][j] != board_par[i][j]) {
        printf("At position (%2d,%2d) : seq = %2d and par = %2d !\n", i, j,
               board[i][j], board_par[i][j]); /* For testing purposes */
      }
    }
  }
}

void sequential_ops(int n, int nops, int **board, operation_t *operations) {

  int op, i, j;
  operation_t operation;

  for (op = 0; op < nops; op++) {
    operation = operations[op];
    i = operation.i;
    j = operation.j;
    switch (operation.optype) {
    case LEFT:
      /* printf("%2d  -- LEFT    on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      update(&(board[i][j]), board[i][j - 1]);
      break;
    case RIGHT:
      /* printf("%2d  -- RIGHT   on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      update(&(board[i][j]), board[i][j + 1]);
      break;
    case UP:
      /* printf("%2d  -- UP      on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      update(&(board[i][j]), board[i - 1][j]);
      break;
    case DOWN:
      /* printf("%2d  -- DOWN    on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      update(&(board[i][j]), board[i + 1][j]);
      break;
    case GATHER:
      /* printf("%2d  -- GATHER  on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      gather(&(board[i][j]), board[i][j - 1], board[i][j + 1], board[i + 1][j],
             board[i - 1][j]);
      break;
    case SCATTER:
      /* printf("%2d  -- SCATTER on %2d %2d   \n",omp_get_thread_num(), i, j);
       */
      scatter((board[i][j]), &board[i][j - 1], &board[i][j + 1],
              &board[i + 1][j], &board[i - 1][j]);
      break;
    default:
      break; // nothing
    }
  }
}

// We create an additional function
bool lower_than_x_exists_in_order(int x, int i_, int j_, bool ***b) {
  for (int k = 0; k < x; k++) {
    if (b[i_][j_][k]) {
      return true;
    }
  }
  return false;
}

void parallel_ops(int n, int nops, int **board, operation_t *operations) {

  int op, i, j;
  operation_t operation;

  omp_lock_t **lock_board;
  bool ***order_board;

  lock_board = (omp_lock_t **)malloc((n + 2) * sizeof(omp_lock_t *));
  for (i = 0; i < n + 2; i++) {
    lock_board[i] = (omp_lock_t *)malloc((n + 2) * sizeof(omp_lock_t *));
    for (j = 0; j < n + 2; j++)
      omp_init_lock(&lock_board[i][j]);
  }

  order_board = (bool ***)malloc((n + 2) * sizeof(bool *));
  for (i = 0; i < n + 2; i++) {
    order_board[i] = (bool **)malloc((n + 2) * sizeof(bool *));
    for (j = 0; j < n + 2; j++)
      order_board[i][j] = (bool *)malloc(nops * sizeof(bool *));
  }

  printf("Starting ordering operations ...\n\n");

#pragma omp parallel firstprivate(op, i, j, operation)                         \
    shared(lock_board, order_board) num_threads(nops)

#pragma omp for
  for (op = 0; op < nops; op++) {
    {
      operation = operations[op];
      i = operation.i;
      j = operation.j;

#pragma omp critical
      {
        switch (operation.optype) {
        case LEFT:
          order_board[i][j][op] = true;
          order_board[i][j - 1][op] = true;
          break;
        case RIGHT:
          order_board[i][j][op] = true;
          order_board[i][j + 1][op] = true;
          break;
        case UP:
          order_board[i][j][op] = true;
          order_board[i - 1][j][op] = true;
          break;
        case DOWN:
          order_board[i][j][op] = true;
          order_board[i + 1][j][op] = true;
          break;
        case GATHER:
          order_board[i][j][op] = true;
          order_board[i][j + 1][op] = true;
          order_board[i][j - 1][op] = true;
          order_board[i + 1][j][op] = true;
          order_board[i - 1][j][op] = true;
          break;
        case SCATTER:
          order_board[i][j][op] = true;
          order_board[i][j + 1][op] = true;
          order_board[i][j - 1][op] = true;
          order_board[i + 1][j][op] = true;
          order_board[i - 1][j][op] = true;
          break;
        default:
          break; // nothing
        }
      }

      printf("Operation n°%2d on the order board.\n", op);
    }
  }
#pragma omp barrier
#pragma omp for
  for (op = 0; op < nops; op++) {
    operation = operations[op];
    i = operation.i;
    j = operation.j;
    printf("Starting processing operation %2d ...\n", op);

    switch (operation.optype) {
    case LEFT:
      /* printf("%2d  -- LEFT    on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */

      while (lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j])) &&
             lower_than_x_exists_in_order(op, i, j - 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j - 1]))) {
        /* Wait and do nothing yay */
      }
      update(&(board[i][j]), board[i][j - 1]);
      omp_unset_lock(&lock_board[i][j]);
      omp_unset_lock(&lock_board[i][j - 1]);
      order_board[i][j][op] = false;
      order_board[i][j - 1][op] = false;
      break;
    case RIGHT:
      /* printf("%2d  -- RIGHT   on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */
      while (lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j])) &&
             lower_than_x_exists_in_order(op, i, j + 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j + 1]))) {
        /* Wait and do nothing yay */
      }
      update(&(board[i][j]), board[i][j + 1]);
      omp_unset_lock(&lock_board[i][j]);
      omp_unset_lock(&lock_board[i][j + 1]);
      order_board[i][j][op] = false;
      order_board[i][j + 1][op] = false;

      break;
    case UP:
      /* printf("%2d  -- UP      on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */
      while (lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j])) &&
             lower_than_x_exists_in_order(op, i - 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i - 1][j]))) {
        /* Wait and do nothing yay */
      }
      update(&(board[i][j]), board[i - 1][j]);
      omp_unset_lock(&lock_board[i][j]);
      omp_unset_lock(&lock_board[i - 1][j]);
      order_board[i][j][op] = false;
      order_board[i - 1][j][op] = false;

      break;
    case DOWN:
      /* printf("%2d  -- DOWN    on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */
      while (lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j])) &&
             lower_than_x_exists_in_order(op, i + 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i + 1][j]))) {
        /* Wait and do nothing yay */
      }
      update(&(board[i][j]), board[i + 1][j]);
      omp_unset_lock(&lock_board[i][j]);
      omp_unset_lock(&lock_board[i + 1][j]);
      order_board[i][j][op] = false;
      order_board[i + 1][j][op] = false;

      break;
    case GATHER:
      /* printf("%2d  -- GATHER  on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */
      while (lower_than_x_exists_in_order(op, i + 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i + 1][j])) &&
             lower_than_x_exists_in_order(op, i - 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i - 1][j])) &&
             lower_than_x_exists_in_order(op, i, j + 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j + 1])) &&
             lower_than_x_exists_in_order(op, i, j - 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j - 1])) &&
             lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j]))) {
        /* Wait and do nothing yay */
      }
      gather(&(board[i][j]), board[i][j - 1], board[i][j + 1], board[i + 1][j],
             board[i - 1][j]);
      omp_unset_lock(&lock_board[i + 1][j]);
      omp_unset_lock(&lock_board[i - 1][j]);
      omp_unset_lock(&lock_board[i][j + 1]);
      omp_unset_lock(&lock_board[i][j - 1]);
      omp_unset_lock(&lock_board[i][j]);
      order_board[i][j][op] = false;
      order_board[i][j - 1][op] = false;
      order_board[i - 1][j][op] = false;
      order_board[i][j + 1][op] = false;
      order_board[i + 1][j][op] = false;

      break;
    case SCATTER:
      /* printf("%2d  -- SCATTER on %2d %2d   \n",omp_get_thread_num(), i,
       * j);
       */
      while (lower_than_x_exists_in_order(op, i + 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i + 1][j])) &&
             lower_than_x_exists_in_order(op, i - 1, j, order_board) &&
             (!omp_test_lock(&lock_board[i - 1][j])) &&
             lower_than_x_exists_in_order(op, i, j + 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j + 1])) &&
             lower_than_x_exists_in_order(op, i, j - 1, order_board) &&
             (!omp_test_lock(&lock_board[i][j - 1])) &&
             lower_than_x_exists_in_order(op, i, j, order_board) &&
             (!omp_test_lock(&lock_board[i][j]))) {
        /* Wait and do nothing yay */
      }
      scatter((board[i][j]), &board[i][j - 1], &board[i][j + 1],
              &board[i + 1][j], &board[i - 1][j]);
      omp_unset_lock(&lock_board[i + 1][j]);
      omp_unset_lock(&lock_board[i - 1][j]);
      omp_unset_lock(&lock_board[i][j + 1]);
      omp_unset_lock(&lock_board[i][j - 1]);
      omp_unset_lock(&lock_board[i][j]);
      order_board[i][j][op] = false;
      order_board[i][j - 1][op] = false;
      order_board[i - 1][j][op] = false;
      order_board[i][j + 1][op] = false;
      order_board[i + 1][j][op] = false;

      break;
    default:
      break; // nothing
    }
  }
}

// Explanation
// I created a new board, board_par, to track differences automatically.
// My system uses an order board for operations, and a lock board :
// - The lock board can lock any cell of the board to prevent operations happenening at the same time.
// - The order board prevents operations from happening if they interact with a cell that has another operation before it in the order board.
//    - Supposedly, this would prevent operations from happening out of order, except if they target completely different cells, in which case they can happen at the same time.
//    - Practically, it's an ordered parallel for loop. Which is useless, as it does not same any time. I blame the operations here, but my code could just be wrong.








// Additionally this might be the most uselessely complex system I have ever made in C