unit class Template6;

use Template6::Service;

has $.service handles <process context add-path set-extension add-template add-provider>;

submethod BUILD (*%args) {
    $!service = %args<service> || Template6::Service.new(|%args);
}

=begin pod

=head1 NAME

Template6 - A Template Engine for Raku

=head1 SYNOPSIS

=begin code :lang<raku>

use Template6;

=end code

=head1 DESCRIPTION

Inspired by L<Template Toolkit|https://metacpan.org/pod/Template::Toolkit> from Perl,
Template6 is a simple template engine designed to be
a content-neutral template language.

This project does not intend to create an exact clone of
Template Toolkit. Some features from TT are not planned for
inclusion, and likewise, some feature will be included that
are not in TT. Not all features will work the same either.

=head2 Example

Template file templates/simple.tt:

=begin code
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Template6 Example</title>
  </head>
  <body> 
    <h1>Very simiple template</h1>
    <div>Module name: [% name %]</div>
    <div>Tags:
        [% FOR t = tags %] 
            <span>[% t %]</span>
        [% END %]
    </div>
  </body>
</html>
=end code

Render the template with this code:

=begin code
#!/usr/bin/env raku

use Template6;

my $template = Template6.new;
$template.add-path(".");
my %vars = (
    name => "Template6",
    tags => ["template", "raku"],
);
my $output = $template.process("simple.tt".IO, |%vars);
put $output;
=end code

The output looks like this:

=begin code
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Template6 Example</title>
  </head>
  <body>
    <h1>Very simiple template</h1>
    <div>Module name: Template6</div>
    <div>Tags:

            <span>template</span>

            <span>raku</span>

    </div>
  </body>
</html>
=end code

=head2 Currently implemented features

=head3 GET and SET statements, including implicit versions.

=item C<[% get varname %]>
=item C<[% varname %]>
=item C<[% set varname = value %]>
=item C<[% varname = value %]>

=head3 FOR statement.

This replaces the FOREACH statement in TT2.
It can be used in one of four ways:

=item C<[% for listname as itemname %]>
=item C<<[% for listname -> itemname %]>>
=item C<[% for itemname in listname %]>
=item C<[% for itemname = listname %]>

If used with Hashes, you'll need to query the C<.key> or C<.value> accessors.

=head3 IF/ELSIF/ELSE/UNLESS statements.

These are very simplistic at the moment, but work for basic tests.

=item Querying nested data structures using a simple dot operator syntax.
=item CALL and DEFAULT statements.
=item INSERT, INCLUDE and PROCESS statements.

=head2 Differences with Template Toolkit

=item You should use explicit quotes, including in INSERT/INCLUDE/PROCESS directives.
=item UNLESS-ELSE is not supported - Raku also doesn't support this syntax
=item All statement directives are case insensitive.
=item There are no plans for the INTERPOLATE option/style.
=item Anything not yet implemented (see TODO below.)

=head2 Caveats

=item Whitespace control is not implemented, so some things are fairly odd. See TODO.
=item A lot of little nit-picky stuff, likely related to the whitespace issue.

=head2 TODO

=head3 Short Term Goals

=item WRAPPER statement
=item block statements
=item given/when statements
=item Add 'absolute' and 'relative' options to L<Template6::Provider::File|lib/Template6/Provider/File.rakumod>
=item Whitespace control
=item Precompiled/cached templates
=item Tag styles (limited to definable C<start_tag> and C<end_tag>)

=head3 Long Term Goals

=item Filters
=item Variable interpolation (in strings, variable names, etc.)
=item Capture of directive output
=item Directive comments
=item Side-effect notation
=item Multiple directives in a single statement tag set
=item Macros, plugins, etc.

=head2 Possible future directions

I would also like to investigate the potential for an alternative to
L<Template6::Parser|lib/Template6/Parser.rakumod> that generates Raku closures without the use of EVAL.
This would be far trickier, and would not be compatible with the
precompiled templates, but would be an interesting exercise nonetheless.

=head1 AUTHOR

Timothy Totten

=head1 COPYRIGHT AND LICENSE

Copyright 2012 - 2017 Timothy Totten

Copyright 2018 - 2023 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
