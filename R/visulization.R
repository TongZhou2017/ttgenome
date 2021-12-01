#' p3
#' p3
#' @param object divsum object
#' @param sublabel sublabel TRUE/FALSE
#' @param keep_unknown keep unknown TRUE/FALSE
#' @param width bar width
#' @param palette color set: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
#' @import dplyr
#' @import ggplot2
#' @import reshape2
#' @import cowplot
#' @export

p3 <- function(object,sublabel=FALSE,keep_unknown=TRUE,width=0.5,palette="Accent"){
  if(sublabel){
    if(keep_unknown){
      p <- object@coverage %>% melt("Div") %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=variable)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot() + labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }else{
      p <- object@coverage %>% melt("Div") %>% filter(variable != "Unknown") %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=variable)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }
  }else{
    if(keep_unknown){
      p <- object@coverage %>% melt("Div") %>% mutate(group = stringr::str_remove(variable,"/.*$")) %>% mutate(group = stringr::str_remove(group,"\\?")) %>% filter(group %in% c("DNA","LINE","LTR","SINE","Unknown")) %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=group)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+scale_fill_brewer(palette=palette)+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }else{
      p <- object@coverage %>% melt("Div") %>% mutate(group = stringr::str_remove(variable,"/.*$")) %>% mutate(group = stringr::str_remove(group,"\\?")) %>% filter(group %in% c("DNA","LINE","LTR","SINE")) %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=group)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+scale_fill_brewer(palette=palette)+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }
  }
  return(p)
}
