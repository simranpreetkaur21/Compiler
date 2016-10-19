
%{
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"y.tab.h"
int yyparse(void);
extern YYSTYPE yylval;
int counter;
char *p;

%}


HEADER		<iostream.h>|<string.h> 
START		main
NUMBER		[0-9][0-9]*(.[0-9]+)?
ID		[a-zA-Z][a-zA-Z0-9]*


%% 
[ \t\n]		{}
"#"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return HASH;
		}	
"include"	{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return INCLUDE;}
{HEADER}	{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return HEADER;
		}	
{START}		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return START;
		}
";"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return SEMICOLON;
		}
int		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return INT;}
double		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return DOUBLE;
		}

if		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p;
			return IF;
		}
else		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return ELSE;}
while		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return WHILE;
		}
do		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return DO;
		}
for		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return FOR;
		}
return 		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return RETURN;
		}
continue	{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return CONTINUE;
		}
break		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return BREAK;
		}
"{"		{
			counter=counter+1;
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
                 	strcpy(p,yytext);
                 	yylval.str_val=p; 
			return OPENINGBRACE;
		}
"}"		{
			counter=counter-1;
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
                 	strcpy(p,yytext);
                 	yylval.str_val=p; 
			return CLOSINGBRACE;
		}
"["		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return OPENINGBRACKET;}
"]"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return CLOSINGBRACKET;}
"("		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return OPENINGPARENTHESIS;
		}		
")"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return CLOSINGPARENTHESIS;
		}
"*"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return STAR;
		}
"=="		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return EQ;
		}
"!="		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return NE;
		}
">"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return GT;
		}
">="		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return GE;
		}
"<"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return LT;
		}
"<="		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return LE;
		}
"+"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return PLUS;
		}
"-"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return MINUS;
		}
"/"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return SLASH;
		}
"="		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return EQUAL;
		}
","		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return COMMA;
		}
"&&"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return DOUBLEAND;
		}
"||"		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return DOUBLEOR;
		}
{NUMBER}	{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return NUMBER;
		}   
{ID} 		{
			p=(char *)calloc(strlen(yytext)+1,sizeof(char));
		        strcpy(p,yytext);
		        yylval.str_val=p; 
			return ID;
		}


%%


/*
void yyerror(char *str)
{
	printf("Parse Error: %s\n",str);
}
*/
int yywrap(void) {
counter = 0;
    return 1;
}


