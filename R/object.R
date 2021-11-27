
#' The divsum Class
#'
#' The divsum object contents the divsum output from ReaptMasker script calcDivergenceFromAlign.pl
#'
#' @slot divergence Weighted average Kimura divergence for each repeat family
#' @slot coverage Coverage for each repeat class and divergence (Kimura)
#' @slot species species full name
#' @slot genome_size genome size
#' @name divsum-class
#' @rdname divsum-class
#' @concept objects
#' @exportClass divsum
#'
divsum <- setClass(
  Class = "divsum",
  slots = list(
    divergence = "data.frame",
    coverage = "data.frame",
    species = "character",
    genome_size = "numeric"
  )
)

#' Creat divsum object
#' @description creat divsum object
#' @param file divsum file
#' @param species species full name
#' @param genome_size genome size
#' @importFrom methods new
#' @importFrom stringr str_detect
#' @importFrom utils read.table
#' @return Returns a meta_data object
#'
#' @export
#' @concept objects
#'
set_divsum <- function(file,species,genome_size) {
  divsum_file_content <- readLines(file)
  tabel_1_start <- which(stringr::str_detect(divsum_file_content,"^-"))+1
  tabel_1_end <- which(stringr::str_detect(divsum_file_content,"^Coverage for each repeat class and divergence"))-1
  divsum_table_1_str <-divsum_file_content[tabel_1_start:tabel_1_end]
  divsum_table_1 <- read.table(text=divsum_table_1_str)
  names(divsum_table_1)<-c("Class", "Repeat", "absLen", "wellCharLen", "Kimura%")
  tabel_2_start = tabel_1_end +2
  tabel_2_end <- length(divsum_file_content)
  divsum_tabel_2_str <- divsum_file_content[tabel_2_start:tabel_2_end]
  divsum_tabel_2 <- read.table(text=divsum_tabel_2_str,header=T,check.names=FALSE)
  object <- new("divsum",divergence = divsum_table_1, coverage = divsum_tabel_2, species = species, genome_size = genome_size)
  return(object)
}


