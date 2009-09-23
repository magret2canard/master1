#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#define PORT            5555
#define MESSAGE         "Yow!!! Are we having fun yet?!?"
#define SERVERHOST      "localhost"


void init_sockaddr (struct sockaddr_in *name,const char *hostname,uint16_t port){
  struct hostent *hostinfo;

  name->sin_family = AF_INET;
  name->sin_port = htons (port);
  hostinfo = gethostbyname (hostname);
  if (hostinfo == NULL){
      fprintf (stderr, "Unknown host %s.\n", hostname);
      exit (EXIT_FAILURE);
  }
  name->sin_addr = *(struct in_addr *) hostinfo->h_addr;
}


int main (void){
  int sock;
  struct sockaddr_in servername;

  /* Create the socket. */

  /* Connect to the server. */
  init_sockaddr (&servername, SERVERHOST, PORT);

  /* Send data to the server. */
  /* Close socket */
}


