# devtools::install_github("timelyportfolio/gitgraphR")
# devtools::install_github("jennybc/githug")

library(gitgraphR)
library(githug)
library(dplyr)
library(tidyr)
library(tibble)

git_history(n=10) %>%
  mutate(
    branch = git_branch_current(),
    type = "commit"
  ) %>%
  arrange(when) %>%
  tibble::rownames_to_column("id") %>%
  nest(-id,-branch,-type) %>%
  mutate(details = lapply(data,function(x) as.list(unlist(x)))) %>%
  gitgraph()


## add some config options
git_history(n=10) %>%
  mutate(
    branch = git_branch_current(),
    type = "commit"
  ) %>%
  arrange(when) %>%
  tibble::rownames_to_column("id") %>%
  nest(-id,-branch,-type) %>%
  mutate(details = lapply(data,function(x) as.list(unlist(x)))) %>%
  gitgraph(
    config = list(
      template="metro",
      orientation="horizontal",
      mode="compact"
    )
  )


## add other git activity
gh <- git_history(n=10) %>%
  mutate(
    branch = git_branch_current(),
    type = "commit"
  ) %>%
  arrange(when) %>%
  tibble::rownames_to_column("id") %>%
  nest(-id,-branch,-type) %>%
  mutate(details = lapply(data,function(x) as.list(unlist(x))))

# use a different branch for the first 8 commits
gh[1:8,]$branch <- "develop"

# see the effect of two branches
#   branches are created on JS side automatically
#   when first encountered
gitgraph(gh)

# add merge
add_row(
  gh,
  id = nrow(gh) + 1,
  branch = "develop",
  type = "merge",
  details = list(list(branch="R"))
) %>%
  gitgraph()

