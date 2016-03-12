## Sample data

Hilary Email May Release (Benghazi commitee)

## To get these emails as text files in a directory

`make all`

Once the script is finished you will find relavant text files in the `/text` directory. It also installs the command line tool that we will be using: `ack`.

## Now it's regex time

Capturing the `From:` field

`ack -h -m 1 -A3 '^From: +(.+)' txt/`

Modified based on Dan Nguyen's NICAR 2016 Regex [slides](http://regex.danwin.com/slides/#/50)
