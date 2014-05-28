#!/usr/bin/env perl
use Mojolicious::Lite;
use strict;
use DBI();


# Render template "templates/BuildHistory.html.ep"
any '/' => sub {

    my @allItems;
    getAllItemList(\@allItems);

    my $self = shift;

    $self->stash(
                allItemsRef => \@allItems
                );
    
    $self->render('index');
    
};

app->start;

sub getAllItemList() {
  
    my $array_ref = $_[0];
    
    # Connect to the database.
    my $dbh = DBI->connect("DBI:mysql:database=RFID_CheckList;host=localhost",
                         "root", "123456",
                         {'RaiseError' => 1});
                             
    my $sql = "select * from itemList";      # the query to execute
    my $sth = $dbh->prepare($sql);          # prepare the query
    $sth->execute();                        # execute the query
    my @row;

    my $table_row = 0;
    while (@row = $sth->fetchrow_array) {  # retrieve one row
        #print join(", ", @row), "\n";
        $ { $array_ref }[$table_row] = [@row];
        $table_row++;
    }

}

