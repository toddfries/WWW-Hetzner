# Copyright (c) 2017 Todd T. Fries <todd@fries.net>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

package WWW::Hetzner;

use Data::Dumper;

use Moose; # turns on strict/warnings

use MooseX::Params::Validate;

use WWW::Hetzner::Server;

extends 'WWW::req';

our $VERSION = '0.00000001';


has 'huser' => (is => 'rw', isa => 'Str', required => 1);
has 'hpass' => (is => 'rw', isa => 'Str', required => 1);

sub setup_ua_creds {
	my ($me) = @_;

	$me->urlbase('https://robot-ws.your-server.de/');

	if (0) {
	$me->json_name('sb'); # XXX what does this do?

	my $realm = $me->json_name;
	print "creds realm: $realm\n";
	$realm = "";

	$me->{ua}->credentials(
		"robot-ws.your-server.de:443",
		$realm,
		$me->huser,
		$me->hpass,
	);
	} else {
		$me->{ua}->default_headers->authorization_basic($me->huser, $me->hpass);
	}
}

sub parse_json {
	my ($me, $res, $name) = @_;

	my $str = $res->content;
	if (ref($str) ne "") {
		$str = $res->content_ref;
	}
	if (!defined($str)) {
		printf "%s has undef str\n", $name;
		return undef;
	}
	if (length($str) < 1) {
		printf "%s has empty str\n", $name;
		print "res: ".Dumper($res);
		return undef;
	}
	if (!defined($me->{json})) {
		$me->{json} = JSON->new->allow_nonref;
	}

	my $parsed;
	#printf "%s: json->decode( '%s' ) .. pre\n", $name, $str;

	eval {
		$parsed = $me->{json}->decode( $str );
	};
	if ($@) {
		die(sprintf("%s: json->decode('%s') Error %s\n", $name,
		    $str, $@
));
	}
	return $parsed;
}

sub servers {
	my ($me) = @_;

	my $parsed = $me->get("server");
	if (ref($parsed) eq "HASH") {
		if (defined($parsed->{error})) {
			printf "->get(server): %3d code:%s message:%s\n",
				$parsed->{error}->{status},
				$parsed->{error}->{code},
				$parsed->{error}->{message};
			return;
		}
	}

	if (!defined($parsed)) {
		print "servers parsed: <undef>\n";
		return;
	}
	#print "servers parsed: ".Dumper($parsed)."\n";
	my @servers;
	foreach my $s (@{$parsed}) {
		push @servers, WWW::Hetzner::Server->new(
			hetzner => $me,
			server => $s->{server}
		);
	}
	return @servers;
}

sub ips {
	my ($me) = @_;

	my $parsed = $me->get("ip");

	return $parsed;
}

1;
