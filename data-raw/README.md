## Data Sources

- [Apache Arrow JIRA Issues](https://issues.apache.org/jira/projects/ARROW/issues/)
  - `apache-arrow-jira.json` is a complete static export of Apache Arrow JIRA Issues available in the public AWS bucket `s3://voltrondata-labs-datasets/`
  - the `arrow-jira.R` script sources and rectangles the JIRA Issue data&mdash;you can run the script and save the output locally, or grab the output (manually) uploaded to the same bucket (bucket = `s3://voltrondata-labs-datasets/`, file = `arrow-jira-issues.csv`)
- [Apache Arrow GitHub](https://github.com/apache/arrow) 
  - Arrow GitHub data can be sourced using the [GitHub REST API](https://docs.github.com/en/rest) via the [{gh} package](https://github.com/r-lib/gh), the `arrow-gh.R` script is a start, grabbing the commits from the `apache/arrow` repo
  - You can run the script and save the output locally, or to not be too demanding with the API, grab the output (manually) uploaded to the same bucket (bucket = `s3://voltrondata-labs-datasets/`, file = `arrow-commits.csv`)
- [Arrow Rust GitHub](https://github.com/apache/arrow-rs) 
- [Arrow Julia GitHub](https://github.com/apache/arrow-julia)
- ...

Data is sourced using scripts in this `/data-raw` folder with outputs saved to `/data-tidy` for local analysis.

