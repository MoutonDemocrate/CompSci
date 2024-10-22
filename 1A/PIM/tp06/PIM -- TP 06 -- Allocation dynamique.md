## PIM -- TP 06 -- Allocation dynamique

## Exercice 1

Compiler et exécuter le programme renvoie ceci :

```
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatawa -g exemples_memoire_dynamique.adb                                                                    [23-10-25 - 8:31:09]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatawa -g exemples_memoire_dynamique.adb
exemples_memoire_dynamique.adb:39:19: warning: procedure "Illustrer_Memoire_Dynamique_Erreur" is not referenced [-gnatwu]
exemples_memoire_dynamique.adb:74:19: warning: procedure "Illustrer_Pointeur_In" is not referenced [-gnatwu]
exemples_memoire_dynamique.adb:96:19: warning: procedure "Illustrer_Pile_Locale" is not referenced [-gnatwu]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatawa -g piles.adb
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique.ali -g
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ ./exemples_memoire_dynamique                                                                                                  [23-10-25 - 8:31:21]
Ptr1.all =  5
Ptr1.all =  5
```

Rien ne paraît anormal.

## Exercice 2

En exécutant `valgrind ./exemples_memoire_dynamique`, on obtient :

```
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ valgrind ./exemples_memoire_dynamique
==18337== Memcheck, a memory error detector
==18337== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==18337== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==18337== Command: ./exemples_memoire_dynamique
==18337==
Ptr1.all =  5
Ptr1.all =  5
==18337==
==18337== HEAP SUMMARY:
==18337==     in use at exit: 4 bytes in 1 blocks
==18337==   total heap usage: 2 allocs, 1 frees, 8 bytes allocated
==18337==
==18337== LEAK SUMMARY:
==18337==    definitely lost: 4 bytes in 1 blocks
==18337==    indirectly lost: 0 bytes in 0 blocks
==18337==      possibly lost: 0 bytes in 0 blocks
==18337==    still reachable: 0 bytes in 0 blocks
==18337==         suppressed: 0 bytes in 0 blocks
==18337== Rerun with --leak-check=full to see details of leaked memory
==18337==
==18337== For lists of detected and suppressed errors, rerun with: -s
==18337== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

On remarque une fuite de 4 octets, comme indiqué par la ligne `definitely lost: 4 bytes in 1 blocks`dans le bloc `LEAK SUMMARY`.

Après exécution de la commande avec l'argument `--leak-check=full`, on obtient :

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ valgrind --leak-check=full ./exemples_memoire_dynamique                                                                       [23-10-25 - 8:41:06]
==18473== Memcheck, a memory error detector
==18473== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==18473== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==18473== Command: ./exemples_memoire_dynamique
==18473==
Ptr1.all =  5
Ptr1.all =  5
==18473==
==18473== HEAP SUMMARY:
==18473==     in use at exit: 4 bytes in 1 blocks
==18473==   total heap usage: 2 allocs, 1 frees, 8 bytes allocated
==18473==
==18473== 4 bytes in 1 blocks are definitely lost in loss record 1 of 1
==18473==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==18473==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==18473==    by 0x10BBAA: exemples_memoire_dynamique__illustrer_memoire_dynamique_sans_free.1 (exemples_memoire_dynamique.adb:31)
==18473==    by 0x10BB79: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique.adb:117)
==18473==    by 0x10B888: main (b~exemples_memoire_dynamique.adb:244)
==18473==
==18473== LEAK SUMMARY:
==18473==    definitely lost: 4 bytes in 1 blocks
==18473==    indirectly lost: 0 bytes in 0 blocks
==18473==      possibly lost: 0 bytes in 0 blocks
==18473==    still reachable: 0 bytes in 0 blocks
==18473==         suppressed: 0 bytes in 0 blocks
==18473==
==18473== For lists of detected and suppressed errors, rerun with: -s
==18473== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

On remarque maintenant que `valgrind` renvoie aussi les lignes de codes et les programmes qui ont leak la mémoire.

On modifie la procédure `Illustrer_Memoire_Dynamique_Sans_Free`de manière à libérer la mémoire utilisée par `Ptr1` à la fin de la procédure.

On recompile :

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb                                                             [23-10-25 - 8:48:12]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
exemples_memoire_dynamique_leakFix.adb:40:19: warning: procedure "Illustrer_Memoire_Dynamique_Erreur" is not referenced [-gnatwu]
exemples_memoire_dynamique_leakFix.adb:75:19: warning: procedure "Illustrer_Pointeur_In" is not referenced [-gnatwu]
exemples_memoire_dynamique_leakFix.adb:97:19: warning: procedure "Illustrer_Pile_Locale" is not referenced [-gnatwu]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
```

Et on exécute le nouvel exécutable avec `valgrind` :

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ valgrind ./exemples_memoire_dynamique_leakFix                                                                                 [23-10-25 - 8:48:23]
==18692== Memcheck, a memory error detector
==18692== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==18692== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==18692== Command: ./exemples_memoire_dynamique_leakFix
==18692==
Ptr1.all =  5
Ptr1.all =  5
==18692==
==18692== HEAP SUMMARY:
==18692==     in use at exit: 0 bytes in 0 blocks
==18692==   total heap usage: 2 allocs, 2 frees, 8 bytes allocated
==18692==
==18692== All heap blocks were freed -- no leaks are possible
==18692==
==18692== For lists of detected and suppressed errors, rerun with: -s
==18692== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

L'erreur est donc bien corrigée.

## Exercice 3

**Questions** :

- `Ptr2.all` vaut ici 5

- On ne peut plus le manipuler ! Le pointeur est `Null`...

- ```shell
  ╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
  ╰─☮ valgrind ./exemples_memoire_dynamique_leakFix                                                                                 [23-10-25 - 8:56:35]
  ==18915== Memcheck, a memory error detector
  ==18915== Copyright (C) 2002-2022, and GNU GPLd, by Julian Seward et al.
  ==18915== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
  ==18915== Command: ./exemples_memoire_dynamique_leakFix
  ==18915==
  Ptr1.all =  5
  Ptr1.all =  5
  ==18915== Invalid read of size 4
  ==18915==    at 0x10BF84: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:56)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 freed
  ==18915==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BEB3: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Block was allocated at
  ==18915==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BE24: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==
  Ptr2.all =  5
  ==18915== Invalid write of size 4
  ==18915==    at 0x10C16A: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:58)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 freed
  ==18915==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BEB3: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Block was allocated at
  ==18915==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BE24: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==
  ==18915== Invalid read of size 4
  ==18915==    at 0x10C174: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:59)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 freed
  ==18915==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BEB3: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==  Block was alloc'd at
  ==18915==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
  ==18915==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
  ==18915==    by 0x10BE24: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
  ==18915==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:119)
  ==18915==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
  ==18915==
  ==18915==
  ==18915== HEAP SUMMARY:
  ==18915==     in use at exit: 0 bytes in 0 blocks
  ==18915==   total heap usage: 3 allocs, 3 frees, 12 bytes allocated
  ==18915==
  ==18915== All heap blocks were freed -- no leaks are possible
  ==18915==
  ==18915== For lists of detected and suppressed errors, rerun with: -s
  ==18915== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)
  ```

Le programme est incapable de lire et écrire dans la mémoire dédiée à `Ptr2` car on l'a mis à `Null`.

## Exercice 4

La valeur de `Ptr1.all` est modifiée normalement.

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb ; ./exemples_memoire_dynamique_leakFix                      [23-10-25 - 9:04:45]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
exemples_memoire_dynamique_leakFix.adb:40:19: warning: procedure "Illustrer_Memoire_Dynamique_Erreur" is not referenced [-gnatwu]
exemples_memoire_dynamique_leakFix.adb:97:19: warning: procedure "Illustrer_Pile_Locale" is not referenced [-gnatwu]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
Ptr1.all =  5
Ptr1.all =  5
valeur de Ptr.all ?  123
```

On peut donc utiliser des pointeurs comme inputs dans des procédures.

## Exercice 5
