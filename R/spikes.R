#' Carry out Poisson test on absolute number of spikes in odour response
#'
#' @details This function compares each odour trial with a matching control
#'   (i.e. blank) response. It is assumed that each odour column is matched to
#'   the blank column that most recently preceded it.
#'
#'   When \code{test_each_odour_trial} each single odour trial is compared with
#'   all of the blank trials (making an approoriate adjustment to the time base
#'   for the event counts, see Note in \code{\link{poisson.test}} docs).
#'
#' @param x An m x n odour response matrix for m trials of n odours
#' @param odours Names of odours (defaults to \code{colnames(x)})
#' @param maxtrials Maximum number of trials to consider (default => all)
#' @param test_each_odour_trial Whether to test each odour trial individually
#'   against all blank trials.
#' @param ... Additional parameters passed to \code{poisson.test}
#' @return p values from the Poisson test
#' @export
#' @importFrom stats poisson.test
#' @seealso \code{\link{poisson.test}},
#'   \code{\link[gphys]{OdourResponseFromSpikes}}
#' @examples
#' # calculate summary response for cell 100 for window of 700-1700 ms
#' spikeresp=OdourResponseFromSpikes(Spikes[[100]][[1]], responseWindow=c(700,1700))
#' poissonTestOdoursSF(spikeresp, alternative="greater")
#'
#' \dontrun{
#' spikerespall=sapply(Spikes, function(x) OdourResponseFromSpikes(x[[1]],
#'   responseWindow=c(700,1700)), simplify = F)
#' # significant response (either up or down)
#' spikes.pval=sapply(spikerespall, poissonTestOdoursSF, simplify = F)
#' }
poissonTestOdoursSF<-function(x, odours=colnames(x), maxtrials=NA,
                              test_each_odour_trial=FALSE, ...){
  # we need to find all the blank columns

  blanks_id = grep("(WatBl|OilBl|ClrBL|ClrB2)", colnames(x))
  odours_id=match(odours, colnames(x))
  odours_id=setdiff(odours_id, blanks_id)
  names(odours_id)=colnames(x)[odours_id]

  # find the blank for each odour
  blankidxs_for_odour=findInterval(odours_id, blanks_id)
  if(any(blankidxs_for_odour<1))
    stop("Unable to find blank for: ",
         paste(names(odours_id)[blankidxs_for_odour<1], collapse=","))
  blanks_for_odour=blanks_id[blankidxs_for_odour]

  if(!is.na(maxtrials) & maxtrials<nrow(x)) x=x[1:maxtrials,]
  simple_poisson<-function(od, odcol, blankcol, ...){
    if(sum(!is.na(od))==0) return(NA)
    sum_blank_counts=sum(od[,blankcol],na.rm=T)
    if(test_each_odour_trial) {
      nblanks=length(od[,blankcol])
      # test each odour trial separately
      pval <- sapply(od[,odcol], function(x) poisson.test(c(x, sum_blank_counts), T=c(1,nblanks))$p.value)
    } else {
      sum_odour_counts=sum(od[,odcol],na.rm=T)
      pval<-poisson.test(c(sum_odour_counts,sum_blank_counts),...)$p.value
    }
    ifelse(is.na(pval),1,pval)
  }
  mapply(simple_poisson, odours_id, blanks_for_odour, MoreArgs = list(od=x, ...))
}
