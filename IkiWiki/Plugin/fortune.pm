#!/usr/bin/perl
# Include a fortune in a page
package IkiWiki::Plugin::fortune;

use warnings;
use strict;
use IkiWiki 2.00;

sub import { #{{{
	hook(type => "preprocess", id => "fortune", call => \&preprocess);
} # }}}

sub preprocess (@) { #{{{
	$ENV{PATH}="$ENV{PATH}:/usr/games:/usr/local/games";
	my $f = `fortune 2>/dev/null`;

	if ($?) {
		return "[[".gettext("fortune failed")."]]";
	}
	else {
		return "<pre>$f</pre>\n";
	}
} # }}}

1
