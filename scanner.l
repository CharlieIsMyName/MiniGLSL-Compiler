%{
/**********************************************************************
 *
 * **YOUR GROUP INFO SHOULD GO HERE**
 * GROUP NUMBER g467-007
 * GROUP MEMBER:
 *               Chenyu Wang    wangc148    1001609226
 *               Jixiong Deng   dengjixi    1001304741
 *
 *  Interface to the scanner module for CSC467 course project
 **********************************************************************/


#include "common.h"
#include "parser.tab.h"
#include "string.h"


#define YY_USER_INIT { yyin = inputFile; }
#define	yyinput      input
#define yTRACE(x)    {  printLex(x); }
#define yERROR(x)    { fprintf(errorFile, "\nLEXICAL ERROR AT TOKEN %s, LINE %d: %s\n", yytext, yyline, x); errorOccurred = TRUE; yyterminate(); }

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



 /*this line returns key word type*/
"int"|"float"|"bool"|([ib]?"vec"[2-4])      {yTRACE(TOK_KEYWORD_TYPE)}


 /*this line returns loop and if statement*/ 
"if"|"else"|"while"                 {yTRACE(TOK_KEYWORD_GRAMMAR)}


 /*this line returns constant type*/
"const"                 {yTRACE(TOK_KEYWORD_QUALIFIER)}


 /*this line returns operator*/ 
"+"|"-"|"*"|"/"|"="|"^"|"!"|">"|"<"|">="|"<="|"=="|"!="|"&&"|"||"   {yTRACE(TOK_OPERATOR)}


 /*this line returns integers*/
"-"?[0]|("-"?[1-9][0-9]*)               	{
							long int value=strtol(yytext,NULL,10);
							if((errno==ERANGE)||((short)value!=value)){
								yERROR("Invalid integer literal. The value might be out of range.");	
							}
							yTRACE(TOK_LIT_INT);
						}


 /*this line returns real numbers*/ 
(("-"?[0])|("-"?[1-9][0-9]*))"."[0-9][0-9]*          {
							float fvalue=strtof(yytext,NULL);
							if((errno==ERANGE)){
								yERROR("Invalid floating point literal. The value might be out of range.");	
							}
							yTRACE(TOK_LIT_FLOAT);
						}


 /*this line returns boolean type "true" will be 1 "false" will be 0*/
"true"|"false"              {yTRACE(TOK_LIT_BOOL)}


 /*this line returns function types*/ 
"dp3"|"lit"|"rsq"           {yTRACE(TOK_FUNC)}


 /*this line returns literal strings*/
 /*like "my_type" "_type" etc.*/ 
[_a-zA-Z][_a-zA-Z0-9]*       			{
							if(strlen(yytext)>MAX_IDENTIFIER){
								yERROR("Identifier name exceeds maximum allowed length");
								break;
							}
							yTRACE(TOK_IDENT);
						}

 /*the following lines returns scope signs*/ 
"{"                         {yTRACE(TOK_SCOPE_START)}
"}"                         {yTRACE(TOK_SCOPE_END)}
"["                         {yTRACE(TOK_REF_START)}
"]"                         {yTRACE(TOK_REF_END)}
"("                         {yTRACE(TOK_EXPR_START)}
")"                         {yTRACE(TOK_EXPR_END)}
";"                         {yTRACE(TOK_END_OF_STATEMENT)}
","                         {yTRACE(TOK_SEPERATE)}


 /*the following lines define invalid identifiers*/ 
 /*integers like "00" "01" are invalid in this case*/ 
0[0-9][0-9]*                {yERROR("Invalid token")}

 /*numbers like "0." "1." "3_" are invalid in this case*/ 
[0-9][0-9]*[._][._]*        {yERROR("Invalid token")}

 /*strings like "lol4.78" "lol.stupid" etc. are invalid in this case*/
[_a-zA-Z][_a-zA-Z0-9]*[.][._a-zA-Z0-9]* {yERROR("Invalid token")}

 /*strings like "1my_identifier0123" "3.0_thisIDT" etc. are invalid in this case*/ 
("-"?[0]|("-"?[1-9][0-9]*))([.]*[0-9]*[_a-zA-Z][._a-zA-Z0-9]*)  {yERROR("Invalid token")}

.                           {yERROR("Invalid token")}

%%


void printLex(int x){
	if (traceScanner){
	
		switch(x){
			case TOK_KEYWORD_TYPE:
				fprintf(traceFile, "TOKEN TOK_KEYWORD_TYPE : %s\n", yytext);
				break;
			case TOK_KEYWORD_GRAMMAR:
				fprintf(traceFile, "TOKEN TOK_KEYWORD_GRAMMAR : %s\n", yytext);
				break;
			case TOK_KEYWORD_QUALIFIER:
				fprintf(traceFile, "TOKEN TOK_KEYWORD_QUALIFIER : %s\n", yytext);
				break;
			case TOK_OPERATOR:
				fprintf(traceFile, "TOKEN TOK_OPERATOR : %s\n", yytext);
				break;
			case TOK_LIT_INT:{
				long int value=strtol(yytext,NULL,10);
				fprintf(traceFile, "TOKEN TOK_LIT_INT : %s with value of %d\n", yytext,(short)value);
				break;
			}
				
			case TOK_LIT_FLOAT:{
				float fvalue=strtof(yytext,NULL);
				fprintf(traceFile, "TOKEN TOK_LIT_FLOAT : %s with actual value of %f\n", yytext,fvalue);
				break;
			}
				
			case TOK_LIT_BOOL:
				fprintf(traceFile, "TOKEN TOK_LIT_BOOL : %s\n", yytext);
				break;
			case TOK_FUNC:
				fprintf(traceFile, "TOKEN TOK_FUNC : %s\n", yytext);
				break;
			case TOK_IDENT:
				fprintf(traceFile, "TOKEN TOK_IDENT : %s\n", yytext);
				break;
			case TOK_SCOPE_START:
				fprintf(traceFile, "TOKEN TOK_SCOPE_START : %s\n", yytext);
				break;
			case TOK_SCOPE_END:
				fprintf(traceFile, "TOKEN TOK_SCOPE_END : %s\n", yytext);
				break;
			case TOK_REF_START:
				fprintf(traceFile, "TOKEN TOK_REF_START : %s\n", yytext);
				break;
			case TOK_REF_END:
				fprintf(traceFile, "TOKEN TOK_REF_END : %s\n", yytext);
				break;
			case TOK_EXPR_START:
				fprintf(traceFile, "TOKEN TOK_EXPR_START : %s\n", yytext);
				break;
			case TOK_EXPR_END:
				fprintf(traceFile, "TOKEN TOK_EXPR_END : %s\n", yytext);
				break;
			case TOK_END_OF_STATEMENT:
				fprintf(traceFile, "TOKEN TOK_END_OF_STATEMENT : %s\n", yytext);
				break;
			case TOK_SEPERATE:
				fprintf(traceFile, "TOKEN TOK_SEPERATE : %s\n", yytext);
				break;

		}

	
	}

}
