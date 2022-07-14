[![](https://img.shields.io/badge/Lifecycle-Exploration-yellow)![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


# Apache Arrow Community Analysis

Use Jira and GitHub data to answer questions about the open source Apache Arrow community.

### Why?

- Get a sense of Arrow’s history with quantitative measures
- Use data to help the project continue to grow successfully
- Prototype metrics that might be interesting to [share with the community](https://arrow.apache.org/blog/2022/05/15/8.0.0-release/)


### What?

Some potential questions:

- How do new contributors come into the project?
- How often are first contributions on tickets created by the new contributor versus someone else? How many of the latter were labeled as “good-first-issue”?
- How many available issues (open, unassigned) are labeled as “good-first-issue” at any given time?
- How many contributors make a second PR?
- Which components of the project receive new contributors?
- How are components maintained?
- For each component, who reviews and/or merges each PR? How many unique reviewers are there for each component?
- What’s the ratio of open PRs to committers for each component?
- What’s the rate of Arrow contributions over time? How does that vary by components?

### How?

Do the above exploration using Arrow as much as possible, while keeping in mind the questions:

- What could we improve about the interface for working with nested data?
- What could we improve about the interface for working with time-series data?

### Potential Data Sources

- [x] [Apache Arrow JIRA Issues](https://issues.apache.org/jira/projects/ARROW/issues/) raw data (@stephhazlitt to add `.json` to a public AWS bucket)
- [x] Apache Arrow JIRA Issues tidy data (@stephhazlitt to add tidied tabular data a public AWS bucket)
- [ ] [Apache Arrow](https://github.com/apache/arrow) GitHub Pull Request+Commit data
- [ ]  [Arrow Rust](https://github.com/apache/arrow-rs) and [Arrow Julia](https://github.com/apache/arrow-julia) GitHub Pull Request+Commit data
- [ ] [Arrow Rust](https://github.com/apache/arrow-rs) and [Arrow Julia](https://github.com/apache/arrow-julia) GitHub Issue data



### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/stephhazlitt/barrow-jira-exploration/issues/).


### How to Contribute

If you would like to contribute to this data exploration, please fork this repository, make a branch, commit your code and submit a pull request. While this is _not_ an Apache Arrow repository, the intent is to explore public Apache Arrow JIRA data, so by participating in this work you agree to abide by the Apache Arrow [Code of Conduct](https://www.apache.org/foundation/policies/conduct.html).

