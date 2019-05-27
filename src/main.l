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

^[ \t\n\r\f\v]*[{]  {
    // It matches if the input starts with a left brace (ignoring spaces).
    return FIRST_BRACE;
}
    
[{]  {return LEFT_BRACE;}

[}][ \t\n\r\f\v]*$  {
    // It matches if the input ends with a right brace (ignoring spaces).
    return LAST_BRACE;
}

[}]  {return RIGHT_BRACE;}

[\[] {return LEFT_BRACKET;}

[\]] {return RIGHT_BRACKET;}

[:] {return COLON;}

[,] {return COMMA;}

[[:space:]] {};

. {
    // If there is a invalid charactere, return ERROR for invalidate the JSON.
    return ERROR;
};


%%

int yywrap() {
  return 1;
}

