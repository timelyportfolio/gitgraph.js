# devtools::install_github("timelyportfolio/gitgraphR@R", subdir="pkg")
# devtools::install_github("jennybc/githug")

library(gitgraphR)
library(githug)
library(dplyr)

git_history(n=10) %>%
  mutate(
    branch = git_branch_current(),
    type = "commit"
  ) %>%
  arrange(when) %>%
  gitgraph()


## add some config options
git_history(n=10) %>%
  mutate(
    branch = git_branch_current(),
    type = "commit"
  ) %>%
  arrange(when) %>%
  gitgraph(
    config = list(
      template="metro",
      orientation="horizontal",
      mode="compact"
    )
  )
