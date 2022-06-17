#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define PERCENT 100.0
#define READINGFRAME 2
main(int argc, char *argv[])
{
char *geneline;
char *sequence;
char aacode[20] = {'A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y'};
//char combination[400][2] = { 00 };;
char c;
int i,j,k,index,len;
int bool,totaldipep;
float dipepfreq;
char infile[50], outfile[50];
int dipepcount[400],proteincount = 0,processedcount = 0;
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

/*for(i = 0; i < 400; ++i)
        {
            for(j = 0; ( j < 20); j++);
            for(k = 0; ( k < 20); k++);
            //index = j * 20 + k;
            combination[i][0] = aacode[j];
	    combination[i][1] = aacode[k];
            printf("%d: %c%c\t",i,combination[i][0], combination[i][1]);
        }*/
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
	totaldipep = len - 1;
	for(i = 0; i < 400; ++i)
	dipepcount[i] = 0;
	processedcount++;
		for(i = 0; i < totaldipep; ++i)
		{
			for(j = 0; ((j < 20) && (sequence[i] != aacode[j])); ++j);
			for(k = 0; ((k < 20) && (sequence[i+1] != aacode[k])); ++k);
			index = j * 20 + k;
			dipepcount[index]++;
		}
		for(i = 0,j=0; i < 400; i++)
		{
			if  (i==1 || i==2 || i==5 || i==11 || i==12 || i==15 || i==20 || i==21 || i==22 || i==23 || i==24 || i==26 || i==27 || i==28 || i==30 || i==31 || i==32 || i==33 || i==34 || i==37 || i==38 || i==39 || i==41 || i==42 || i==45 || i==48 || i==50 || i==51 || i==52 || i==58 || i==59 || i==61 || i==64 || i==71 || i==78 || i==79 || i==80 || i==81 || i==82 || i==84 || i==87 || i==90 || i==92 || i==97 || i==99 || i==101 || i==102 || i==103 || i==105 || i==111 || i==112 || i==115 || i==118 || i==119 || i==121 || i==122 || i==123 || i==126 || i==131 || i==135 || i==137 || i==139 || i==142 || i==146 || i==152 || i==154 || i==157 || i==159 || i==161 || i==162 || i==172 || i==175 || i==176 || i==178 || i==179 || i==181 || i==191 || i==195 || i==196 || i==198 || i==205 || i==211 || i==212 || i==216 || i==221 || i==222 || i==223 || i==224 || i==226 || i==227 || i==228 || i==237 || i==240 || i==241 || i==242 || i==243 || i==244 || i==246 || i==247 || i==248 || i==250 || i==253 || i==257 || i==259 || i==261 || i==263 || i==264 || i==272 || i==273 || i==276 || i==283 || i==300 || i==301 || i==305 || i==306 || i==308 || i==309 || i==310 || i==312 || i==326 || i==328 || i==329 || i==330 || i==332 || i==333 || i==334 || i==341 || i==342 || i==344 || i==351 || i==352 || i==357 || i==361 || i==362 || i==363 || i==366 || i==367 || i==371 || i==372 || i==379 || i==381 || i==382 || i==383 || i==384 || i==385 || i==386 || i==388 || i==391 || i==392 || i==393 || i==395 || i==397 || i==399) continue;
			else
			{
			dipepfreq = dipepcount[i] * PERCENT/totaldipep/READINGFRAME;
			//array[i]= dipepfreq + array[i];
			if(dipepfreq>0)
			fprintf(f_write,"%d:%.8f\t",j+3674,dipepfreq);
			j++;
			}
		}
	fprintf(f_write,"\n");
	fseek(f_faa,-2L,1);
}

printf("\nTotal Proteins in %s : %d","NC_000964.faa",proteincount);
printf("\nTotal Proteins Processed (Proteins Without Sequence Ambiguity Like BJOUXZ): %d\n",processedcount);
fclose(f_faa);
fclose(f_write);
}
