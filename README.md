# Octopull
 A simple program to extract consumption data from the Octopus API


## Getting Started
### Configuration
To configure the script, duplicate the file named `octopull.config.json.example` and rename it to `octopull.config.json.example`. Enter the details of your Octopus API key and meter details (MPAN, and Serial Number) available in your Octopus account. 

### Execution
To execute the script, issue the following command from the directory you cloned the project to.
```bash
$ ./octopull.sh [json|csv|sql] [date]
```

The `from_date` parameter must be in the following format: `YYYY-MM-DDTHH:MM:SSZ`.

### Output
The script will create a file named `octopull.data.json` in the same directory. This is the raw `JSON` data from the Octopus API. 

And if you elect to convert the data to one of the supported formats, it'll output a second in your chosen format (`octopull.data.[ext]]`).
