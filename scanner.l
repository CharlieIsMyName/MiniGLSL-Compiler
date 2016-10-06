%{
/**********************************************************************
 *
 * **YOUR GROUP INFO SHOULD GO HERE**
 *
 *  Interface to the scanner module for CSC467 course project
 **********************************************************************/


#include "common.h"
#include "parser.tab.h"
#include "string.h"


#define YY_USER_INIT { yyin = inputFile; }
#define	yyinput      input
#define yTRACE(x)    { if (traceScanner) fprintf(traceFile, "TOKEN %3d : %s\n", x, yytext); }
#define yERROR(x)    { fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: %s\n", yyline, x); errorOccurred = TRUE; yyterminate(); }

int CheckInt(void);
int yyline = 1;

%}
%option noyywrap

WS          [ \t]
INT         [1-9][0-9]*

%%
"/*"        {
              int c1      = 0;
              int c2      = yyinput();
              int curline = yyline;
              for(;;) {
                if (c2 == EOF) {
                  fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: Unmatched /*\n", curline);
                  errorOccurred = TRUE;
                  yyterminate();
                }
                if (c1 == '*' && c2 == '/')
                  break;
                c1 = c2;
                c2 = yyinput();
                if (c1 == '\n' && c2 != EOF)
                  yyline++;
              }
            }

[ \t\r]

[\n]                                {yyline++;}                       

"int"|"float"|"bool"|([ib]?"vec"[2-4])      {yTRACE(TOK_KEYWORD_TYPE)}

"if"|"else"|"while"                 {yTRACE(TOK_KEYWORD_GRAMMAR)}

"const"                 {yTRACE(TOK_KEYWORD_MODIFIER)}

"+"|"-"|"*"|"/"|"="|"^"|"!"|">"|"<"|">="|"<="|"=="|"!="|"&&"|"||"   {yTRACE(TOK_OPERATOR)}

[0]|([1-9][0-9]*)                 {yTRACE(TOK_LIT_INT)}

(([0])|([1-9][0-9]*))"."[0-9]*          {yTRACE(TOK_LIT_FLOAT)}

"true"|"false"              {yTRACE(TOK_LIT_BOOL)}

"dp3"|"lit"|"rsq"           {yTRACE(TOK_FUNC)}

[_a-zA-Z][_a-zA-Z0-9]*       {yTRACE(TOK_IDENT)}

"{"                         {yTRACE(TOK_SCOPE_START)}
"}"                         {yTRACE(TOK_SCOPE_END)}
"["                         {yTRACE(TOK_REF_START)}
"]"                         {yTRACE(TOK_REF_END)}
"("                         {yTRACE(TOK_EXPR_START)}
")"                         {yTRACE(TOK_EXPR_END)}

";"                         {yTRACE(TOK_END_OF_STATEMENT)}

","                         {yTRACE(TOK_SEPERATE)}

.                           {yERROR("invalid token")}

%%