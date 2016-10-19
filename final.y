%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern void yyerror(char *);
extern int yyparse(void);
extern FILE *yyin;
void Indentate();
char *Space;
char *Newline;
char *tab;
extern int counter;

%}

%union
{
	int	int_val;
	double 	double_val;
	char* str_val;
}

%token <str_val>INT ID OPENINGBRACKET OPENINGBRACE CLOSINGBRACE  CLOSINGBRACKET OPENINGPARENTHESIS CLOSINGPARENTHESIS EQ NE GT GE LT LE  PLUS MINUS STAR SLASH EQUAL COMMA DOUBLEAND DOUBLEOR SEMICOLON IF DOUBLE NUMBER ELSE WHILE DO RETURN BREAK CONTINUE HASH INCLUDE HEADER START FOR 


%type <str_val> block_st sts st assign if_st condition_op comparison_op addop mulop id program func  type_name parameter_list data_decls id_list condition_exp condition exp term factor func_decl single_st while_st return_st break_st continue_st headers function main do_st for_st assig
%start program

%%
	
	program:	headers main function		
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Newline)+1));
                               
				strcpy(s,$1); strcat(s, $2);strcat (s,$3); strcat(s,Newline);
                                $$=s; 
				printf("\n\nProgram \n%s", $$);
			}
			|headers main 		
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen(Newline)+1));
                               
				strcpy(s,$1); strcat(s, $2);strcat(s,Newline);
                                $$=s; 
				printf("\n\nProgram \n%s", $$);
			};
	main:		INT START OPENINGPARENTHESIS CLOSINGPARENTHESIS OPENINGBRACE sts return_st CLOSINGBRACE
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen($8)+strlen(Newline)+strlen(Newline)+strlen(tab)+strlen(Newline)+strlen(tab)+strlen(Space)+1));
                                strcpy(s,Newline);Indentate();strcat(s,$1); strcat(s,Space); strcat(s, $2); strcat(s, $3);strcat(s, $4);strcat(s,Newline);Indentate();strcat(s, $5);strcat(s, $6);strcat(s, $7); strcat(s,Newline);strcat(s, $8); 
                                $$=s;
			}
			|INT START OPENINGPARENTHESIS CLOSINGPARENTHESIS OPENINGBRACE return_st CLOSINGBRACE
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen(Newline)+strlen(Newline)+strlen(tab)+strlen(Newline)+strlen(tab)+strlen(Space)+1));
                                strcpy(s,Newline);Indentate();strcat(s,$1); strcat(s,Space); strcat(s, $2); strcat(s, $3);strcat(s, $4);strcat(s,Newline);Indentate();strcat(s, $5);strcat(s, $6); strcat(s,Newline);strcat(s, $7); 
                                $$=s;
			};
	headers: 	HASH INCLUDE HEADER 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Newline)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,$1); strcat(s, $2); strcat(s, $3); 
                                $$=s;
			}
			| HASH INCLUDE  HEADER headers
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen(Newline)+1));
                               	strcpy(s,Newline);Indentate(); strcat(s,tab);  strcat(s,$1); strcat(s, $2); strcat(s, $3); strcat(s, $4); 
                                $$=s; 
				
			};

			
	function : 	func 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                               	strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
				
			}
			|func function 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen(Newline)+strlen(tab)+1));
                             	strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1); strcat(s,$2);
                                $$=s;
			};
	
	func :	   	func_decl SEMICOLON  
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1); strcat(s,$2);
                                $$=s;
			}	
			| func_decl OPENINGBRACE sts return_st CLOSINGBRACE 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen(Newline)+strlen(tab)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,$1); strcat(s,Newline);Indentate(); strcat(s,tab);strcat(s,$2); strcat (s,$3);strcat (s,$4);strcat(s,Newline);Indentate(); strcat(s,tab);strcat (s,$5);
                                $$=s;
			}
			|func_decl OPENINGBRACE return_st CLOSINGBRACE 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen(Newline)+strlen(tab)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,$1); strcat(s,Newline);Indentate(); strcat(s,tab);strcat(s,$2); strcat (s,$3);strcat(s,Newline);Indentate(); strcat(s,tab);strcat (s,$4);
                                $$=s;
			};
	func_decl:	type_name ID OPENINGPARENTHESIS parameter_list CLOSINGPARENTHESIS 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1));
                                strcpy(s,$1); strcat(s,$2); strcat (s,$3); strcat (s,$4); 
				strcat (s,$5);
                                $$=s;
				
			}
			|type_name ID OPENINGPARENTHESIS CLOSINGPARENTHESIS 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1));
                                strcpy(s,$1); strcat(s,$2); strcat (s,$3); strcat (s,$4); 
                                $$=s;
				
			};
	type_name : 	INT 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Space)+1));
                                strcpy(s,$1);strcat(s,Space);
                                $$=s;
			} 
			| DOUBLE 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,Space);
                                $$=s;
			};

	parameter_list: type_name ID 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1); strcat(s,$2);
                                $$=s;
			}
			| parameter_list COMMA type_name ID 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1));
                                strcpy(s,$1); strcat(s,$2); strcat (s,$3); strcat (s,$4);
                                $$=s;
			};
			
	sts :		st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s;
				
			}
			| st sts 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1); strcat(s,$2);
                                $$=s;
				
			};
	st : 		data_decls 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 

			}
			| assign 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 

			}
			|if_st 
			{ 
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s;
			}
			| while_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s;
			}
			|do_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			
			| break_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			| continue_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			|for_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			};

			
	data_decls :	type_name id_list SEMICOLON 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+1));
                                strcpy(s,$1); strcat(s,$2);strcat (s,$3);
                                $$=s; 
			}

			| type_name id_list SEMICOLON data_decls 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen(tab)+strlen(Newline)+1));
                                strcpy(s,$1); strcat(s,$2);strcat (s,$3);strcat(s,Newline);Indentate(); strcat(s,tab);strcat (s,$4);
                                $$=s;
			};
	id_list:	id 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
			}
			| id_list COMMA id 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3);
                                $$=s; 
			};
	id : 		ID 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
			} 
			| ID OPENINGBRACKET exp CLOSINGBRACKET 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3);
                                $$=s;
			};
	assig :	id EQUAL exp 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,Space); strcat(s,$2);strcat(s, Space);strcat (s,$3);
                                $$=s;
			};			
	assign :	id EQUAL exp SEMICOLON 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,Space); strcat(s,$2);strcat(s, Space);strcat (s,$3); strcat (s,$4);
                                $$=s;
			};
	exp :		term
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s;
			} 
			| exp addop term 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s, $3);
                                $$=s;
			} ;
	term : 		factor
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s;
			} 
			| term mulop factor 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s, $3);
                                $$=s; 
			};
	factor : 	id
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s;
			}
			| NUMBER 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
				
			} ; 
	addop : 	PLUS 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s;
			} 
			| MINUS	
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s;
			};
	mulop :		STAR 	
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s;
			}
			| SLASH 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s;
			};

	block_st : 	 OPENINGBRACE sts CLOSINGBRACE 
			{
				
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab); strcat(s,$1); strcat(s,$2); strcat(s,Newline);Indentate(); strcat(s,tab); strcat (s,$3); 
                                $$=s; 
				
			}
			| OPENINGBRACE CLOSINGBRACE 
			{
				
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab); strcat(s,$1); strcat(s,Newline);Indentate(); strcat(s,tab); strcat (s,$2); 
                                $$=s; 
				
			}
			| single_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			};

	single_st :   assign 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 			}
			| if_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			| while_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			|do_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			| break_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}
			| continue_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			}			
			|for_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate(); strcat(s,tab);strcat(s,$1);
                                $$=s; 
			};



	if_st : 	IF OPENINGPARENTHESIS condition_exp CLOSINGPARENTHESIS block_st 
			{
				
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3); strcat(s,$4); strcat(s,$5);
                                $$=s;
				
			}
			| IF OPENINGPARENTHESIS condition_exp CLOSINGPARENTHESIS block_st ELSE block_st
			{
				
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3); strcat(s,$4); strcat(s,$5);strcat(s,Newline);Indentate(); strcat(s,tab);strcat(s,$6);strcat(s,$7);
                                $$=s;
				
			};
	for_st	:	FOR OPENINGPARENTHESIS assig SEMICOLON condition_exp SEMICOLON assig CLOSINGPARENTHESIS block_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen($8)+strlen($9)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3); strcat(s,$4);strcat(s,Space); strcat(s,$5);strcat(s,$6);strcat(s,Space);strcat(s,$7);strcat(s,$8);strcat(s,$9);
                                $$=s; 
				
			} ;
	while_st : 	WHILE OPENINGPARENTHESIS condition_exp CLOSINGPARENTHESIS block_st 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3); strcat(s,$4); strcat(s,$5);
                                $$=s; 
				
			} ;
	do_st : 	DO block_st WHILE OPENINGPARENTHESIS condition_exp CLOSINGPARENTHESIS SEMICOLON
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+1));
                                strcpy(s,$1); strcat(s,$2); strcat(s,$3); strcat(s,$4); strcat(s,$5); strcat(s,$6);strcat(s,$7);
                                $$=s; 
				
			} ;
	
	condition_exp :	condition 
			{	
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
			}
			| condition condition_op condition_exp 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,Space);strcat(s,$2);strcat(s,Space); strcat(s,$3);
                                $$=s;
			};
	condition : 	exp comparison_op exp 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1); strcat(s,Space);strcat(s,$2);strcat(s,Space); strcat(s,$3);
                                $$=s;
			}; 
	condition_op : 	DOUBLEAND 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen(Space)+strlen(Space)+1));
                                strcpy(s,$1);
                                $$=s;
			}
		       	| DOUBLEOR
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
			};

	comparison_op:	EQ 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			}
			| NE
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1);
                                $$=s; 
			} 
			| GT 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			}
			| GE
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			} 
			| LT
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			} 
			| LE 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+1));
                                strcpy(s,$1); 
                                $$=s; 
			};

	

	return_st :	RETURN exp SEMICOLON 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen($3)+strlen(Space)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate();strcat(s,tab);strcat(s,$1);strcat(s,Space); strcat(s,$2); strcat(s,$3);
                                $$=s; 
			}
			| RETURN SEMICOLON 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+strlen(Newline)+strlen(tab)+1));
                                strcpy(s,Newline);Indentate();strcat(s,tab);strcat(s,$1);strcat(s,$2);
                                $$=s; 
				
			} ;
	break_st : 	BREAK SEMICOLON 
			{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1);strcat(s,$2);
                                $$=s; 
				
			} ;
	continue_st :	CONTINUE SEMICOLON 
		{
				char* s=malloc(sizeof(char)*(strlen($1)+strlen($2)+1));
                                strcpy(s,$1); strcat(s,$2);
                                $$=s; 
				
		} ;
%%
void Indentate()
{
	int i;
	tab=malloc(10000);
	for(i=0;i<counter;i++)
	strcat(tab,"\t");
}

int main(int argc , char * argv[])
{
	Space=" ";
	Newline="\n";
	
	if(argc !=2)
	{
		printf("usage: filename\n");
		exit(0);
	}

	FILE *file=fopen(argv[1],"r");
	if(file==NULL)
	{
		printf("cannot open file %s\n",argv[1]);
		exit(0);
	}
	yyin=file;
	yyparse();

	fclose(file);
}
void yyerror(char *msg)
{
	printf("YACC : %s\n",msg);
}
