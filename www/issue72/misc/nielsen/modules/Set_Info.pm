#!/usr/bin/perl

#              Create Functions for Perl/PostgreSQL version 1.0

#                       Copyright 2001, Mark Nielsen
#                            All rights reserved.
#    This Copyright notice was copied and modified from the Perl 
#    Copyright notice. 
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of either:

#        a) the GNU General Public License as published by the Free
#        Software Foundation; either version 1, or (at your option) any
#        later version, or

#        b) the "Artistic License" which comes with this Kit.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either
#    the GNU General Public License or the Artistic License for more details.

#    You should have received a copy of the Artistic License with this
#    Kit, in the file named "Artistic".  If not, I'll be glad to provide one.

#    You should also have received a copy of the GNU General Public License
#   along with this program in the file named "Copying". If not, write to the 
#   Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
#    02111-1307, USA or visit their web page on the internet at
#    http://www.gnu.org/copyleft/gpl.html.

package SAMPLE::Set_Info;

use strict;
use Apache;
use DBI;
use CGI;
use SAMPLE::Misc;
use SAMPLE::Constants;

sub new
{
my $Class = shift;
my %Args = @_;
my $self = {};

my $Global = SAMPLE::Constants::Get_Constants;
  ### Get the database connection.
$self->{'dbh'} = $Global->{'dbh'};
  ## Load up the queries. 
if (exists $Args{'query'}) {$self->{'query'} = $Args{'query'};}
else {$self->{'query'} = new CGI;}

bless $self,$Class;

return ($self);
}
#--------------------------------------------------------------------------

sub set_general {
my $self = shift;
my %Args = @_;

### You should NEVER use this method manually. 

  ## Set the default result to an error number. 
my $Result = -13;
  ## See if we specified a command, error if not. 
my $Command = $Args{'command'};  
my @Commands = ('insert','update','delete','purge','unpurge','purgeone',
  'unpurgeone','undelete','copy','change');
if (!(grep($_ eq $Command, @Commands))) {return (-11);}
  ## See if we specified an Id, if not error out.
my $Id = $Args{'id'};
if (($Id < 1) && !(grep($_ ne $Command,('insert','purge','unpurge'))))
   {return (-10);}

my $TableName = $Args{'tablename'};
my $Columns = $Args{'columns'};
  ### If we somehow didn't get the tablename or columns, return error. 
  ### This should be impossible since they are supplies by other
  ### functions.  
if (($TableName eq "") || ((@$Columns) < 1)) {return (-14);}

if (grep($_ eq $Command,('delete','undelete','purgeone','unpurgeone','copy'))) 
  {
  my $Sql = "select sql_$TableName\_$Command\(?) as $Command";
  my $sth = $self->{'dbh'}->prepare($Sql);
  $sth->execute($Id);
  my $ref = $sth->fetchrow_hashref();
  $Result = $ref->{$Command};
  }
elsif (grep($_ eq $Command, ('insert','purge','unpurge')))
  {
  my $Sql = "select sql_$TableName\_$Command\() as $Command";
  my $sth = $self->{'dbh'}->prepare($Sql);
  $sth->execute();
  my $ref = $sth->fetchrow_hashref();
  $Result = $ref->{$Command};
  }
  ### Use the update function to explicity define every field. 
  ### Use the change function when you want to specify only certain
  ### fields. 
elsif ($Command eq "update")
  {
  my $query = $self->{'query'};
  if (exists $Args{'query'}) {$query = $Args{'query'};}
    ### If we were supplied a query, use it instead. 
  if (exists $Args{'query'}) {$query = $Args{'query'};}
  my @Fields = @$Columns;
  my @Values = ();
  my $String = "";

  my $args = \%Args;
  foreach my $Field (@Fields) 
    {
    my $Value = '';
    ## If we supplied a list of fields, use them.
    if (exists $args->{'fields'}->{$Field})
      { $Value = $args->{'fields'}->{$Field};}
    else {$Value = $query->param($Field) || '';}  
    if ($Value eq "") {$Value = '';}
    $Value = GES::Misc->Clean_String($Value);
    push (@Values,$Value);
    $String .= ",?";
    }

  my $Sql = "select sql_$TableName\_update(? $String) as update";
  my $sth = $self->{'dbh'}->prepare($Sql);
  $sth->execute($Id,@Values);
  my $ref = $sth->fetchrow_hashref();
  $Result = $ref->{'update'};
  }
  ### This function is used when you only want to change the values and
  ### fields you specify. It will work with no fields specified, which is
  ### just a copy in the backup table. 
elsif ($Command eq "change")
  {
  my $query = $self->{'query'};
  if (exists $Args{'query'}) {$query = $Args{'query'};}
    ### If we were supplied a query, use it instead. 
  if (exists $Args{'query'}) {$query = $Args{'query'};}
  my @Fields = @$Columns;
  my @Values = ();
  my $String = "";
  my @Params = $query->param();

  my $Sql = "select *  from $TableName where $TableName\_id = ?";
  my $sth = $self->{'dbh'}->prepare($Sql);
  $sth->execute($Id);
  my $No = $sth->rows();
    ## If we don't have one thing to change, return an error. 
  if ($No < 1) {return (-100);}
  my $Previous = $sth->fetchrow_hashref();

  my $args = \%Args;
  foreach my $Field (@Fields) 
    {
    my $Value = '';
    ## If we supplied a list of fields, use them.
    if (exists $args->{'fields'}->{$Field})
      { $Value = $args->{'fields'}->{$Field};}
    elsif (grep($_ eq $Field, @Params)) 
      { $Value = $query->param($Field); }
    else {$Value = $Previous->{$Field};}  
    if ($Value eq "") {$Value = '';}
    
    $Value = GES::Misc->Clean_String($Value);
    push (@Values,$Value);
    $String .= ",?";
    }

  my $Sql = "select sql_$TableName\_update(? $String) as update";
  my $sth = $self->{'dbh'}->prepare($Sql);
  $sth->execute($Id,@Values);
  my $ref = $sth->fetchrow_hashref();
  $Result = $ref->{'update'};
  }

return ($Result);
}

### Remember to create a "new" function which defines 
### $query and also $dbh in $self. 
### Also, remember to have "use CGI;" in the perl module. 

sub Set_class {
my $self = shift;
my %Args = @_;

$Args{'tablename'} = "class";
$Args{'columns'} = ['time','title','description','users_id'];
my $Result = $self->set_general(%Args);

return ($Result);
}
### Remember to create a "new" function which defines 
### $query and also $dbh in $self. 
### Also, remember to have "use CGI;" in the perl module. 

sub Set_contact {
my $self = shift;
my %Args = @_;

$Args{'tablename'} = "contact";
$Args{'columns'} = ['company_name','first','middle','last','email','work_phone','home_phone','address_1','address_2','address_3','city','state','zip','country'];
my $Result = $self->set_general(%Args);

return ($Result);
}
### Remember to create a "new" function which defines 
### $query and also $dbh in $self. 
### Also, remember to have "use CGI;" in the perl module. 

sub Set_students {
my $self = shift;
my %Args = @_;

$Args{'tablename'} = "students";
$Args{'columns'} = ['users_id','class_id'];
my $Result = $self->set_general(%Args);

return ($Result);
}
### Remember to create a "new" function which defines 
### $query and also $dbh in $self. 
### Also, remember to have "use CGI;" in the perl module. 

sub Set_users {
my $self = shift;
my %Args = @_;

$Args{'tablename'} = "users";
$Args{'columns'} = ['username','password','user_type','contact_id'];
my $Result = $self->set_general(%Args);

return ($Result);
}

1;
