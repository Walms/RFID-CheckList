#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojolicious::Static;

my $static = Mojolicious::Static->new;
push @{$static->paths}, '.\templates\css';

# Render template "templates/BuildHistory.html.ep"
any '/' => sub {
  my $self = shift;
  $self->render('index');
    
};

app->start;