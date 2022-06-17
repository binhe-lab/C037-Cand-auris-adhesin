#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define PERCENT 100.0
#define READINGFRAME 2
#define VALID '1'
#define MAX_R_ORDER 5
#define MAX_PROT_LEN 11000
#define MAX_ANNOTATION 1000

main(int argc, char *argv[])
{
char geneline[1000]={'\0'};
char sequence[MAX_PROT_LEN]={'\0'};
char aacode[8] = {'A','C','L','V','I','F','M'};//kyte doolittle scale
char c;
int i,j,k,index,len,bool,prot_len;
char infile[50], outfile[50]; //arr size=50 for max len of file_name
int proteincount = 0,processedcount = 0;
int N=0,Xi=0;
float Xm=0,Fc=0;
double Mr[MAX_R_ORDER]={0.0};
double result,factor=0;
FILE *f_faa,*f_write;
if(argc!=3)
	{
		if(argc!=2)
		{
			printf("Enter the inputfile: ");
			scanf("%s",infile);
		}
		else

			strcpy(infile,argv[1]);
		printf("Enter the outputfile: ");
		scanf("%s",outfile);
	}
	else
	{
		/* Read the input file name */
		strcpy(infile,argv[1]);
		/* Read the output file name */
		strcpy(outfile,argv[2]);
	}
	//printf("Enter the outputfilename: ");
	//scanf("%s",outputfile);

	f_faa=fopen(infile,"r");
	if(f_faa==NULL)
	{
		printf("File %s not found.\n",infile);
		exit(3);
	}

	f_write=fopen(outfile,"w");
	if(f_write==NULL)
	{
		printf("Cannot open file %s to write.\n",outfile);
		exit(4);
	}
	while((c = getc(f_faa)) != EOF)
	{
		if(c != '>') continue;
		i = 0;
		while(((c = getc(f_faa)) != '\n') && (c != '\r') && (c != '\f'))
		{
			geneline[i] = c;
			i++;
		}
		len = 0;
		prot_len =0;
		bool = 1;
		proteincount++;
		while(((c = getc(f_faa)) != '>') && (c != EOF) && (bool))
		{
			if(!isalpha(c)) continue;
			if((c == 'B') || (c == 'J') || (c == 'O') || (c == 'U') || (c == 'X') || (c == 'Z'))
			{
			  /* invalid sequence found */
			  bool = 0;
			  break;
			}
			sequence[len++] = c;
		}
		if(bool == 0)
		{
			fprintf(f_write,"Sequence ambiguity : %c Found in %s\nEntry Skipped\n",sequence[len],geneline);
			continue;
		}
		prot_len = len;
		processedcount++;
		for(i = 1; i <MAX_R_ORDER; i++)
		{
			Mr[i-1] = 0;
		}
		Xi=0;
		N=0;
		result=0;
		factor=0;
		
		for(i = 0; i < prot_len; i++)
		{
			
			for(j=0; j < 7; j++)
			{
				if (sequence[i] == aacode[j])
				{
					Xi = Xi + i + 1; //summation of pos of the i'th amino acid
					sequence[i] = VALID;
					N++; //increment the num of charged amino acids
					break;
				}
			}
		}

		Xm = (float)Xi/N;
		Fc = (float)N/prot_len;
		/* Calculate Mr value */
		for(i = 1; i < MAX_R_ORDER; i++)
		{
			for (j = 0; j < prot_len; j++)
	  		{
				if(sequence[j] == VALID)
				{
				result = pow(((double)((j+1) - Xm)),(i+1));
				//printf("%lf\n",result);
				factor= pow(1000,i+1);
				Mr[i-1]+=(double)(((double)result/N)/factor);/*standardizing values to decimals*/
				//printf("%lf\n",Mr[i-1]);
				}
			}
		}
		for(i = 1; i < MAX_R_ORDER; i++)
		{
		//if(Mr[i-1]>.5)
		fprintf(f_write,"%d:%lf\t",3940+i,Mr[i-1]);
		}
		fprintf(f_write,"%d:%f\t",3945,Fc);
		
	fprintf(f_write,"\n");
	fseek(f_faa,-2L,1);
	}
printf("\nTotal Proteins in %s : %d","NC_000964.faa",proteincount);
printf("\nTotal Proteins Processed (Proteins Without Sequence Ambiguity Like BJOUXZ): %d\n",processedcount);
fclose(f_faa);
fclose(f_write);
}
