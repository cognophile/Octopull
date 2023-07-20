# Octopull
 A simple program to extract consumption data from the Octopus API


## Getting Started
### Configuration
To configure the script, duplicate the file named `octopull.config.json.example` and rename it to `octopull.config.json.example`. Enter the details of your Octopus API key and meter details (MPAN, and Serial Number) available in your Octopus account. 

### Execution
To execute the script, issue the following command from the directory you cloned the project to.
```bash
$ ./octopull.sh [format] [from date]
```

The available formats are: 
* JSON - use parameter `json`
* SQL update/insertion - use parameter `sql`

The `from_date` parameter must be in the following format: `YYYY-MM-DDTHH:MM:SSZ`.

### Output
The script will optionally create two files - `octopull.data.json` which is the raw `JSON` data from the Octopus API. And if you elect to convert the data to `SQL`, it'll output a second file named `octopull.output.txt` which contains the `SQL` insertion-formatted records. 