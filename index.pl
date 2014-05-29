#!/usr/bin/env perl
use Mojolicious::Lite;
use strict;
use DBI();

# Render template "templates/BuildHistory.html.ep"
any '/' => sub {

    my @allItems;
    itemListGet(\@allItems, "");

    my $self = shift;

    $self->stash(
                allItemsRef => \@allItems
                );
    
    $self->render('index');
    
};

any '/tmpListAddPrint' => sub {

    my $self = shift;
    my $itemNo = $self->param('itemNo');
    my $action = $self->param('action');
    
    if ($itemNo > 0) {
        if ($action eq "inc") {
            itemListUpdate($itemNo, "tmpListCnt = tmpListCnt + 1");
        } 
        elsif  ($action eq "dec") {
            itemListUpdate($itemNo, "tmpListCnt = tmpListCnt - 1");
        }
    }

    my @tmpList;
    itemListGet(\@tmpList, "WHERE tmpListCnt > 0");

    my $tmpListPrint = "";

    foreach my $row (@tmpList) {
      $tmpListPrint = $tmpListPrint . "<span id=@$row[0]> @$row[1] </span><span id=@$row[0] class=\"badge\">@$row[5]</span><br>";
    }

    $self->render(text => $tmpListPrint);

};


app->start;



sub itemListUpdate() {

    my $itemNo = $_[0];
    my $sqlCmd = $_[1];

    # Connect to the database.
    my $dbh = DBI->connect("DBI:mysql:database=RFID_CheckList;host=localhost",
                         "root", "123456",
                         {'RaiseError' => 1});

    my $sql = "UPDATE itemList SET " . $sqlCmd . " WHERE tagNumber = $itemNo";      # the query to execute
    my $sth = $dbh->prepare($sql);          # prepare the query
    $sth->execute();                        # execute the query

}


sub itemListGet() {
  
    my $array_ref = $_[0];
    my $sql_cmd = $_[1];
    
    # Connect to the database.
    my $dbh = DBI->connect("DBI:mysql:database=RFID_CheckList;host=localhost",
                         "root", "123456",
                         {'RaiseError' => 1});
                             
    my $sql = "select * from itemList $sql_cmd";      # the query to execute
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

