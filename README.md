### CS 220 – Theory of Computation – Spring 2012

Modify the  example.l and  example.y files  which were  discussed in lecture
(and are posted on the Blackboard website) to  instead recognize the tokens and
grammar specified below.

### Tokens

Token *ident* is the same as a valid identifier in C++ (i.e., must start with a
letter or underscore, followed by any number of letters, digits, and/or
underscores).

Token *intconst* is the same as a positive or negative (or unsigned) integer
constant that would be valid in C++. Don’t worry about a size limit on integer
constants.

The only *keyword* tokens are the following: `let`, `if`, `defun`

The only *operator* tokens are the following: `+`, `-`, `*`, `/`

This language **uses parentheses**, so you need to recognize tokens `(` and `)`

The language is **case-sensitive**, so those keywords must be in lowercase.
Otherwise, they should be recognized as identifiers.



###Grammar

    EXPR → intconst | ident | ( PAREN_EXPR )
    PAREN_EXPR →  ARITH_EXPR | IF_EXPR | LET_EXPR | DEFUN_EXPR | EXPR_LIST
    ARITH_EXPR →  OP  EXPR  EXPR
    IF_EXPR →  if  EXPR  EXPR  EXPR
    LET_EXPR →  let ( ID_EXPR_LIST ) EXPR
    ID_EXPR_LIST →  λ | ID_EXPR_LIST ( ident EXPR )
    DEFUN_EXPR →  defun (  ID_LIST ) EXPR
    ID_LIST →  λ | ID_LIST ident
    EXPR_LIST →  EXPR EXPR_LIST | EXPR
    OP →  + | - | * | /


Note: The nonterminals in this grammar are in all uppercase (e.g., EXPR)