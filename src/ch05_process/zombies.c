/* This program illustrates how zombies are created, and how they
 * disappear again.  If you like, you can try killing some of the zombies.
 */

#include <sys/wait.h>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int
main(int argc, char **argv) {
	pid_t pid;
	int i;

	printf("Let's create some zombies!\n");

	for (i=0; i<10; i++) {
		if ((pid = fork()) < 0) {
			fprintf(stderr, "%s: fork error: %s\n",
					argv[0], strerror(errno));
			exit(1);
		}

		if (pid == 0) {
			/* Do nothing in the child, ie immediately exit.  This
			 * creates a zombie until the parent decides to wait for
			 * the child. */
			exit(0);
		} else {
			char ps_command[64];
			int ps_status;

			printf("====\n");
			snprintf(ps_command, sizeof(ps_command),
					"ps -o pid,ppid,stat,comm -p %ld", (long)pid);
			ps_status = system(ps_command);
			if (ps_status == -1) {
				perror("system");
				exit(EXIT_FAILURE);
			}
			if (!WIFEXITED(ps_status) || WEXITSTATUS(ps_status) != 0) {
				fprintf(stderr, "%s: ps command failed\n", argv[0]);
				exit(EXIT_FAILURE);
			}
			/* We don't wait for our children.  This allows
			 * them to become zombies.  We sleep for a short
			 * time to delay the next iteration of the loop.
			 * When the parent exits, init will reap the zombies. */
			sleep(2);
			/* We wait for every other child to show that
			 * zombies are reaped eventually if the parent
			 * waits. */
			if (i%2)
				wait(NULL);
		}
	}
	printf("That's enough zombies. Let's have init clean them up.\n");
	printf("Look for child processes marked Z in the output above.\n");
	exit(0);
}
