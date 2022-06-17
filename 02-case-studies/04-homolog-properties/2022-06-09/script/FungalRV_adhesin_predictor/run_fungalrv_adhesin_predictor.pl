use strict;
use warnings;
my $filename = '';
my $fileout='';
my $seqfile='';
my $m='';
my @arr=();
my $file='';
my $i=0;
my @err=();
my %hash=();
my $ans='';
my @head=();
my @arr_model=();
my @arr_model2=();
my @arr_model3=();

print "Enter the input file name\n";
$filename=<STDIN>;
chomp $filename;
print "Enter the Output File name\n";
$fileout=<STDIN>;
chomp $fileout;
print "Run on Human pathogenic fungi?(answer in yes/y or no/n )";
$ans=<STDIN>;
chomp $ans;
print $ans;
my $start=time();
open(FH,"<$filename") or die "failed to open file because of $!";
@arr = <FH>;
close FH;
$file = join('', @arr);
open(FI,">header_$filename") or die "failed to open file because of $!";
open(ER, ">ambiguous_seq") or die "failed to open file because of $!";
open(FO, ">seqfile") or die "failed to open file because of $!";
while($file =~ /^>.*\n(^(?!>).*\n)+/gm)
{
  my $giseq = '';
  my $header = '';
  my $seq = '';
  my $p=0;
  my @q=();
  my @seqarr= ();
  $giseq = $&;
  $giseq =~ s/\*//gm;
  $giseq =~ /^>.*\n/;
  $header = $&;
  $seq = $';#'
  print FI "$header";
  $seq =~ s/\s//gm;
  $seq =~ s/\n//gm;
       	
       	if($seq =~ /B|J|O|U|X|Z/)
	{
        print ER "$giseq\n";
        $hash{$i} = 1;
       	next;
        #Here u can make error sequence file
      	}
	else
        {print FO "$giseq";}	
  $i++;
  	
}
close FO;
close ER;
close FI;
system("./calc_dipep_freq $filename dipep_out");
system("./calc_tripep_freq $filename tripep_out");
system("./calc_multiplets $filename mult_out");
system("./calc_hdr_comp $filename hdr_out");
system("./calc_aafreq $filename aafreq_out");
#system("perl mix_all.pl");
open (FA,"<aafreq_out") or die "Unable to open $!";
my @arra=<FA>;
open (FD,"<dipep_out") or die "Unable to open $!";
my @arrd=<FD>;
open (FT,"<tripep_out") or die "Unable to open $!";
my @arrt=<FT>;
open (FM,"<mult_out") or die "Unable to open $!";
my @array=<FM>;
open (FH,"<hdr_out") or die "Unable to open $!";
my @arrh=<FH>;
open (FF, ">all.dat") or die "Unable to open $!";
my $line='';
my $r=0;
foreach $line(@array)
{
chomp $line;
print FF "$line";
chomp $arrt[$r];
print FF "$arrt[$r]";
chomp $arrd[$r];
print FF "$arrd[$r]";
chomp $arra[$r];
print FF "$arra[$r]";
print FF "$arrh[$r]";
$r++;
}
close FD;
close FM;
close FH;
close FT;
close FA;
close FF;
if($ans=~/n|no/)
{
system("./svm_classify all.dat Model26a Model_result26a");
system("./svm_classify all.dat Model470b Model_result470b");
system("./svm_classify all.dat Model6c Model_result6c");
open(FI,"<header_$filename") or die "failed to open because $!\n";
@head=<FI>;
#print "ENTER THE MODEL NUMBER YOU SELECT (492 616)\n";
open(FM1,"<Model_result26a") or die "failed to open file because of $!\n";
open(FM2,"<Model_result470b") or die "failed to open file because of $!\n";
open(FM3,"<Model_result6c") or die "failed to open file because of $!\n";
@arr_model=<FM1>;
@arr_model2=<FM2>;
@arr_model3=<FM3>;
close FM1;
close FM2;
close FM3;
}
else
{
system("./svm_classify all.dat Model470a Model_result470a");
system("./svm_classify all.dat Model470b Model_result470b");
system("./svm_classify all.dat Model449c Model_result449c");
open(FI,"<header_$filename") or die "failed to open because $!\n";
@head=<FI>;
#print "ENTER THE MODEL NUMBER YOU SELECT (492 616)\n";
open(FM1,"<Model_result470a") or die "failed to open file because of $!\n";
open(FM2,"<Model_result470b") or die "failed to open file because of $!\n";
open(FM3,"<Model_result449c") or die "failed to open file because of $!\n";
@arr_model=<FM1>;
@arr_model2=<FM2>;
@arr_model3=<FM3>;
close FM1;
close FM2;
close FM3;
}
open(OUT,">$fileout") or die "failed to open file because of $!\n";
my $d='';
my $h=0;
my $e=0;
print OUT "FungalRv adhesin Predictor Output\n";
print OUT "Input File: $filename\n\n";
foreach $d(@head)
  {
     chomp $d;
     if(exists $hash{$e})
      {
      print OUT "$d\tSequence Ambiguity\n";
      }
      else
      {
      my $score=max($arr_model[$h],$arr_model2[$h],$arr_model3[$h]);
      print OUT "$d\t$score";
      $h++;
      } 
     $e++;
  }
close OUT;
close FI;
sub max {
    my($max) = shift(@_);
    foreach my $temp (@_)
    {
    $max = $temp if $temp > $max;
    }
    return($max);
}
system("rm header_$filename");
system("rm aafreq_out");
system("rm dipep_out");
system("rm tripep_out");
system("rm mult_out");
system("rm hdr_out");
system("rm all.dat");
system("rm Model_result470b");
if($ans=~/no|n/)
{
system("rm Model_result26a");
system("rm Model_result6c");
}
else
{
system("rm Model_result470a");
system("rm Model_result449c");
}
system("rm ambiguous_seq");
system("rm seqfile");
my $end= time();
print "time taken to execute :\t",($end-$start),"seconds\n";
exit;

