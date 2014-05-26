#!/usr/bin/env perl
use Mojolicious::Lite;



# Render template "templates/BuildHistory.html.ep"
any '/' => sub {

  getAllItemList();

  my $self = shift;
  $self->render('index');
    
};

app->start;

sub getAllItemList() {
  
  

}

