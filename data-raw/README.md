## Data Sources

- [Apache Arrow JIRA Issues](https://issues.apache.org/jira/projects/ARROW/issues/)
  - `apache-arrow-jira.json` is a complete export of Apache Arrow JIRA Issues available in the public AWS bucket `s3://voltrondata-labs-datasets/`
  - the `arrow-jira.R` script sources and rectangles the JIRA Issue data
- [Apache Arrow GitHub](https://github.com/apache/arrow) 
- [Arrow Rust](https://github.com/apache/arrow-rs) GitHub
- [Arrow Julia](https://github.com/apache/arrow-julia) GitHub
- ...

Data is sourced using scripts in this `/data-raw` folder with outputs saved to `/data-tidy` for local analysis.

