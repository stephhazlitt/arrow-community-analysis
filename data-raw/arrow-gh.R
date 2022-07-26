library(gh)
library(tidyr)
library(tibble)
library(dplyr)
library(arrow)

## function to rectangle commits list returned from gh api
tidy_commits <- function(data){
  tibble(commits = data) |>
    unnest_wider(commits) |>
    hoist(commit, date = list("committer", "date")) |>
    hoist(commit, name_committer = list("committer", "name")) |>
    hoist(commit, name_author = list("author", "name")) |>
    hoist(commit, message = list("message")) |>
    select(sha, datetime = date, name_committer, name_author, message) |>
    mutate(date = as.Date(datetime))
}

## apache/arrow commits
commits_arrow <-
  gh("/repos/apache/arrow/commits", owner = "apache", repo = "arrow",
     state = "all", .limit = Inf)

commits_arrow_df <- tidy_commits(commits_arrow)

write_csv_arrow(commits_arrow_df,
                here::here("data-tidy/arrow-commits.csv"))

