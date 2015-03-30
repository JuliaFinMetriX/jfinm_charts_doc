## preserving time trend
@doc doc"""
Get mean absolute change of consecutive observations. Add normally
distributed noise for each day, where noise variance is given by a
scaled version of the mean absolute changes.
"""->
function randomizeSorted(da::DataArray, factor::Float64=2.0)
 
    ## get mean absolute change
    mnChg = mean(dropna(diff(da)))
 
    ## add half of mean change
    nObs = size(da, 1)
    return da + randn(nObs).*(sqrt(mnChg/factor))
end

@doc doc"""
For stationary data, get the variance of the data, and add normally
distributed noise to each observation. Noise will have a variance
equal to the variance of the data scaled by a factor.
"""->
function randomize(da::DataArray, factor::Float64=2.0)
    ## get variation
    dataVar = var(dropna(diff(da)))
 
    ## add quarter of variance
    nObs = size(da, 1)
    return da + randn(nObs).*(sqrt(dataVar)/factor)
end
