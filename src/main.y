%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *c);
int yylex(void);

int is_valid = 0;

%}
%token COMMA COLON QUOTATION_MARKS LEFT_BRACE RIGHT_BRACE FIRST_BRACE LAST_BRACE LEFT_BRACKET RIGHT_BRACKET NUM LETTERS ERROR

%%

// The input is a JSON valid if we have a FINAL_OBJECT.
VALID: FINAL_OBJECT {is_valid = 1;}

 /* A FINAL_0BJECT is defined by a left brace, one or more pairs
 and a right brace, in this order. And the left brace must be the first element 
 and the right brace the last, ignoring space. */
FINAL_OBJECT: 
    FIRST_BRACE SET_OF_PAIRS LAST_BRACE {}
    | FIRST_BRACE PAIR LAST_BRACE {};

/* A 0BJECT is defined by a left brace, one or more pairs
 and a right brace, in this order. */
OBJECT: 
    LEFT_BRACE SET_OF_PAIRS RIGHT_BRACE {}
    | LEFT_BRACE PAIR RIGHT_BRACE {};

// When we have pairs separated by commas
SET_OF_PAIRS: 
    PAIR COMMA PAIR {}
    | SET_OF_PAIRS COMMA PAIR {};
    
// Definition of a pair in a JSON
PAIR: 
    STRING COLON VALUE {};

// A value can be a string, a number (integer or floating), a object or a array.
VALUE: 
    STRING {}
    | NUM {}
    | OBJECT {}
    | ARRAY {};

/* A STRING is defined by every valid character between 
   its beginning and the next quotation marks. */
STRING: 
    STRING_START QUOTATION_MARKS {};

/* The STRING_START is a set which starts with the quotation 
   marks followed by a sequence of valid characters. In this case
   letters and numbers are valid. */
STRING_START: 
    QUOTATION_MARKS LETTERS {}
    | QUOTATION_MARKS NUM {}
    | STRING_START LETTERS {}
    | STRING_START NUM {};

/* A ARRAY is defined by a left bracket, zero or more VALUEs
   and a right bracket, in this order. */   
ARRAY: 
    LEFT_BRACKET COLLECTION_OF_VALUES RIGHT_BRACKET {}
    | LEFT_BRACKET VALUE RIGHT_BRACKET {}
    | LEFT_BRACKET RIGHT_BRACKET {};  

// A COLLECTION_OF_VALUES is a set of VALUEs separated by commas  
COLLECTION_OF_VALUES: 
    VALUE COMMA VALUE {}
    | COLLECTION_OF_VALUES  COMMA VALUE {};

%%

void yyerror(char *s) {
}

int main() {
    yyparse();
    if (is_valid) {
        printf("VALIDO\n");
    } else {
        printf("INVALIDO\n");
    }
    return 0;
}
