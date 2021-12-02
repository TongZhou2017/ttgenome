#' p3
#' p3
#' @param object divsum object
#' @param sublabel sublabel All, 4, 6
#' @param keep_unknown keep unknown TRUE/FALSE
#' @param width bar width
#' @param palette color set: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
#' @import dplyr
#' @import ggplot2
#' @import reshape2
#' @import cowplot
#' @export

p3 <- function(object,sublabel=4,keep_unknown=TRUE,width=0.5,palette="Accent"){
  if(sublabel=="All"){
    if(keep_unknown){
      p <- object@coverage %>% melt("Div") %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=variable)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot() + labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }else{
      p <- object@coverage %>% melt("Div") %>% filter(variable != "Unknown") %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=variable)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }
  }else{
    subset <- c("DNA","LINE","LTR","SINE","Satellite","Simple_repeat")[1:sublabel]
    if(keep_unknown){
      p <- object@coverage %>% melt("Div") %>% mutate(group = stringr::str_remove(variable,"/.*$")) %>% mutate(group = stringr::str_remove(group,"\\?")) %>% filter(group %in% c(subset,"Unknown")) %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=group)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+scale_fill_brewer(palette=palette)+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }else{
      p <- object@coverage %>% melt("Div") %>% mutate(group = stringr::str_remove(variable,"/.*$")) %>% mutate(group = stringr::str_remove(group,"\\?")) %>% filter(group %in% subset) %>% ggplot(aes(x=Div,y=value/object@genome_size*100,fill=group)) + geom_bar(stat="identity",width=width)+cowplot::theme_cowplot()+scale_fill_brewer(palette=palette)+ labs(x="Kimura substitution level (CpG adjusted)",y="Percent of genome (%)",title = object@species)
    }
  }
  return(p)
}
