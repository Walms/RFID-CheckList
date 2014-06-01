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
        elsif  ($action eq "del") {
            itemListUpdate($itemNo, "tmpListCnt = 0");
        }
    }

    my @tmpList;
    itemListGet(\@tmpList, "WHERE tmpListCnt > 0");

    my $tmpListPrint = "";

    my $listNum = 1;
    foreach my $row (@tmpList) {
        

        $tmpListPrint = $tmpListPrint . "<tr>
                                           <td>$listNum</td>
                                           <td>@$row[1]</td>
                                           <td>@$row[5] 
                                             <span id=inc@$row[0] class=\"glyphicon glyphicon-circle-arrow-up\"></span>
                                             <span id=dec@$row[0] class=\"glyphicon glyphicon-circle-arrow-down\"></span>
                                             <span id=del@$row[0] class=\"glyphicon glyphicon-remove-sign\"></span>
                                           </td>
                                         </tr>";

        $listNum++;
    }

    $self->render(text => $tmpListPrint);

};


any '/selectedListPrint' => sub {

    my $self = shift;  

    my @tmpList;
    itemListGet(\@tmpList, "WHERE tmpListCnt > 0");

    my $tmpListPrint = "";

    my $listNum = 1;
    foreach my $row (@tmpList) {
        
        my $itemStatus;
        if (@$row[6] == @$row[5]) {
            $itemStatus = "<span class=\"label label-success\">Good to Go</span>";
        } elsif (@$row[6] > @$row[5]) {
            $itemStatus = "<span class=\"label label-danger\">Excessive Items</span>";
        } else {
            $itemStatus = "<span class=\"label label-warning\">Missing Items</span>";
        }


        $tmpListPrint = $tmpListPrint . "<tr>
                                           <td>$listNum</td>
                                           <td>@$row[1]</td>
                                           <td>@$row[6] out of @$row[5]</td>
                                           <td>$itemStatus</td>
                                         </tr>";

        $listNum++;
    }

    $self->render(text => $tmpListPrint);

};

any '/RFID_checkOut' => sub {

    my @allItems;
    itemListGet(\@allItems, "");

    my $self = shift;

    $self->stash(
                allItemsRef => \@allItems
                );
    
    $self->render('RFID_checkOut');
    
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

        $ { $array_ref }[$table_row] = [@row];
        $table_row++;
    }

}

