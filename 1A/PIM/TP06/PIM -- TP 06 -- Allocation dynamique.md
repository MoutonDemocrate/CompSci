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
  ==18915==  Block was allocated at
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

La variable `P` est une variable du sous-programme mais elle n'utilise pas de pointeur. Il vaudrait mieux la détruire à la fin de l'appel.

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb ; valgrind --leak-check=full ./exemples_memoire_dynamique_leakFix
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
exemples_memoire_dynamique_leakFix.adb:40:19: warning: procedure "Illustrer_Memoire_Dynamique_Erreur" is not referenced [-gnatwu]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
==19603== Memcheck, a memory error detector
==19603== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==19603== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==19603== Command: ./exemples_memoire_dynamique_leakFix
==19603==
Ptr1.all =  5
Ptr1.all =  5
valeur de Ptr.all ?  123
Sommet =  4
Sommet =  2
==19603==
==19603== HEAP SUMMARY:
==19603==     in use at exit: 32 bytes in 2 blocks
==19603==   total heap usage: 5 allocs, 3 frees, 44 bytes allocated
==19603==
==19603== 32 (16 direct, 16 indirect) bytes in 1 blocks are definitely lost in loss record 2 of 2
==19603==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==19603==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==19603==    by 0x10C776: exemples_memoire_dynamique__illustrer_pile_locale__pile__empiler.8 (piles.adb:35)
==19603==    by 0x10C407: exemples_memoire_dynamique__illustrer_pile_locale.4 (exemples_memoire_dynamique_leakFix.adb:108)
==19603==    by 0x10BBA1: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:121)
==19603==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==19603==
==19603== LEAK SUMMARY:
==19603==    definitely lost: 16 bytes in 1 blocks
==19603==    indirectly lost: 16 bytes in 1 blocks
==19603==      possibly lost: 0 bytes in 0 blocks
==19603==    still reachable: 0 bytes in 0 blocks
==19603==         suppressed: 0 bytes in 0 blocks
==19603==
==19603== For lists of detected and suppressed errors, rerun with: -s
==19603== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

On constate effectivement une erreur. En appelant `Detruire` sur la pile `P`, on répare l'erreur :

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb ; valgrind --leak-check=full ./exemples_memoire_dynamique_leakFix
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
exemples_memoire_dynamique_leakFix.adb:40:19: warning: procedure "Illustrer_Memoire_Dynamique_Erreur" is not referenced [-gnatwu]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
==19813== Memcheck, a memory error detector
==19813== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==19813== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==19813== Command: ./exemples_memoire_dynamique_leakFix
==19813==
Ptr1.all =  5
Ptr1.all =  5
valeur de Ptr.all ?  123
Sommet =  4
Sommet =  2
==19813==
==19813== HEAP SUMMARY:
==19813==     in use at exit: 0 bytes in 0 blocks
==19813==   total heap usage: 5 allocs, 5 frees, 44 bytes allocated
==19813==
==19813== All heap blocks were freed -- no leaks are possible
==19813==
==19813== For lists of detected and suppressed errors, rerun with: -s
==19813== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

## Exercice 6

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb ; ./exemples_memoire_dynamique_leakFix                      [23-10-25 - 9:17:22]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
Ptr1.all =  5
Ptr1.all =  5
Ptr2.all =  1570918618
valeur de Ptr.all ?  123
Sommet =  4
Sommet =  2
```

On constate une valeur étrange : `Ptr2.all = 1570918618` ...
Il s'agit probablement d'un problème de mémoire. Le pointeur original n'existe plus, et conséquement la variable a du mal à savoir sur quel bloc mémoire elle est stockée...

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ valgrind ./exemples_memoire_dynamique_leakFix                                                                                 [23-10-25 - 9:22:52]
==20111== Memcheck, a memory error detector
==20111== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==20111== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==20111== Command: ./exemples_memoire_dynamique_leakFix
==20111==
Ptr1.all =  5
Ptr1.all =  5
==20111== Invalid read of size 4
==20111==    at 0x10BF9C: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:56)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 freed
==20111==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BECB: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Block was allocated at
==20111==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BE3C: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==
Ptr2.all =  5
==20111== Invalid write of size 4
==20111==    at 0x10C182: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:58)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 ffreed==20111==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BECB: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Block was allocated at
==20111==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BE3C: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==
==20111== Invalid read of size 4
==20111==    at 0x10C18C: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:59)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Address 0x4ff90e0 is 0 bytes inside a block of size 4 frfreed=20111==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BECB: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:50)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==  Block was allocated at
==20111==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20111==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20111==    by 0x10BE3C: exemples_memoire_dynamique__illustrer_memoire_dynamique_erreur.2 (exemples_memoire_dynamique_leakFix.adb:44)
==20111==    by 0x10BB95: _ada_exemples_memoire_dynamique (exemples_memoire_dynamique_leakFix.adb:120)
==20111==    by 0x10B898: main (b~exemples_memoire_dynamique_leakFix.adb:244)
==20111==
valeur de Ptr.all ?  123
Sommet =  4
Sommet =  2
==20111==
==20111== HEAP SUMMARY:
==20111==     in use at exit: 0 bytes in 0 blocks
==20111==   total heap usage: 6 allocs, 6 frees, 48 bytes allocated
==20111==
==20111== All heap blocks were freed -- no leaks are possible
==20111==
==20111== For lists of detected and suppressed errors, rerun with: -s
==20111== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)FF
```

Pointer un pointeur vers un autre est en général une mauvaise pratique... Il vaut mieux n'utiliser qu'un pointeur ou traiter les deux séparément. En appliquant ce principe, on peut réparer le programme :

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb ; valgrind --leak-check=full ./exemples_memoire_dynamique_leakFix
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g exemples_memoire_dynamique_leakFix.adb
exemples_memoire_dynamique_leakFix.adb:5:11: warning: file name does not match unit name, should be "exemples_memoire_dynamique.adb" [enabled by default]
x86_64-linux-gnu-gnatbind-12 -x exemples_memoire_dynamique_leakFix.ali
x86_64-linux-gnu-gnatlink-12 exemples_memoire_dynamique_leakFix.ali -g
==20459== Memcheck, a memory error detector
==20459== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==20459== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==20459== Command: ./exemples_memoire_dynamique_leakFix
==20459==
Ptr1.all =  5
Ptr1.all =  5
Ptr2.all =  5
valeur de Ptr.all ?  123
Sommet =  4
Sommet =  2
==20459==
==20459== HEAP SUMMARY:
==20459==     in use at exit: 0 bytes in 0 blocks
==20459==   total heap usage: 7 allocs, 7 frees, 52 bytes allocated
==20459==
==20459== All heap blocks were freed -- no leaks are possible
==20459==
==20459== For lists of detected and suppressed errors, rerun with: -s
==20459== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

## Exercice 7

**Questions** :

- `[ A , B >`

- Il est déconseiller d'utiliser une variable pour en initialiser une autre, surtout dans les cas liés aux types `Array` ou similaires.

- `[ A >`

- `[`, le sous-programme ne saura pas afficher le reste sans erreur.

- `P1` n'est pas dépilée mais n'a pas de valeurs non plus...

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ gnatmake -gnata -gnatwa -g illustrer_affectation_pile.adb; ./illustrer_affectation_pile                                       [23-10-25 - 9:28:57]
x86_64-linux-gnu-gcc-12 -c -gnata -gnatwa -g illustrer_affectation_pile.adb
x86_64-linux-gnu-gnatbind-12 -x illustrer_affectation_pile.ali
x86_64-linux-gnu-gnatlink-12 illustrer_affectation_pile.ali -g
[ A, B >
[ A >
[

raised STORAGE_ERROR : stack overflow or erroneous memory access
```

```shell
╭─lae at j4ckw1r3 in ~/Documents/Work/CompSci/PIM/TP06
╰─☮ valgrind ./illustrer_affectation_pile                                                                                         [23-10-25 - 9:32:45]
==20652== Memcheck, a memory error detector
==20652== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==20652== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==20652== Command: ./illustrer_affectation_pile
==20652==
[ A, B >
[ A >
[==20652== Invalid read of size 8
==20652==    at 0x10BD1F: illustrer_affectation_pile__afficher__afficher_elements.8 (piles.adb:71)
==20652==    by 0x10BE2B: illustrer_affectation_pile__afficher.7 (piles.adb:83)
==20652==    by 0x10BA81: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:27)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Address 0x4ff9098 is 8 bytes inside a block of size 16 free'd
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA4D: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:25)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Block was alloc'd at
==20652==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BBEF: illustrer_affectation_pile__pile__empiler.3 (piles.adb:35)
==20652==    by 0x10B9DF: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:19)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==
==20652== Invalid read of size 8
==20652==    at 0x10BD7F: illustrer_affectation_pile__afficher__afficher_elements.8 (piles.adb:75)
==20652==    by 0x10BE2B: illustrer_affectation_pile__afficher.7 (piles.adb:83)
==20652==    by 0x10BA81: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:27)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Address 0x4ff9098 is 8 bytes inside a block of size 16 free'd
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA4D: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:25)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Block was alloc'd at
==20652==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BBEF: illustrer_affectation_pile__pile__empiler.3 (piles.adb:35)
==20652==    by 0x10B9DF: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:19)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==
 A, ==20652== Invalid read of size 1
==20652==    at 0x10BDD5: illustrer_affectation_pile__afficher__afficher_elements.8 (piles.adb:77)
==20652==    by 0x10BE2B: illustrer_affectation_pile__afficher.7 (piles.adb:83)
==20652==    by 0x10BA81: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:27)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Address 0x4ff9090 is 0 bytes inside a block of size 16 free'd
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA4D: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:25)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Block was alloc'd at
==20652==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BBEF: illustrer_affectation_pile__pile__empiler.3 (piles.adb:35)
==20652==    by 0x10B9DF: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:19)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==
B >
==20652== Invalid read of size 8
==20652==    at 0x10BCC4: illustrer_affectation_pile__pile__depiler.9 (piles.adb:47)
==20652==    by 0x10BA9E: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:30)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Address 0x4ff9098 is 8 bytes inside a block of size 16 free'd
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA4D: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:25)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Block was alloc'd at
==20652==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BBEF: illustrer_affectation_pile__pile__empiler.3 (piles.adb:35)
==20652==    by 0x10B9DF: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:19)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==
==20652== Invalid free() / delete / delete[] / realloc()
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA9E: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:30)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Address 0x4ff9090 is 0 bytes inside a block of size 16 free'd
==20652==    at 0x484620F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B194E8: __gnat_free (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BCDE: illustrer_affectation_pile__pile__depiler.9 (piles.adb:48)
==20652==    by 0x10BA4D: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:25)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==  Block was alloc'd at
==20652==    at 0x4843828: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==20652==    by 0x4B19481: __gnat_malloc (in /usr/lib/x86_64-linux-gnu/libgnat-12.so)
==20652==    by 0x10BBEF: illustrer_affectation_pile__pile__empiler.3 (piles.adb:35)
==20652==    by 0x10B9DF: _ada_illustrer_affectation_pile (illustrer_affectation_pile.adb:19)
==20652==    by 0x10B898: main (b~illustrer_affectation_pile.adb:244)
==20652==
==20652==
==20652== HEAP SUMMARY:
==20652==     in use at exit: 16 bytes in 1 blocks
==20652==   total heap usage: 2 allocs, 2 frees, 32 bytes allocated
==20652==
==20652== LEAK SUMMARY:
==20652==    definitely lost: 16 bytes in 1 blocks
==20652==    indirectly lost: 0 bytes in 0 blocks
==20652==      possibly lost: 0 bytes in 0 blocks
==20652==    still reachable: 0 bytes in 0 blocks
==20652==         suppressed: 0 bytes in 0 blocks
==20652== Rerun with --leak-check=full to see details of leaked memory
==20652==
==20652== For lists of detected and suppressed errors, rerun with: -s
==20652== ERROR SUMMARY: 5 errors from 5 contexts (suppressed: 0 from 0)
```

L'utilisation de `limited private` nous empêche d'attribuer une variable du type en question à une autre, ce qui résulte souvent en deux pointeurs pointant vers le même bloc mémoire. En somme, l'utilisation de `limited private` nous évite de faire cette erreur.


