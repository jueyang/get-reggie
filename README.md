## Sample data

1. Jeb Bush emails
2. Flint water emails in the `/pdf` directory

## Prep

`make all`

Once the script is finished you will find relavant text files in the `/txt` directory. It also installs the command line tool that we will be using: `ack`.

## Why using Regex in command line

Your text editor (Sublime) can only handle files up to a certain size. Command Line is THE tool when you have a huge file (>~450,000 lines). While the focus of this session focuses on searching patterns with Regex in Command Line, Command Line's usefulness extends beyond that. For example, you will have no choice but using Command Line when formatting/investigating large csv's (like a year of NYC's 311 filings).

## What is `ack`

A command line file pattern searcher that is fast and optimized in a lot of ways. See [why ack](http://beyondgrep.com/why-ack/).

## Command Line 102

You already know a lot of command line utilities!

```
cd
ls
touch
mkdir
rm
mv
git
```

### New workflow addition

Now it's time to add some new workflow to your command line: **redirection** and *pipe*. A redirection looks like this:

`command input > output`

The `>` takes the input from the left and creates an output named after the right.

And a pipe looks like this:

`command input | another-command | yet-another-command`

The `|` processes the results from the first command with the second command, so on and so forth.

We will use these in a second.

### Using `ack`

Remember how you tried to get all the phone numbers from Jeb's email? You did something like this in Sublime:

1. Search for all the phone numbers in a document with a Regex.
2. Copy all the phone numbers.
3. Create a new document.
4. Paste the phone numbers to that new document.
5. Save the new document with a name.

Now these five steps can be done with `ack` and redirection in one line. The basic `ack` usage looks like this:

`ack "pattern" somefile`

This gives you a preview of the search in the command line. However, to store the search results in a new file, you will use redirection.

`ack "pattern" somefile > resultfile`

## Excercise 1: Jeb's emails

1. Get the phone numbers.

`ack "your pattern" jeb-bush-telephone-number-challenge.txt > number-only.txt`

2. Refine: how to get the numbers without the sentences around it?

Use the `-o` flag to specify that we don't want to print the entire line.

`ack -o "your pattern" ex1/jeb-bush-telephone-number-challenge.txt > ex1/number-only.txt`

*Note*: if you redirect an input to an output and the output name already exists, you will overwrite the previous file. Make sure you name things with care and/or make copies of files important to you.

3. Investigate more: how to get unique numbers?

`ack -o "your pattern" ex1/jeb-bush-telephone-number-challenge.txt | uniq -c > ex1/numbers-only-uniq.txt`

## Excercise 2: Flint emails

1. Capture the `From:` field

```
ack -o '^From:+(.+)Date' ex2/snyder-flint-water-emails-demo.txt > ex2/flint-email-recipients.txt
```

![](http://cl.ly/0h2y2c22082h/Screen%20Shot%202016-03-31%20at%2010.23.27%20PM.png)

## Exercise 3: Hilary emails

1. Capture the `From:` field

What if the files come in 25 individual files instead of one?

- `-A NUM` flag specifies number of lines to be printed after the matching lines.
- `-m NUM` flag stops searching in each file after NUM matches

```
ack -h -m 1 -A 3 '^From: +(.+)' ex3/ > ex3/hilary-email-recipients.txt

```

What do you think the `-h` flag does? Try it without.

**Note**: Notice that for this exercise we are searching a **whole** directory rather than a single file. Here, `ack` is no longer an alternative, but the only tool suitable for the job (since there are many files with a large total size.)

2. Find SECRET or CONFIDENTIAL files

Use `-l` flag to only print the filenames of matching files, instead of the matching text.

```
ack -l '\b(SECRET|CONFIDENTIAL)\b' ex3/
```

3. Sort Hilary's email recipients by frequency

[Building on No.1](http://regex.danwin.com/slides/#/52) or use the file you've created: `ex3/hilary-email-recipients.txt`

## When is Regex useful in Javascript

Regex is widely used for form validation. You don't really have to write it from scratch. Two ways to validate:

1. [HTML5 form validation](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Data_form_validation)
2. [validate.js](rickharrison.github.io/validate.js/)

## References

- More command line materials available in [this workshop repo](https://github.com/chrislkeller/nicar15-command-line-basics)
- Excercises are modified based on Dan Nguyen's NICAR 2016 Regex [slides](http://regex.danwin.com/slides/#/50). There are a lot of hands-on examples from his talk. Practice them!