library(arrow)
library(aws.s3)
library(jsonlite)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(here)

## S3 with arrow -----------------------------------------------
# bucket <- s3_bucket("voltrondata-labs-datasets")
# bucket$ls()
#
# #does not work
# df <- read_json_arrow(bucket$path("apache-arrow-jira.json"))
#
# #does not work
# arrow_jira_raw <- tempfile(fileext = ".json")
# copy_files(bucket$path("apache-arrow-jira.json"),
#            arrow_jira_raw)
# df <- read_json_arrow(arrow_jira_raw)
# df <- fromJSON(arrow_jira_raw, simplifyDataFrame = FALSE)


## S3 with aws.s3 -----------------------------------------------
arrow_jira_raw <- tempfile(fileext = ".json")

save_object(object = "apache-arrow-jira.json",
            bucket = "s3://voltrondata-labs-datasets/",
            file = arrow_jira_raw)


## read json with jsonlite --------------------------------------
arrow_list <- fromJSON(arrow_jira_raw, simplifyDataFrame = FALSE)


## rectangle the list -------------------------------------------
#list to tibble
arrow_tibble <- tibble(issues = arrow_list)

#unnesting lists in lists
arrow_df <-
  arrow_tibble |>
  unnest_wider(issues, names_repair = "unique") |>
  select(key,
         fields) |>
  unnest_longer(fields, names_repair = "unique") |>
  pivot_wider(id_cols = key,
              names_from = fields_id,
              values_from = fields) |>
  select(
    arrow_key = key,
    resolution,
    priority,
    assignee,
    status,
    components,
    labels,
    creator,
    # subtasks,
    reporter,
    issuetype,
    issuelinks,
    resolutiondate,
    created,
    updated,
    summary,
    parent
  )

#wrangle the components
comps <- arrow_df |>
  select(arrow_key, components) |>
  unnest(components) |>
  hoist(components, name = "name") |>
  select(-components) |>
  group_by(arrow_key) %>%
  mutate(variables = paste0('arrow_comp_', row_number())) %>%
  pivot_wider(id_cols = arrow_key,
              names_from = variables,
              values_from = name) |>
  as.data.frame()

#wrangle the labels
df_labels <- arrow_df |>
  select(arrow_key, labels) |>
  mutate(labels = sapply(labels, toString))

nmax <- max(str_count(df_labels$labels, "\\,")) + 1

arrow_labels <- df_labels |>
  separate(labels,
           paste0("arrow_label", seq_len(nmax)),
           sep = "\\,",
           fill = "right")

#hoist from list-columns and put all together
arrow_rectangle <- arrow_df |>
  select(-components,-labels) |>
  hoist(resolution, arrow_resolved = "name") |>
  select(-resolution) |>
  hoist(priority, arrow_priority = "name") |>
  select(-priority) |>
  hoist(
    issuelinks,
    arrow_related_issue_outward = list(1L, "outwardIssue", "key"),
    arrow_related_issue_inward = list(1L, "inwardIssue", "key")
  ) |>
  select(-issuelinks) |>
  hoist(assignee, arrow_assignee = "name") |>
  select(-assignee) |>
  hoist(status, arrow_status = "name") |>
  select(-status) |>
  hoist(creator, arrow_creator = "name") |>
  select(-creator) |>
  hoist(reporter, arrow_reporter = "name") |>
  select(-reporter) |>
  hoist(issuetype, arrow_issue_type = "name") |>
  select(-issuetype) |>
  hoist(parent, arrow_parent_ticket = "key") |>
  select(-parent) |>
  hoist(summary, arrow_summary = 1L) |>
  hoist(created, arrow_created = 1L) |>
  hoist(updated, arrow_updated = 1L) |>
  hoist(resolutiondate, arrow_resolution_date = 1L) |>
  left_join(comps) |>
  left_join(arrow_labels) |>
  mutate(
    arrow_created = as_date(arrow_created),
    arrow_updated = as_date(arrow_updated),
    arrow_resolution_date = as_date(arrow_resolution_date)
  )

#write rectangle to /data-tidy
write_csv_arrow(arrow_rectangle, here::here("data-tidy/arrow-jira-issues.csv"))
