#include <stdio.h>
#include <stdlib.h>
#include "readcmd.h"
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

int pid_fg;
int nbcmd = 0;
void treat_all(int numsign)
{
    int status;
    int pid = waitpid(-1, &status, WNOHANG);
    if (WIFEXITED(status))
    {
        printf("\n(Processus n°%d manually terminated)\n", pid);
        pid_fg = 0;
    }
    else if (WIFSIGNALED(status))
    {
    }
    else if (WIFSTOPPED(status))
    {
    }
    else if (WIFCONTINUED(status))
    {
    }
    else
    {
        pid_fg = 0;
        printf("%d done\n", pid_fg);
    }
}
void treat_c(int numsign)
{
    if (pid_fg == 0)
    {
        printf("\n(No process to kill...).\n");
    }
    else
    {
        printf("\n(Processus n°%d terminated)\n", pid_fg);
        kill(pid_fg, SIGKILL);
        pid_fg = 0;
    }
}
void treat_z(int numsign)
{
    printf("\n(Processus n°%d manually terminated)\n", pid_fg);
    kill(pid_fg, SIGSTOP);
    pid_fg = 0;
}

int main(void)
{

    struct sigaction action;
    action.sa_handler = treat_all;
    sigemptyset(&action.sa_mask);
    action.sa_flags = SA_RESTART;
    sigaction(SIGCHLD, &action, NULL);

    struct sigaction actionc;
    actionc.sa_handler = treat_c;
    sigemptyset(&actionc.sa_mask);
    actionc.sa_flags = SA_RESTART;
    sigaction(SIGINT, &actionc, NULL);

    struct sigaction actionz;
    actionz.sa_handler = treat_z;
    sigemptyset(&actionz.sa_mask);
    actionz.sa_flags = SA_RESTART;
    sigaction(SIGTSTP, &actionz, NULL);

    bool fini = false;

    while (!fini)
    {
        printf("> ");
        struct cmdline *commande = readcmd();

        if (commande == NULL)
        {
            // commande == NULL -> erreur readcmd()
            perror("ERROR : Wrong command.\n");
            exit(EXIT_FAILURE);
        }
        else
        {

            if (commande->err)
            {
                // commande->err != NULL -> commande->seq == NULL
                printf("ERROR : invalid command : %s\n", commande->err);
            }
            else
            {

                int indexseq = 0;
                char **cmd;
                int tubeIN[2];
                int tubeOUT[2];
                char buffer[1024];
                while ((cmd = commande->seq[indexseq]))
                {
                    if (cmd[0])
                    {
                        if (strcmp(cmd[0], "exit") == 0)
                        {
                            fini = true;
                            printf("See ya ...\n");
                        }
                        else
                        {
                            printf("Command : ");
                            int indexcmd = 0;
                            while (cmd[indexcmd])
                            {
                                printf("%s ", cmd[indexcmd]);
                                indexcmd++;
                            }
                            printf("\n");
                            int retour = fork();
                            if (retour == -1)
                            {
                            }
                            else if (retour == 0)
                            {
                                setpgrp();
                                if ((commande->seq[indexseq - 1]) && (commande->seq[indexseq - 1][0]))
                                {
                                    printf("PIPE_IN");
                                    close(tubeIN[1]);
                                    dup2(tubeIN[0], 0);
                                    close(tubeIN[0]);
                                }
                                if ((commande->seq[indexseq + 1]) && (commande->seq[indexseq + 1][0]))
                                {
                                    printf("PIPE_OUT");
                                    close(tubeOUT[0]);
                                    dup2(tubeOUT[1], 1);
                                    close(tubeOUT[1]);
                                }
                                if (commande->in != NULL)
                                {
                                    int file = open(commande->in, O_RDONLY);
                                    dup2(file, 0);
                                    close(file);
                                }
                                if (commande->out != NULL)
                                {
                                    int file = open(commande->out, O_WRONLY | O_CREAT | O_TRUNC, 0666);
                                    dup2(file, 1);
                                    close(file);
                                }
                                execvp(cmd[0], cmd);
                            }
                            else
                            {
                                sigaction(SIGINT, &actionc, NULL);
                                sigaction(SIGTSTP, &actionz, NULL);
                                sigaction(SIGCHLD, &action, NULL);
                                if (commande->backgrounded != NULL)
                                { // si la commande est en background
                                    nbcmd++;
                                    printf("[%d] %d\n", nbcmd, retour);
                                }
                                else
                                {
                                    pid_fg = retour;
                                    while (pid_fg != 0)
                                    {
                                        pause();
                                    }
                                }
                            }
                            {
                                tubeOUT[1] = tubeIN[0];
                            }
                        }

                        indexseq++;
                    }
                }
            }
        }
    }
    return EXIT_SUCCESS;
}