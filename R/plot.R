#' Plot spike/Vm trace for a cell using defaults appropriate for Frechter et al
#'
#' @details When the \code{odours} argument is specified, only the first
#'   presentation of any odour is kept. The odours trials will be plotted in the
#'   order requested. It is not possible to plot multiple trials of the same
#'   odour and attempting to do this by listing the same odour twice will result
#'   in an error.
#'
#' @param cellid Any id understandable by \code{\link{anyid2longid}}
#' @param odours Optional ordered character vector of odours (see Details)
#' @inheritParams gphys::PlotRasterFromSweeps
#' @param ... Additional arguments passed to
#'   \code{\link[gphys]{PlotRasterFromSweeps}}
#'
#' @export
#' @seealso \code{\link[gphys]{PlotRasterFromSweeps}},
#'   \code{\link[gphys]{AddLinesToRasterPlot}},
#'   \code{\link[gphys]{subset.spiketimes}}, \code{\link{anyid2longid}}
#' @examples
#' plotcellsf("130208c1", odours=c("OilBl", "E2Hex","Prpyl", "Et3HB", "Cdvrn", "Sprmn"), yaxis=TRUE)
plotcellsf <- function(cellid, yaxis=FALSE, xaxis=FALSE, odours=NULL,
                       PlotDividers=FALSE, ...) {
  cellid=anyid2longid(cellid)
  spikes=physplitdata::Spikes[[cellid]][[1]]
  vmcell=physplitdata::Vm[[cellid]]
  if(!is.null(odours)){
  oddconf=attr(spikes, 'oddconf')
    if(any(duplicated(oddconf$odour))) {
      # we need to remove the dupes for subset by odour to work
      keepchannels=oddconf$chan[!duplicated(oddconf$odour)]
      spikes=subset(spikes, channels=keepchannels)
    }
    spikes=subset(spikes, odours=odours)
    # match the selected channels against the full original list
    # to choose which Vm lines to plot
    vmcell=vmcell[, match(attr(spikes,'oddconf')$chan, oddconf$chan), drop=FALSE]
  }
  PlotRasterFromSweeps(spikes, xlim=c(5,2995), odourRange=c(500,750),
                       ylab="",xlab="", yaxt="n", sub="", main='',
                       stimRange=NULL,dotsize=0.25,ann=T, yaxis=yaxis,
                       xaxis=xaxis,DividerLwd = 0.8,PlotDividers=PlotDividers,
                       ...)
  AddLinesToRasterPlot(vmcell, ylim=c(-65,-35), col='black',lwd=1.5)
}
