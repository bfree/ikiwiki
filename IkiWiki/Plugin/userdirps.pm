#!/usr/bin/perl

# adds userdir() to PageSpec to match userpage and subpages

# Inspired by smcv's comment on:
# http://ikiwiki.info/forum/Can_ikiwiki_be_configured_as_multi_user_blog__63__/

# Copyright © 2015 Niall Walsh <niallwalsh@celtux.org>
# Licensed under the GNU GPL, version 2, or any later version published by the
# Free Software Foundation

package IkiWiki::Plugin::userdirps;

use warnings;
use strict;
use IkiWiki 3.00;

sub import {
	hook(type => "getsetup", id => "userdirps",  call => \&getsetup);
}

sub getsetup () {
	return
		plugin => {
			safe => 1,
			rebuild => 0,
		},
}

package IkiWiki::PageSpec;

sub match_userdir ($$;@) {
	my $page = shift;
	shift; # no arguments
	my %params = @_;
	if (! defined $params{user}) {
		return IkiWiki::FailReason->new("no user, no userdir");
	}
	my $userpage = IkiWiki::userpage($params{user});
	if ((index($page,$userpage)==0)&&(($userpage eq $page)||(substr($page,length($userpage),1) eq "/"))) {
		return IkiWiki::SuccessReason->new("userdir $userpage covers page $page");
	}
	return IkiWiki::FailReason->new("$page is not covered by userdir $userpage");
}

1
