
%{
#include <stdlib.h>
void yyerror(char *);

#include "y.tab.h"

%}


%%

["] {return QUOTATION_MARKS;}

[a-zA-Z]+ {return LETTERS;}

[0-9]+[.][0-9]+ {return NUM;}

[0-9]+ {return NUM;}

^[ \t\n\r\f\v]*[{]  {return FIRST_BRACE;}
    
[{]  {return LEFT_BRACE;}

[}][ \t\n\r\f\v]*$  {return LAST_BRACE;}

[}]  {return RIGHT_BRACE;}

[\[] {return LEFT_BRACKET;}

[\]] {return RIGHT_BRACKET;}

[:] {return COLON;}

[,] {return COMMA;}

[[:space:]] {};

. {};


%%

int yywrap() {
  return 1;
}

