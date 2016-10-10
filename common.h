/***********************************************************************
 * **YOUR GROUP INFO SHOULD GO HERE**
 * GROUP NUMBER g467-007
 * GROUP MEMBER:
 *               Chenyu Wang    wangc148    1001609226
 *               Jixiong Deng   dengjixi    1001304741
 * common.h
 *
 * common definitions that are used throughout the compiler.
 **********************************************************************/

#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdio.h> /* for FILE */
#include <stdlib.h>
#include <string.h>
#include <errno.h>

/**********************************************************************
 * Some useful definitions. These may be modified or removed as needed.
 *********************************************************************/
#ifndef TRUE
# define TRUE  1
#endif
#ifndef FALSE
# define FALSE 0
#endif

#define MAX_IDENTIFIER 32
#define MAX_TEXT       256
#define MAX_INTEGER    32767
//for now the floating point we allow is double precision

/**********************************************************************
 * External declarations for variables declared in globalvars.c.
 **********************************************************************/
extern FILE * inputFile;
extern FILE * outputFile;
extern FILE * errorFile;
extern FILE * dumpFile;
extern FILE * traceFile;
extern FILE * runInputFile;

extern int errorOccurred;
extern int suppressExecution;

extern int traceScanner;
extern int traceParser;
extern int traceExecution;

extern int dumpSource;
extern int dumpAST;
extern int dumpSymbols;
extern int dumpInstructions;

void printLex(int x);



#endif

