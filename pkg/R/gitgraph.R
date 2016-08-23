#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
gitgraph <- function(
  githistory = NULL,
  config = NULL,
  width = NULL, height = NULL,
  elementId = NULL
) {

  # forward options using x
  x = list(
    githistory = githistory,
    config = config
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'gitgraph',
    x,
    width = width,
    height = height,
    package = 'gitgraphR',
    elementId = elementId
  )
}

#' Shiny bindings for gitgraph
#'
#' Output and render functions for using gitgraph within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a gitgraph
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name gitgraph-shiny
#'
#' @export
gitgraphOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'gitgraph', width, height, package = 'gitgraphR')
}

#' @rdname gitgraph-shiny
#' @export
renderGitgraph <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, gitgraphOutput, env, quoted = TRUE)
}
