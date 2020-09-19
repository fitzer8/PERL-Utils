######################################################
# NAME: Utils.pm
# FUNC: Miscellaneous utility subroutines.
# AUTH: Fitz
#  VER: 0.0.0
#  SRC: /home/fitz/src/perl/libs/Utils/Utils.pm
#======================================================
# HISTORY
#======================================================
#   DATE   # NAME               # COMMENT
#======================================================
# 20200916 # Fitz               # Original.
#######################################################
#sub chop_blanks {
#sub clear
#sub get_printable {
#sub remove_external_whitespace(\$)
#sub GetLtrFromString {
#sub YMDHMS {
#sub GetYMDHMS {
#sub Logger {
#sub Ask_Y_N {
#sub print8bits {
#sub Unsplit {
#sub Split {
#sub lo {
#sub hi {
#sub get_char {
## sub file_select
## sub sel
#sub leftright {
#sub get_token {
#sub skip_white {
#sub Debug_Number {
#sub Debug_String {
#sub Debug_Quoted_Char {
#sub Debug_2Hex {
#sub get_2bytes {
#sub Lbyte {
#sub Lword {
#sub Lstring {
#sub Dstring {
#sub Debug_4Hex {
#sub byte_to_string {
#sub byte_to_char {
#sub newAsk_Y_N {
#sub rtrim {
#sub ltrim {
#sub bin2dec {
#sub dec2bin {
##sub nextCH(\$)
#sub nextCH
#sub prompt {
#sub prompt_yn {
#sub UtilsTest {
#sub trim {
#sub StrToBin {
#sub PromptUser {
#sub printable_char {
#sub Pause {
#######################################################
use IO::Handle ();

#$HOME = $ENV{'HOME'};
#$USER = $ENV{'USER'};
#

require "/home/fitz/src/perl/libs/Common/Common.pm";
require "/home/fitz/src/perl/libs/Debug/Debug.pm";


my $File = "Utils.pm";
my $Proc = "Main";
my $DBG = 0;
if( $DBG ) {
	ntry( $File, $Proc );
}

#####################################################
# Globals
#
#$TRUE = 1;
#$FALSE = 0;

#######################################################
# Define common variables.
#
#local $str = shift @_;

$TIMES{ "M1" } = 60;
$TIMES{ "M5" } = 60*5;
$TIMES{ "M15" } = 60*15;
$TIMES{ "M30" } = 60*30;
$TIMES{ "H1" } = 60*60;
$TIMES{ "H4" } = 60*60*4;
$TIMES{ "D1" } = 60*60*24;
$TIMES{ "D2" } = 60*60*24*2;

@months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
@days = qw( Sun Mon Tue Wed Thu Fri Sat );
$NOW = time;

( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( time );
$year += 1900;

$logdir = "/u/psrd/users/pfitzpa/logs";

if( $DBG ) {
        print "months:          \@months\n";
        print "days:            \@days\n";
        print "NOW:             $NOW\n";
        print "year:            $year\n";
        print "logdir:          $logdir\n";
        print "$days[$wday] $months[$mon] $mday $year\n";
}

if( $DBG ) {
	xit( $File, $Proc );
}

######################################################
# Name: chop_blanks
# Func: Chop blanks off the end of a string
# Call: str = chop_blanks( str );
######################################################
# History
######################################################
#
sub chop_blanks {
	my $Proc = "chop_blanks";
	my $DBG = 0;
	Start( "1,2,3", $Proc );
	if( LevelCheck( 1, $Proc ) and $DBG ) {
		ntry( $File, $Proc );
	}

	my $str = shift @_;

	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }
	$_ = scalar reverse $str;
	s/^\s+//;
	$str = scalar reverse $_;
	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }

	if( $DBG )
		{ xit( $File, $Proc ); }
	return $str;
}

######################################################
# Name: clear
# Func: Clear the screen.
# Call: clear
######################################################
# History
######################################################
#
sub clear {
	my $DBG = 0;
	my $Proc = "clear";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	system( 'clear' );

	if( $DBG )
		{ xit( $File, $Proc ); }
}

######################################################
# Name: get_printable
# Func: Returns a printable version of a byte.
#       If 0x20 < ch > 0x7E then returns ".".
# Call: $ch = get_printable( 0x7f );
######################################################
# History
######################################################
#
sub get_printable {
	my $DBG = 0;
	my $Proc = "get_printable";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	my $tmp = shift @_;
	my $ch;

	if( $DBG ) {
		Debug; Label( "Hex tmp" ); H2( $tmp ); Nl;
	}
	$ch = $tmp;
	if( $tmp < 0x20 )
		{ $ch = 0x2e; }
	elsif( $tmp > 0x7e )
		{ $ch = 0x2e; }
	if( $DBG ) {
		Debug; printf( "ch: %c\n", $ch ); Nl;
	}

	if( $DBG )
		{ xit( $File, $Proc ); }
	return $ch;
}


######################################################
# Name:    remove_external_whitespace
# Func:    Remove leading & trailing whitespace from a
#                string.
# Call:    remove_external_whitespace( str );
# NOTE:    This works on the supplied string.
######################################################
# History
######################################################
#
sub remove_external_whitespace(\$) {
	my( $DBG ) = 0;
	my $Proc = "remove_external_whitespace";
	if( $DBG ) {
		ntry( $File, $Proc );
	}
	#print "This is being removed. Use trim instead.\n";

	my ($str) = @_;
	return unless ($str && $$str);
	$$str =~ s/^\s+//;
	$$str =~ s/\s+$//;

	if( $DBG )
		{ xit( $File, $Proc ); }
} # remove_external_whitespace


###########################################################
# NAME: GetLtrFromString
# FUNC: Given a string and an idex, returns that letter.
###########################################################
#   Date   # Name     # Comment
###########################################################
#
sub GetLtrFromString {
	my $Proc = "GetLtrFromString";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }
	my( $String, $Idx ) = @_;
	my $Ltr = "";

	if( $DBG ) {
		print "String: \"$String\"\n";
		print "Ltr: \"$Ltr\"\n";
		print "Idx: \"$Idx\"\n";
	}

	$Ltr = substr( $String, $Idx++, 1 );
	if( $DBG ) {
		print "String: \"$String\"\n";
		print "Ltr: \"$Ltr\"\n";
		print "Idx: \"$Idx\"\n";
	}

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $Ltr, $Idx );
};

############################################################################
# NAME: YMDHMS
# FUNC: Get the date/time stamp.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub YMDHMS {
	my( $DBG ) = 0;
	my $Proc = "YMDHMS";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	my $date;

	if( $DBG )
		{ print "$days[$wday] $months[$mon] $mday $year\n"; }

	$date = sprintf("%04d%02d%02d%02d%02d%02d", $year, $mon+1, $mday, $hour, $min, $sec );
	if( $DBG ) {
		print "$days[$wday] $months[$mon] $mday $year\n";
		print "date: $date\n";
	}

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $date );
}

############################################################################
# NAME: GetYMDHMS
# USED: $DTG = &GetYMDHMS( time );
# FUNC: Returns the date/time stamp for a given time.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub GetYMDHMS {
	my( $DBG ) = 0;
	my $Proc = "GetYMDHMS";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	local( $my_time ) = @_;

	my $date;

	( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( $my_time );
	$year += 1900;
	$date = sprintf("%04d%02d%02d%02d%02d%02d", $year, $mon+1, $mday, $hour, $min, $sec );
	if( $DBG ) {
		print "$days[$wday] $months[$mon] $mday $year\n";
		print "date: $date\n";
	}

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $date );
}

############################################################################
# NAME: Logger
# FUNC: Log the supplied record.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub Logger {
	my( $DBG ) = 0;
	my $Proc = "Logger";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	my $TST = 0;
	my $date = &YMDHMS;
	my $log = $logdir;
	my $rec;

	if( $DBG ) {
		print "ARGV before looking for the test parm:   @ARGV\n";
	}
	$last = pop( @ARGV );
	if( $last =~ "TST" )
		{ $TST = 1; }
	else
		{ push( @ARGV, $last ); }

	$rec = "$date @ARGV";

	if( $TST )
		{ $log .= "/testlog.rpt"; }
	else
		{ $log .= "/logging.rpt"; }

	if( $DBG ) {
		print "log:    $log\n";
		print "last:   $last\n";
		print "ARGV:   @ARGV\n";
	}

	open LOG, ">>$log" or die "Can't open $log: $!\n";

	if( $DBG )
		{ print "rec: $rec\n"; }
	print LOG "$rec\n";
	$TST = 0;
	undef $rec;
	close LOG;

	if( $DBG )
		{ xit( $File, $Proc ); }
} # sub Logger {


############################################################################
# NAME: Ask_Y_N
# FUNC: Read the supplied answer. If "y" or "Y", return 1, else return 0.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub Ask_Y_N {
	my( $DBG ) = 0;
	my $Proc = "Ask_Y_N";
	if( $DBG )
		{ ntry( $File, $Proc ); }

	my $ans = 0;

	my $answer = <STDIN>;
	if( $answer =~ /y/ || $answer =~ /Y/ )
		{ $ans = 1; }

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $ans );
}

############################################################################
# NAME: print8bits
# FUNC: Print an 8 bit number in binary.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub print8bits {
	my( $DBG ) = 0;
	my $Proc = "print8bits";
	if( $DBG ) {
		ntry( $File, $Proc );
	}


	my $byte = shift @_;
	my $idx = 0b10000000;

	printf( "%08b\n", $byte );

	if( $DBG )
		{ xit( $File, $Proc ); }
}


###########################################################
# NAME:		Unsplit
# USAGE:	wrd = Unsplit( hi, lo )
# DESC:		Returns a word (16 bits).
#
sub Unsplit {
	my( $DBG ) = 0;
	my $Proc = "Unsplit";
	if( $DBG )
		{ ntry( $File, $Proc ); }

	local( $hi, $lo ) = @_;

	$wrd = ( $hi * 0x100 + $lo ) & 0xffff;
	$wrd = int( $wrd );
	if( $DBG > 0 )
		{ xit( $File, $Proc ); }
	return $wrd;
}


###########################################################
# NAME:		Split
# USAGE:	( hi, lo ) = Split( wrd )
# DESC:		Returns two bytes.
#
sub Split {
	my $Proc = "Split";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	local $word = shift( @_ );
	$word = int( $word );
	local( $hi ) = 0;
	local( $lo ) = 0;

	$hi = int( $word / 0x100 );
	$lo = int( $word % 0x100 );
	if( $DBG ) {
		printf( "hi: 0x%02x\n", $hi );
		printf( "lo: 0x%02x\n", $lo );
	}


	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $hi, $lo );
}


###########################################################
# NAME:		lo
# USAGE:	lo = lo( word )
# DESC:		Returns the lo byte of a word (16 bits).
#
sub lo {
	my $Proc = "lo";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	local $word = shift( @_ );
	$word = int( $word );
	$word = $word & 0xffff;
	if( $DBG )
		{ Debug( $IL ); printf( "input: 0x%04x\n", $word ); }

	local( $lo ) = 0;

	$lo = int( $word % 0x100 );
	if( $DBG )
		{ Debug( $IL ); printf( "lo 0x%02x\n", $lo ); }


	if( $DBG )
		{ xit( $File, $Proc ); }
	return $lo;
}


###########################################################
# NAME:		hi
# USAGE:	hi = hi( word )
# DESC:		Returns the hi byte of a word (16 bits).
###########################################################
#
sub hi {
	my $Proc = "hi";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	local $word = shift( @_ );
	if( $DBG )
		{ printf( "input: 0x%04x\n", $word ); }

	$word = $word & 0xffff;
	if( $DBG )
		{ printf( "input: 0x%04x\n", $word ); }

	local( $hi ) = 0;

	$hi = int( $word / 0x100 );
	if( $DBG ) {
		printf( "hi: 0x%02x\n", $hi );
	}


	if( $DBG )
		{ xit( $File, $Proc ); }
	return $hi;
}


###########################################################
# NAME: get_char
# DESC: Returns a character in $CH.
#
sub get_char {
	my( $DBG ) = 0;
	my $Proc = "get_char";
	if( $DBG ) {
		ntry( $File, $Proc );
	}


	$CH = unpack( "C", getc COM );
	$CHR_CNT++;
	if( eof( COM ))
		{ $EOF = 1; }
	$_ = $CH;
	$Address++;
	if( $DEBUG > 1 ) {
		if( $CH < 0x20 )
			{ printf( "Char read: \".\"\n" ); }
		elsif( $CH > 0x7f )
			{ printf( "Char read: \".\"\n" ); }
		else
			{ printf( "Char read: \"%c\"\n", $CH ); }
		printf( "Char read: \"0x%.2x\"\n", $CH );
	}
	if( eof( COM )) {
		if( $DEBUG > 0 )
			{ print "xiting get_char\n"; }
		return;
	} else {
		if( $DBG )
			{ xit( $File, $Proc ); }
		return $CH;
	}

}


# ####################################################
# Name: file_select
# Func: To return a file name. If the user selects a
				# directory, this will be cd'd into.
# Call: file_select some_path
# ####################################################
# History
# ####################################################
#
# sub file_select
# {
	# my $DBG = 0;
	# if( $DBG )
		# { ntry( $IL, $file, "file_select" ); }
	# $IL++;
	# my ($str) = @_;

	# use Term::Menus;
	# use File::chdir;

	# $LOG = "/tmp/$USER_$file$$";
	# `rm $LOG`;
	# open( LOG, ">>$LOG" );
	# if( $DBG )
		# { print "log: \"$LOG\"\n"; }

	# $tmpfile = "/tmp/$file.$$";
	# if( $DBG )
		# { print LOG "tmpfile = \"$tmpfile\"\n"; }

	# if( $str )
		# { $dir = $str; }
	# else
		# { $dir = "."; }
	# if( $DBG )
		# { print "dir: $dir\n"; }

	# my $tmpdir;
	# while( 1 )
	# {
		# if( $DBG )
			# { print LOG "dir = \"$dir\"\n"; }
		# &sel( $dir );
		# $_ = $selection;
		# if( /^d/ )
		# {
			# if( $DBG )
				# { print "Inside if statement\n"; }
			# ( $type, $owner, $grp, $size, $name ) = split( /\s+/, $_ );
			# push @CWD, $name;
			# $dir = $CWD;
			# if( $DBG )
			# {
				# print LOG "cwd after the new directory path is created = \"$CWD\"\n";
				# print LOG "dir after the new directory path is created = \"$dir\"\n";
			# }
		# }
		# elsif( /^-/ )
		# {
			# ( $type, $owner, $grp, $size, $name ) = split( /\s+/, $_ );
			# $FILE = $name;
			# if( $DBG )
			# {
				# print LOG "dir:  $dir\n";
				# print LOG "FILE: $FILE\n";
			# }
			# last;
		# }
	# }

	# sub sel
	# {
		# $dir = shift @_;
		# if( $DBG )
			# { print LOG "dir inside of sel = \"$dir\"\n"; }
		# $CWD = $dir;
		# if( $DBG )
			# { print "CWD: $CWD\n"; }
		# undef @list;
		# @list = ();
		# @list=`ls -la .`;

		# undef @FileList;
		# @FileList = ();
		# for( @list )
		# {
			# if( $DBG )
				# { print LOG "\@list record: \"$_\"\n"; }
			# next if m/^total/;
			# ( $type, $g1, $owner, $grp, $size, $mon, $day, $time, $name ) = split( /\s+/, $_ );
			# $rec = sprintf( "%-15s %-8s %-8s %8d %s", $type, $owner, $grp, $size, $name );
			# push( @FileList, $rec );
		# }
		# $banner="   Please Pick an Item:";
		# $selection=&pick(\@FileList,$banner);
		# if( $DBG )
			# { print LOG "SELECTION = \"$selection\"\n"; }
		# if( $selection eq ']quit[' )
		# {
			# $FILE = $selection;
			# close( LOG );
			# return $dir;
			# exit;
		# }
	# }
	# close LOG;
	# print "LOG: $LOG\n";

	# $IL--;
	# if( $DBG )
		# { xit( $IL, $file, "file_select" ); }
	# return ($FILE, $dir);
# }

###########################################################
# NAME: leftright
# DESC: Rips off first parm of $line,
#       and places that in $left and the rest of the stream
#       goes into $right. $line is now updated to be $right.
# Call: ( left, right ) = leftright;
#
sub leftright {
	my( $DBG ) = 0;
	my $Proc = "leftright";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	$line = shift;

	undef $left;
	undef $right;

	( $left, $right ) = split( /\s+/, $line, 2 );
	#$line = $right;
	if( $DBG )
	{
		print "line:  \"$line\"\n";
		print "LEFT:  \"$left\"\n";
		print "RIGHT: \"$right\"\n";
	}
	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $left, $right );
}


sub get_token {
	my( $DBG ) = 0;
	my $Proc = "get_token";
	if( $DBG ) {
		ntry( $File, $Proc );
	}


	undef $TOKEN;
	skip_white();
	for( ;; )
	{
		$CH = getc FH1;
		$_ = $CH;
		if( /\s/ )
			{ last; }

		$TOKEN .= $CH;
		if( $DBG )
			{ print "TOKEN: \"$TOKEN\".\n"; }
	}

	if( $DBG )
		{ xit( $File, $Proc ); }
}

sub skip_white {
	my( $DBG ) = 0;
	my $Proc = "skip_white";
	if( $DBG ) {
		ntry( $File, $Proc );
	}


	for( ;; )
	{
		$_ = getc FH1;
		if( /\S/ )
		{
			$TOKEN = $_;
			last;
		}

		if( $DBG )
			{ print "CH: \"$_\".\n"; }
	}

	if( $DBG )
	{ xit( $File, $Proc ); }
}

sub Debug_Number {
	my ( $DEBUG, $IL, $VALUE, $DESCR, $NL ) = @_;

	if( $DEBUG > 0 )
	{
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		print "DEBUG - $DESCR: $VALUE";
		if( $NL )
			{ print "\n"; }
	}
}

sub Debug_String {
	local( $DEBUG, $IL, $VALUE, $DESCR, $NL ) = @_;

	if( $DEBUG > 0 )
	{
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		print "DEBUG - $DESCR";
		print "$VALUE";
		if( $NL )
			{ print "\n"; }
	}
}

sub Debug_Quoted_Char {
	local( $DEBUG, $IL, $VALUE, $DESCR, $NL ) = @_;

	if( $VALUE < 0x20 )
	{
		$VALUE = 0x2e;
	}
	elsif( $VALUE > 0x7f )
	{
		$VALUE = 0x2e;
	}

	if( $DEBUG > 0 )
	{
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		print "DEBUG - $DESCR: ";
		printf( "\"%c\"", $VALUE );
		if( $NL )
			{ print "\n"; }
	}
}

sub Debug_2Hex {
	local( $DEBUG, $IL, $VALUE, $DESCR, $NL ) = @_;

	if( $DEBUG > 0 )
	{
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		print "DEBUG - $DESCR: ";
		printf( "%.2x", $VALUE );
		if( $NL )
			{ print "\n"; }
	}
}

sub get_2bytes {
	local( $lo_byte, $hi_byte, $word );
	$lo_byte = get_char;
	if( $EOF )
	{
		print "ERROR: Need to read another byte, and there isn't one.\n";
		exit;
	}
	$word = get_char;
	$word *= 0x100;
	$word += $lo_byte;
	if( $LABEL{ $word })
		{ $Opnd .= $LABEL{ $word}; }
	else
	{
		$Opnd .= &byte_to_string( $hi_byte );
		$Opnd .= &byte_to_string( $lo_byte );
	}
}

sub Lbyte {
	my( $labl, $val ) = @_;

	for( $i = 0; $i < $IL; $i++ )
		{ print "  "; }
	printf( "DEBUG - %s \"0x%.2x\"\n", $labl, $val );
}

sub Lword {
	my( $labl, $val ) = @_;

	for( $i = 0; $i < $IL; $i++ )
		{ print "  "; }
	printf( "DEBUG - %s \"0x%.4x\"\n", $labl, $val );
}

sub Lstring {
	my( $labl, $str ) = @_;

	for( $i = 0; $i < $IL; $i++ )
		{ print "  "; }
	printf( "DEBUG - %s \"%s\"\n", $labl, $str );
}

sub Dstring {
	my( $str ) = @_;

	if( $DBG ) {
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		printf( "DEBUG - %s\n", $str );
	}
}

sub Debug_4Hex {
	local( $DEBUG, $IL, $DESCR, $VALUE, $NL ) = @_;
	#local( $DEBUG, $IL, $VALUE, $DESCR, $NL ) = @_;

	if( $DEBUG > 0 )
	{
		for( $i = 0; $i < $IL; $i++ )
			{ print "  "; }
		printf( "DEBUG - %s: \"0x%.4x\"", $DESCR, $VALUE );
		if( $NL )
			{ print "\n"; }
	}
}

###########################################################
# NAME: byte_to_string
# DESC: Returns a character in $CH.
#
sub byte_to_string {
	local( $tmp ) = @_;
	local( $DEBUG ) = 0;
	local( $nyb_hi, $nyb_lo );
	if( $DEBUG > 0 )
		{ print "Entered byte_to_string\n"; }

	$nyb_lo = $tmp % 0x10;
	$nyb_hi = $tmp / 0x10;
	$tmp  = $chars[ $nb_hi ];
	$tmp .= $chars[ $nb_lo ];
	if( $DEBUG > 0 )
		{ print "xiting get_char\n"; }
	return $CH;
}

#
###########################################################
# NAME: byte_to_char
# DESC: Returns a character in $CH.
#
sub byte_to_char {
	local( $inp ) = @_;
	local( $DEBUG ) = 0;
	local( $tmp );
	if( $DEBUG > 0 )
		{ print "Entered byte_to_char\n"; }

	if( $inp < 0x20 )
		{ $tmp = 0x2e; }
	elsif( $inp > 0x7e )
		{ $tmp = 0x2e; }
	else
		{ $tmp = $inp; }

	if( $DEBUG > 0 )
		{ print "xiting byte_to_char\n"; }
	return $tmp;
}


############################################################################
# NAME: newAsk_Y_N
# FUNC: Read the supplied answer. If "y" or "Y", return 1, else return 0.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub newAsk_Y_N {
	my( $DBG ) = 0;
	my $Proc = "Ask_Y_N";
	if( $DBG ) {
		ntry( $File, $Proc );
	}


	my $ans = 0;

	#STDOUT->autoflush( 1 );
	print "Enter a \"y\" or \"Y\" to continue. Everything else will cause an exit.\n";
	print "Continue? ";
	my $answer = <STDIN>;
	if( $answer =~ /y/ || $answer =~ /Y/ )
		{ $ans = 1; }

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $ans );
}


######################################################
# Name: rtrim - used to called chop_blanks
# Func: Chop blanks off the end of a string
# Call: str = rtrim( str );
######################################################
# History
######################################################
#
sub rtrim {
	my $str = shift @_;
	my $Proc = "rtrim";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }
	$str =~ s/\s+$//;
	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }

	if( $DBG )
		{ xit( $File, $Proc ); }
	return $str;
}


######################################################
# Name: ltrim
# Func: Chop blanks off the beginning of a string
# Call: str = ltrim( str );
######################################################
# History
######################################################
#
sub ltrim {
	my $str = shift @_;
	my $Proc = "ltrim";
	my $DBG = 0;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }
	$str =~ s/^\s+//;
	#$str =~ s/^\s+|\s+$//g;
	if( $DBG )
		{ print DBG "str: \"$str\"\n"; }

	if( $DBG )
		{ xit( $File, $Proc ); }
	return $str;
}


###########################################################
# NAME:		bin2dec
# USAGE:	dec = bin2dec( bin )
# DESC:		Returns the decimal value of "bin" (binary).
###########################################################
sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

###########################################################
# NAME:		dec2bin
# USAGE:	bin = dec2bin( dec )
# DESC:		Returns the binary value of "dec" (decimal).
# NOTE: Not tested at all.
###########################################################
sub dec2bin {
	my $str = unpack("B32", pack("N", shift));
	$str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
	return $str;
}


######################################################
# Name:    nextCH
# Func:    Returns the first char of the string
#          and deletes the same char from the string.
# Call:    ( $ch, $str ) = nextCH( str );
# NOTE:    This works on the supplied string.
######################################################
# History
######################################################
#
#sub nextCH(\$)
sub nextCH
{
	my( $DBG ) = 1;
	my $Proc = "nextCH";
	if( $DBG ) {
		ntry( $File, $Proc );
	}

	my ($str) = @_;
	if( $DBG )
		{ Debug( $IL ); print "str: $str\n"; }
		#return unless ($str && $$str);
	my $ch = substr( $str, 0, 1 );
	$str =~ s/^.//;

	if( $DBG )
		{ xit( $File, $Proc ); }
	return( $ch, $str );
} # nextCH


############################################################################
# NAME: prompt
# FUNC: Print out the prompt "query", read the answer and return it.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub prompt {
	my( $query ) = @_;	# takes a prompt as an argument

	local $| = 1;		# activate autoflush to immediately show the prompt
	print $query;
	chomp( my $answer = <STDIN> );
	return $answer;
}


############################################################################
# NAME: prompt_yn
# FUNC: Print the prompt "query" and read the answer. If the answer is "y|y"
# 		return "y".
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub prompt_yn {
	my( $query ) = @_;	# takes a prompt as an argument

	my $answer = prompt( "$query (Y/N): ");

	return lc( $answer ) eq 'y';
}


###########################################################
# NAME:		UtilsTest
# USAGE:	UtilsTest
# DESC:		Returns a line of text for each test.
###########################################################
#
sub UtilsTest {
	my $Proc = "UtilsTest";
	my $DBG = 1;
	if( $DBG )
		{ ntry( $File, $Proc ); }

	$res = 0;
	$word = 0xff00;
	$res = hi( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"hi\" word: 0x%04x   result: 0x%02x\n", $word, $res ); }
	if( $res != 0xFF )
		{ Debug( $IL ); print "$fails tests failed in hi $res != 0xff\n"; }
	$word = 0x00ff;
	$res = hi( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"hi\" word: 0x%04x   result: 0x%02x\n", $word, $res ); }
	if( $res != 0x00 )
		{ Debug( $IL ); print "$fails tests failed in hi $res != 0x00\n"; }
	print "\n";


	$res = 0;
	$word = 0xff00;
	$res = lo( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"lo\" word: 0x%04x   result: 0x%02x\n", $word, $res ); }
	if( $res != 0x00 )
		{ Debug( $IL ); print "test failed in lo $res != 0x00\n"; }
	$word = 0x00ff;
	$res = lo( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"lo\" word: 0x%04x   result: 0x%02x\n", $word, $res ); }
	if( $res != 0xff )
		{ Debug( $IL ); print "test failed in lo $res != 0xff\n"; }
	print "\n";


	$hi = 0;
	$lo = 0;
	$word = 0xff00;
	( $hi, $lo ) = Split( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"Split\" word: 0x%04x   hi: 0x%02x  lo: 0x%02x\n", $word, $hi, $lo ); }
	if( $hi != 0xff )
		{ Debug( $IL ); print "\"Split\" test failed: $hi != 0xff\n"; }
	if( $lo != 0x00 )
		{ Debug( $IL ); print "\"Split\" test failed: $lo != 0x00\n"; }

	$word = 0x1234;
	( $hi, $lo ) = Split( $word );
	if( $DBG )
		{ Debug( $IL ); printf( "\"Split\" word: 0x%04x   hi: 0x%02x  lo: 0x%02x\n", $word, $hi, $lo ); }
	if( $hi != 0x12 )
		{ Debug( $IL ); print "\"Split\" test failed: $hi != 0x12\n"; }
	if( $lo != 0x34 )
		{ Debug( $IL ); print "\"Split\" test failed: $lo != 0x34\n"; }
	print "\n";


	$hi = 0x12;
	$lo = 0x34;
	$word = 0;
	( $word ) = Unsplit( $hi, $lo );
	if( $DBG )
		{ Debug( $IL ); printf( "\"Unsplit\" word: 0x%04x   hi: 0x%02x  lo: 0x%02x\n", $word, $hi, $lo ); }
	if( $word != 0x1234 )
		{ Debug( $IL ); print "\"Unsplit\" test failed: $hi != 0xff\n"; }

	$hi = 0x0f;
	$lo = 0x0f;
	$word = 0;
	( $word ) = Unsplit( $hi, $lo );
	if( $DBG )
		{ Debug( $IL ); printf( "\"Unsplit\" word: 0x%04x   hi: 0x%02x  lo: 0x%02x\n", $word, $hi, $lo ); }
	if( $word != 0x0f0f )
		{ Debug( $IL ); print "\"Unsplit\" test failed: $hi != 0x12\n"; }
	print "\n";


	$in = "  Hi there   ";
	( $out ) = trim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"trim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"trim\" test failed: \"$out\" ne \"Hi there\"\n"; }

	$in = "  Hi there";
	( $out ) = trim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"trim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"trim\" test failed: \"$out\" ne \"Hi there\"\n"; }

	$in = "Hi there   ";
	( $out ) = trim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"trim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"trim\" test failed: \"$out\" ne \"Hi there\"\n"; }
	print "\n";


	$in = "  Hi there   ";
	( $out ) = ltrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"ltrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there   " )
		{ Debug( $IL ); print "\"ltrim\" test failed: \"$out\" ne \"Hi there   \"\n"; }

	$in = "  Hi there";
	( $out ) = ltrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"ltrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"ltrim\" test failed: \"$out\" ne \"Hi there\"\n"; }

	$in = "Hi there   ";
	( $out ) = ltrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"ltrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there   " )
		{ Debug( $IL ); print "\"ltrim\" test failed: \"$out\" ne \"Hi there   \"\n"; }
	print "\n";


	$in = "   Hi there   ";
	( $out ) = rtrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"rtrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "   Hi there" )
		{ Debug( $IL ); print "\"rtrim\" test failed: \"$out\" ne \"   Hi there\"\n"; }

	$in = "   Hi there";
	( $out ) = rtrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"rtrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "   Hi there" )
		{ Debug( $IL ); print "\"rtrim\" test failed: \"$out\" ne \"   Hi there\"\n"; }

	$in = "Hi there   ";
	( $out ) = rtrim( $in );
	if( $DBG )
		{ Debug( $IL ); printf( "\"rtrim\" in: \"%s\"   out: \"%s\"\n", $in, $out ); }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"rtrim\" test failed: \"$out\" ne \"Hi there\"\n"; }
	print "\n";


	$in = "  Hi there   ";
	if( $DBG )
		{ Debug( $IL ); print "\"remove_external_whitespace\" in: \"$in\"   "; }
	remove_external_whitespace( $in );
	$out = $in;
	if( $DBG )
		{ print "out: \"$out\"\n"; }
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"remove_external_whitespace\" test failed: \"$out\" ne \"Hi there\"\n"; }
	print "\n";


	$line = "Hi there";
	if( $DBG )
		{ Debug( $IL ); print "\"leftright\" line: \"$line\"\n"; }
	( $left, $right ) = leftright;
	if( $DBG ) {
		print " left: \"$left\"\n";
		print "right: \"$right\"\n";
		print " line: \"$line\"\n";
	}
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"leftright\" test failed: \"$left\" ne \"Hi\"\n"; }
# Call: ( left, write ) = leftright( str );


	$line = "Hi there";
	if( $DBG )
		{ Debug( $IL ); print "\"nextCH\" line: \"$line\"\n"; }
	print "\n";


	my $ch;
( $ch, $line ) = nextCH( $line );
print "ch: $ch\n";
print "line: $line\n\n";
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"nextCH\" test failed: \"$line\" ne \"i there\"\n"; }

( $ch, $line ) = nextCH( $line );
print "ch: $ch\n";
print "line: $line\n\n";
	if( $out ne "Hi there" )
		{ Debug( $IL ); print "\"nextCH\" test failed: \"$line\" ne \" there\"\n"; }


	undef $res;
	if( $DBG )
		{ xit( $File, $Proc ); }
}


#######################################################
# Name:    trim
# Func:    Remove leading & trailing whitespace from a
#                string.
# Call:    trim( str )
######################################################
# History
######################################################
#
sub trim {
	my( $DBG ) = 1;
	my $Proc = "trim";
	if( $DBG ) {
		ntry( $File, $Proc );
                                                                }
 
	my $str = shift;
	if( $DBG ) {
		print "str in: \"$str\"\n";
	}
 
	$str = ltrim( $str );
	if( $DBG ) {
		print "str ltrim: \"$str\"\n";
	}
	
	$str = rtrim( $str );
	if( $DBG ) {
		print "str rtrim: \"$str\"\n";
	}
 
	if( $DBG )
		{ xit( $File, $Proc ); }
	return $str;
} # trim
 
 
############################################################################
# Name: StrToBin
# Func: Convert a binary number string to a number.
# Call: $Num = &StrToBin( $Str );
###########################################################
#   Date   # Name     # Comment
###########################################################
#
sub StrToBin {
    my $Proc = "StrToBin";
    my $DBG = 1;
    &Start( "1,2,3,4", $Proc );
    if( &LevelCheck( 1, $Proc ) and $DBG )
        { ntry( $File, $Proc ); }
 
    my $str = shift @_;
    my $len = 0;
    if( &LevelCheck( 2, $Proc ) and $DBG )  {
        Debug( $IL ); print " str: \"$str\"\n";
    }
 
    my $c;
    my $Value = 0;
    my $len = length( $str );
 
    while( $len ) {
        if( &LevelCheck( 2, $Proc ) and $DBG )  {
            print "str: \"$str\"\n";
        }
 
        $c = substr( $str, 0, 1 );
        $_ = $str;
        s/^.//;
        $str = $_;
 
        $c += 0;    # make it a number
        $Value = $Value * 2 + $c;
        $len--;
    }
    if( &LevelCheck( 2, $Proc ) and $DBG )  {
        print "Value: \"$Value\"\n";
    }
 
    if( &LevelCheck( 1, $Proc ) and $DBG )
        { xit( $File, $Proc ); }
    return $Value;
} # sub StrToBin {
 
 
sub PromptUser {
    my( $promptString, $defaultValue ) = @_;
    my $Proc = "PromptUser";
    my $DBG = 0;
    if( $DBG )
        { print "entering Proc $Proc\n"; }

    if( $defaultValue ) {
        print "$promptString = [$defaultValue]: ";
    } else {
        print "$promptString: ";
    }

    $| = 1;
    my $ans = <STDIN>;
    chomp( $ans );
    if( $DBG )
    { print "ans: \"$ans\"\n"; }

    if( "$defaultValue" ) {
        return $ans ? $ans : $defaultValue;
    } else {
        return $ans;
    }
} # End PromptUser


######################################################
# Name: printable_char
# Func: Returns a printable version of a byte.
#		If it is < 0x20 or > 0x7E then returns ".".
# Call: $ch = printable_char( 0x7f );
######################################################
# History
######################################################
#
sub printable_char {
	my $DBG = 0;
	my $Proc = "printable_char";
	DebugLevels( "1,2", $Proc );
	if( LevelCheck( 1, $Proc ) and $DBG )
		{ ntry( $File, $Proc ); }

	my $tmp = shift @_;
	my $char;
	my $ch;

	if( LevelCheck( 2, $Proc ) and $DBG ) {
		printf( "Hex tmp %02x\n", $ch );
	}
	$char = $tmp;
	if( $tmp < 0x20 )
		{ $char = 0x2e; }
	elsif( $tmp > 0x7e )
		{ $char = 0x2e; }
	$ch = chr( $char );
	if( LevelCheck( 2, $Proc ) and $DBG ) {
		print "ch: $ch\n";
	}

	if( LevelCheck( 1, $Proc ) and $DBG )
		{ xit( $File, $Proc ); }
	return $ch;
}


############################################################################
# NAME: Pause
# FUNC: Wait for a CR.
# AUTH: Fitz
# VERS: $Id: Utils.pm,v 1.4 2016/09/04 18:10:59 fitzer Exp fitzer $
#===========================================================================
# HISTORY
#===========================================================================
#   DATE   # NAME               # COMMENT
#===========================================================================
#
sub Pause {
	my $DBG = 0;
	my $Proc = "Pause";
	DebugLevels( "1,2", $Proc );
	if( LevelCheck( 1, $Proc ) and $DBG )
		{ ntry( $File, $Proc ); }

	print "Hit a Return or Enter key to continue - or a \"q\" to quit.\n";
	my $ans = 0;
	$_ = <STDIN>;
	s/\r//; s/\n//;
	$ans = $_;

	if( LevelCheck( 1, $Proc ) and $DBG )
		{ xit( $File, $Proc ); }
	return $ans;
}

1;
 
 
#FFitz
 
 
#######################################################
 
