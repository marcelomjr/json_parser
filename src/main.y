

%{
#include <stdio.h>
  #include <stdlib.h>
void yyerror(char *c);
int yylex(void);



%}
%token COMMA COLON LEFT_BRACE RIGHT_BRACE NUM STR TRUE FALSE NULL EOF

%%

NAME_AND_COLON: STR COLON {
}

VALUE: 
    NUM
    | STR {}
    | OBJECT {}
    | ARRAY {}
    | TRUE {}
    | FALSE {}
    | NULL {};


PAIR: 
    NAME_AND_COLON VALUE {};
    
SET_OF_PAIRS:
    PAIR {}
    | SET_OF_PAIRS COMMA PAIR {};
    
OBJECT: LEFT_BRACE SET_OF_PAIRS RIGHT_BRACE {
};

COLLECTION_OF_VALUES: 
    VALUE COMMA VALUE {}
    | COLLECTION_OF_VALUES  COMMA VALUE {};
    
ARRAY: 
    LEFT_BRACE COLLECTION_OF_VALUES RIGHT_BRACE {}
    | LEFT_BRACE VALUE RIGHT_BRACE {}
    | LEFT_BRACE RIGHT_BRACE {};
    
       
%%

void yyerror(char *s) {
}

int main() {
    printf("executa\n");
    yyparse();
    return 0;

}
