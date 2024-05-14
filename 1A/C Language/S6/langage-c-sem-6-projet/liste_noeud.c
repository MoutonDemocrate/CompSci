#define _GNU_SOURCE
#include "liste_noeud.h"
#include <stdlib.h>
#include <math.h>

typedef struct _cellule
{
    noeud_id_t noeud;
    long distance;
    noeud_id_t precedent;
    struct _cellule suivant;
};
