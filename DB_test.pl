#!/usr/bin/perl

use strict;
use DBI();

# Connect to the database.
my $dbh = DBI->connect("DBI:mysql:database=RFID_CheckList;host=localhost",
                     "root", "123456",
                     {'RaiseError' => 1});
                         

my $sql = "select * from itemList";      # the query to execute
my $sth = $dbh->prepare($sql);          # prepare the query
$sth->execute();                        # execute the query
my @row;
my @table;
my $table_row = 0;
while (@row = $sth->fetchrow_array) {  # retrieve one row
    #print join(", ", @row), "\n";
    @table[$table_row] = @row;
    $table_row++;
}

# Iterate through array
foreach (@table) {
print @($_) . "\n";
}