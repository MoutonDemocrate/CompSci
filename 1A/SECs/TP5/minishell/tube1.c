#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
    char buffer[100];

    int tube[2];
    char message[] = "JE TE PIPE OU QUOI LÀ!?";

    int fils = fork();
    // bonne pratique : tester systématiquement le retour des primitives
    if (fils == -1)
    {
        printf("Erreur fils\n");
        exit(1);
    }
    if (fils == 0)
    { /* fils */
        close(tube[1]);
        read(tube[0], buffer, 100);
        printf("%s", buffer);
        exit(EXIT_SUCCESS);
        /* 	bonne pratique :
            terminer les processus par un exit explicite */
    }
    else
    { /* père */
        if (pipe(tube) == -1)
        {
            printf("Tu n'es PAS PIPE ???");
            exit(1);
        }
        close(tube[0]);
        write(tube[1], message, sizeof(message));
    }
    return 0;
}
