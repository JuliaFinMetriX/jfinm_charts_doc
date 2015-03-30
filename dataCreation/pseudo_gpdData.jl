using TimeData
using WorldBankDataTd
using Docile

include("../src/randomize.jl")
 
## download data
dataRaw = WorldBankDataTd.wdi(["NY.GNP.PCAP.CD"],
                           ["BR", "US", "DE"])
 
## convert to wide format
df = convert(DataFrame, dataRaw)
dfWide = unstack(df, :idx, :iso2c, symbol("NY.GNP.PCAP.CD"))
data = Timenum(dfWide[:, 2:end], dfWide[:, 1])
 
## apply randomization
nObs = size(data, 1)

randomizedData = map(x -> randomizeSorted(x, 0.3), eachcol(data))
randomizedDataTm = convert(Timenum, randomizedData)
randomizedDataTm .- data
 
## write data to disk
writeTimedata("../data/pseudo_gdpData.csv", randomizedDataTm)
