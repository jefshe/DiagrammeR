#' Determine whether a specified node is present
#'
#' From a graph object of class \code{dgr_graph}, determine whether a specified
#'   node is present.
#' @inheritParams render_graph
#' @param node either a node ID value or a node label to test for presence in
#'   the graph.
#' @return a logical value.
#' @examples
#' # Create a simple graph with
#' # a path of four nodes
#' graph <-
#'   create_graph() %>%
#'   add_path(
#'     n = 4,
#'     type = "path",
#'     label = c(
#'       "one", "two",
#'       "three", "four"))
#'
#' # Determine if there is a node
#' # with ID `1` in the graph
#' graph %>%
#'   is_node_present(node = 1)
#'
#' # Determine if there is a node
#' # with ID `5` in the graph
#' graph %>%
#'   is_node_present(node = 5)
#'
#' # Determine if there is a node
#' # with label `two` in the graph
#' graph %>%
#'   is_node_present(node = "two")
#' @export
is_node_present <- function(graph,
                            node) {

  # Get the name of the function
  fcn_name <- get_calling_fcn()

  # Validation: Graph object is valid
  if (graph_object_valid(graph) == FALSE) {

    emit_error(
      fcn_name = fcn_name,
      reasons = "The graph object is not valid")
  }

  # Stop function if `node` not a single value
  if (length(node) != 1) {

    emit_error(
      fcn_name = fcn_name,
      reasons = "Only a single node can be queried using `is_node_present()`")
  }

  if (inherits(node, "character")) {

    # Determine whether the label value
    # corresponds to a label in the graph
    node_is_present <-
      ifelse(node %in% graph$nodes_df$label, TRUE, FALSE)

    return(node_is_present)
  }

  if (inherits(node, "numeric")) {

    # Determine whether the node ID value
    # corresponds to a node ID in the graph
    node_is_present <-
      ifelse(node %in% get_node_ids(graph), TRUE, FALSE)

    return(node_is_present)
  }
}
