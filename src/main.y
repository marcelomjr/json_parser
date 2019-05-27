

%{
#include <stdio.h>
  #include <stdlib.h>
void yyerror(char *c);
int yylex(void);

int is_valid = 0;

%}
%token COMMA COLON LEFT_BRACE RIGHT_BRACE FIRST_BRACE LAST_BRACE NUM TRUE FALSE QUOTATION_MARKS LETTERS LEFT_BRACKET RIGHT_BRACKET

%%

VALID: FINAL_OBJECT {is_valid = 1;}
  
FINAL_OBJECT: 
    FIRST_BRACE SET_OF_PAIRS LAST_BRACE {

    }
    | FIRST_BRACE PAIR LAST_BRACE {

    };

OBJECT: 
    LEFT_BRACE SET_OF_PAIRS RIGHT_BRACE {

    }
    | LEFT_BRACE PAIR RIGHT_BRACE {

    };


SET_OF_PAIRS: 
    PAIR COMMA PAIR {

    }
    | SET_OF_PAIRS COMMA PAIR {

    };
    

PAIR: 
    STRING COLON VALUE {

    };


VALUE: 
    STRING {

    }
    | NUM {

    }
    | OBJECT {

    }
    | ARRAY {

    };
    
STRING: 
    STRING_START QUOTATION_MARKS {

    };


STRING_START: 
    QUOTATION_MARKS LETTERS {
      
    }
    | QUOTATION_MARKS NUM {
      
    }
    | STRING_START LETTERS {
      
    }
    | STRING_START NUM{
      
    };
    


    
ARRAY: 
    LEFT_BRACKET COLLECTION_OF_ELEMENTS RIGHT_BRACKET {}
    | LEFT_BRACKET ARRAY_ELEMENT RIGHT_BRACKET {};  
    
COLLECTION_OF_ELEMENTS: 
    ARRAY_ELEMENT COMMA ARRAY_ELEMENT {
        
    }
    | COLLECTION_OF_ELEMENTS  COMMA ARRAY_ELEMENT {

    };
    
ARRAY_ELEMENT:
    VALUE {

    }
    | LEFT_BRACKET RIGHT_BRACKET {

    };
%%

void yyerror(char *s) {
}

int main() {
    yyparse();
    if (is_valid) {
        printf("VALIDO\n");
    }
    else {
        printf("INVALIDO\n");
    }
    return 0;

}
