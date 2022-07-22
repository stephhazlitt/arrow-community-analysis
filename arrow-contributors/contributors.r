library(gh, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(tidygraph, warn.conflicts = FALSE)
library(ggraph, warn.conflicts = FALSE)

## Simple example
## Additional things to do:
## - ramp up limits
## - explore other orgs like ropensci, r-lib, cran repos on github

## Get some arrow contributors
arrow_contributors_resp <- gh("GET /repos/apache/arrow/contributors", .limit = Inf)
arrow_contributors <- data.frame(
  repo = "arrow",
  arrow_contributors = vapply(arrow_contributors_resp, "[[", "", "login")
)

## let's get some apache repos
apache_repos_resp <- gh(
    "GET /orgs/{org}/repos",
    org = "apache",
    .limit = 40
)
apache_repos <- vapply(apache_repos_resp, "[[", "", "name")

## Get contributors to apache repos
apache_contributors <- lapply(apache_repos, function(repo) {
  contrib <- gh(
    "/repos/{owner}/{repo}/contributors",
    owner = "Apache",
    repo = repo,
    .limit = 300
  )
  data.frame(
    repo_name = repo,
    apache_contributors = vapply(contrib, "[[", "", "login")
  )
}) %>%
  bind_rows()

## join and turn into a tbl_graph
contrib_overlap <- arrow_contributors %>%
  inner_join(apache_contributors, by = c("arrow_contributors" = "apache_contributors")) %>%
  count(repo, repo_name) %>%
  as_tbl_graph()


## plot
ggraph(contrib_overlap, layout = 'kk') +
  geom_edge_fan(aes(colour = n)) +
  geom_node_point(aes(fill = name), size = 3)





gh("https://api.github.com/repos/apache/couchdb/contributors")