#!/usr/bin/env perl

# Convert ASCII to correct Unicode quotes based on context
while (<>) {
  s#(?<!\s)'(?!\s)#’#g;
  s#(?<!\s)'(?=\s)#’#g;
  s#(?<=\s)'(?!\s)#‘#g;
  s#(?<=\s)"(?!\s)#“#g;
  s#(?<!\s)"(?=\s)#”#g;
  print;
}
