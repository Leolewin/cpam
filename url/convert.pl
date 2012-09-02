#!/usr/bin/perl


$filename = shift @ARGV;
open(FH,$filename) or die "Couldn't open $filename :$!\n";;

sub convert_sb
{
    local *FH = shift;
    my $lines;
    while(<FH>){
        # print $_;
        # converting 
        # from  ${SOURCE_DIR}/binutils-2.18/sb-db.xml.moto  
        # to    ${SOURCE_DIR}/binutils-2.18/binutils-2.18.sb
        if ($_ =~ m#(.*)(\/)(.*)(\/)(sb-db.xml.moto)#) 
         {
	  print  "$1"."$2"."$3/$3".".sb\n" ;
        }
        # from  ${SOURCE_DIR}/binutils-2.18/pb-db.xml.moto  
        # to    ${SOURCE_DIR}/binutils-2.18/binutils-2.18.sb
        elsif  ($_ =~ m#(.*)(\/)(.*)(\/)(pb-db.xml.moto)#)
        {
	     print  "$1"."$2"."$3/$3".".pb\n" ;
	} 
        else
        {
	    print $_;
	}
    }
}


sub convert_pb
{
    local *FH = shift;
    my $lines;
    while(<FH>){
        # print $_;
        # converting 
        # from  ${SOURCE_DIR}/binutils-2.18/pb-db.xml.moto  
        # to    ${SOURCE_DIR}/binutils-2.18/binutils-2.18.sb
        if  ($_ =~ m#(.*)(\/)(.*)(\/)(pb-db.xml.moto)#) {
	     print  "$1"."$2"."$3/$3".".pb\n" ;
	 } else{
	     print $_;
	 }

    }
}



sub write_line
{
    local *FH = shift;
    print FH @_;
}

convert_sb(*FH);
#convert_pb(*FH);


#write_line(*FH,"222\n");

close(FH);
