## Why using Regex in command line

Your text editor (Sublime) can only handle files up to a certain size. Command line is THE place to go when you have one huge file (>~450,000 lines) or more directories full of huge files.

## Sample data

- ex1. Jeb Bush emails
- ex2. Flint water emails in the `/pdf` directory
- ex3. One batch of Hilary Clinton's emails

## Prep

`make prep`

Once the script is finished you will have installed the command-line tool that we will be using:

- `pdftotext`
- `ack`

## Command line 102

You already know a lot of command-line utilities!

```
cd
ls
touch
mkdir
rm
mv
git
```

### New commands

The following utilities come with your terminal.

#### Redirection

`command input > output`

The `>` takes the input from the left and creates an output named after the right.

#### Pipe

`command input | another-command | yet-another-command`

The `|` processes the results from the first command with the second command, so on and so forth.

We will use these in a second.

#### `sort`

Practice the following with files in `ex0/`.

1. `sort alphabet.txt`
2. `sort -r alphabet.txt`
  - `sort -r alphabet.txt > reverse-alphabet.txt`
3. `sort -n numbers.txt`
4. `sort -t "," -k 3 lead-request-zipcode.csv`

#### `uniq`

How many types of lead kit does the city record?

- `sort lead-request-type.csv | uniq`

How many incidents under each type?

- `sort lead-request-type.csv | uniq -c > lead-type-count.csv`

## Time for `ack`

`ack` is a command-line file pattern searcher that is fast and optimized in a lot of ways. See [why ack](http://beyondgrep.com/why-ack/).

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

### Excercise 1: Jeb's emails

#### Get the phone numbers.

`ack "your pattern" jeb-bush-telephone-number-challenge.txt > number-only.txt`

#### Refine: how to get the numbers without the sentences around it?

Use the `-o` flag to specify that we don't want to print the entire line.

`ack -o "your pattern" ex1/jeb-bush-telephone-number-challenge.txt > ex1/number-only.txt`

*Note*: if you redirect an input to an output and the output name already exists, you will overwrite the previous file. Make sure you name things with care and/or make copies of files important to you.

#### Investigate more: how to get unique numbers?

`ack -o "your pattern" ex1/jeb-bush-telephone-number-challenge.txt | uniq -c > ex1/numbers-only-uniq.txt`

### Excercise 2: Flint emails

We installed something called `pdftotext` to, well, turn pdf files into text files.

Try it with the pdf in `ex2/`.

`pdftotext input > output`

#### Capture the `From:` field

```
ack -o '^From:+(.+)Date' ex2/snyder-flint-water-emails-demo.txt > ex2/flint-email-recipients.txt
```

![](http://cl.ly/0h2y2c22082h/Screen%20Shot%202016-03-31%20at%2010.23.27%20PM.png)

### Exercise 3: Hilary emails

We are going to investigate a batch of Hilary Clinton's email.

`make ex3`

#### Capture the `From:` field

As you see, we are dealing with files that come in 293 individual files instead of one single file.

```
ack -h -m 1 -A 3 '^From: +(.+)' ex3/

```

Notice that for this exercise we are searching a **whole** directory rather than a single file. Here, `ack` is no longer an alternative, but the only tool suitable for the job (since there are many files with a large total size.)

- `-A NUM` flag specifies number of lines to be printed after the matching lines.
- `-m NUM` flag stops searching in each file after NUM matches
- What do you think the `-h` flag does? Try it without `-h`.

#### Find SECRET or CONFIDENTIAL files

Use `-l` flag to only print the filenames of matching files, instead of the matching text.

```
ack -l '\b(SECRET|CONFIDENTIAL)\b' ex3/
```

#### Sort Hilary's email recipients by frequency

Building on the previous exercise:

```
ack -h -m 1 -A 3 '^From: +(.+)' ex3/ > ex3/recipients.txt

```

Here's the challenge:

Now find all the emails in the new file, sort them, find out the count of each email address, and sort by frequency of these recipients.

Use the pipe `|` in your command!

Submit your command here: http://goo.gl/forms/hKgssuslfE

## When is Regex useful in Javascript

Regex is widely used for form validation. You don't really have to write it from scratch. Two ways to validate:

1. [HTML5 form validation](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Data_form_validation)
2. [validate.js](rickharrison.github.io/validate.js/)

## References

- More command line materials available in [this workshop repo](https://github.com/chrislkeller/nicar15-command-line-basics)
- Excercises are modified based on Dan Nguyen's NICAR 2016 Regex [slides](http://regex.danwin.com/slides/#/50). There are a lot of hands-on examples from his talk. Practice them!
