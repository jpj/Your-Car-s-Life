package _pview::view::include::pageHeader_html;

use strict;

sub new {
	my $class = shift;
	my $self = {
		attributes => {}
	};
	bless $self, $class;
	return $self;
}

sub setAttribute {
	my $self = shift;
	my $name = shift;
	my $value = shift;

	$self->{attributes}->{$name} = $value;
}

sub getAttribute {
	my $self = shift;
	my $name = shift;
	return $self->{attributes}->{$name};
}

sub printView {
	my $self = shift;
	my $request = shift;
	my $modiBuffer = "";
	
$modiBuffer .= qq();

my $user = $request->getSession()->getAttribute("user");
my $loggedIn = $user ? 1 : 0;

$modiBuffer .= qq(
	</head>
	<body>

		<div>
			<form action="login0" method="post" id="loginForm">
			<a href="/">Index</a> -

);
	if ($loggedIn) { 
$modiBuffer .= qq(

			Logged in as
			);
 print $user->getFirstName(); 
$modiBuffer .= qq(,
			<a href="/logout0" id="logout">Logout</a>
			<span id="logoutMessage"></span>
);
	} else { 
$modiBuffer .= qq(
				<input type="text" name="login" title="User Name" class="suggestion" />
				<input type="password" name="password" title="password" class="suggestion" />
				<span class="loginMessage"></span>
				<input type="submit" value="Login" />
);
	} 
$modiBuffer .= qq(
			</form>
		</div>

);
	if ($loggedIn) { 
$modiBuffer .= qq(

		<ul>
			<li><a href="/vehicle-log">Log</a></li>
			<li><a href="/manage-vehicles">Vehicles</a></li>
		</ul>
);
	} 
$modiBuffer .= qq(
);

	return $modiBuffer;
}

1;
