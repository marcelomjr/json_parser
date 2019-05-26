
%{
#include <stdlib.h>
void yyerror(char *);

#include "y.tab.h"

%}


%%

["][^\n]+["] { return STR;}

[0-9]+[.][0-9]+ { return NUM;}

[0-9] { return NUM;}

[{]  { return LEFT_BRACE;}

[}]  { return RIGHT_BRACE;}

[:] {return COLON;}

[,] { return COMMA;}


(null) {}

(false) {}

(true) {}

[:space:] {printf("Espaço\n");}

[.] {printf("ERROR\n");}



%%

int yywrap() {
  return 1;
}

