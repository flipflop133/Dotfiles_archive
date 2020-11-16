#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
  char command[50] = "curl -s \"wttr.in/Saint-Léger,Belgium?format=1\"";
  execl("/bin/bash", "bash", "-c", command, NULL);
  return 0;
}
