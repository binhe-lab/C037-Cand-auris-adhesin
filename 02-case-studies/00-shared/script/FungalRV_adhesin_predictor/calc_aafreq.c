#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
main(int argc, char *argv[])
{
char *geneline;
char *sequence;
char aacode[20] = {'A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y'};
char c;
int i,j,index,len;
int bool;
float aafreq,aacount[20];
char infile[50], outfile[50];
int proteincount = 0,processedcount = 0;
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
		strcpy(infile,argv[1]);
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
	geneline = malloc(0);
	i = 0;
		while(((c = getc(f_faa)) != '\n') && (c != '\r') && (c != '\f'))
		{
			geneline = realloc(geneline,++i);
			geneline[i - 1] = c;
		}
	geneline = realloc(geneline,++i);
	geneline[i - 1] = '\0';
	sequence = malloc(0);
	len = 0;
	bool = 1;
	proteincount++;
		while(((c = getc(f_faa)) != '>') && (c != EOF) && (bool))
		{
			if(!isalpha(c)) continue;
			if((c == 'B') || (c == 'J') || (c == 'O') || (c == 'U') || (c == 'X') || (c == 'Z'))
			bool = 0;
			sequence = realloc(sequence,++len);
			sequence[len-1] = c;
		}
		if(bool == 0)
		{
			fprintf(f_write,"Sequence ambiguity : %c Found in %s\nEntry Skipped\n",sequence[len - 1],geneline);
			continue;
		}
	for(i = 0; i < 20; ++i)
	aacount[i] = 0;
	processedcount++;
	for(i = 0; i < len; ++i)
		{
			for(j = 0; ((j < 20) && (sequence[i] != aacode[j])); ++j);
			index = j;
			aacount[index]++;
		}
//fprintf(f_write,"0\t");
		for(i = 0; i < 20; i++)
		{
			aafreq = (float)((aacount[i])/len);
			if(aafreq>0)
			fprintf(f_write,"%d:%.8f\t",i+3921,aafreq);
		}
	fprintf(f_write,"\n");
	fseek(f_faa,-2L,1);
}

printf("\nTotal Proteins in %s : %d","NC_000964.faa",proteincount);
printf("\nTotal Proteins Processed (Proteins Without Sequence Ambiguity Like BJOUXZ): %d\n",processedcount);
fclose(f_faa);
fclose(f_write);
}
