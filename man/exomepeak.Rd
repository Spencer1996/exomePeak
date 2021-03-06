\name{exomepeak}
\alias{exomepeak}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{exomepeak}
\description{
This is the main function of exomePeak R-package, which supports the processing of affinity-based epitranscriptome sequencing data from MeRIP-Seq (m6A-Seq). The main features of the function includes: 

1. Accept and statistically supports multiple biological replicates

2. Remove possible PCR artifacts and mapping ambiguity caused by multi-reads (reads that can be mapped to multiple genomic locations)

3. Peak calling (binding sites detection) and comparison of two experimental conditions (differential analysis)

4. Automatic association of genes and the binding sites; Optionally output the intermediate results in Rdata format

The package features a highly simplied procedure with a single command accomplishing all its functions.
}
\usage{
exomepeak(IP_BAM, INPUT_BAM, 
          GENOME = NA,
          UCSC_TABLE_NAME = "knownGene",
          GENE_ANNO_GTF = NA,
          TXDB = NA, 
          TREATED_IP_BAM = character(0), 
          TREATED_INPUT_BAM = character(0), 
          OUTPUT_DIR = NA, EXPERIMENT_NAME = "exomePeak_output", 
          WINDOW_WIDTH = 200, SLIDING_STEP = 30, 
          FRAGMENT_LENGTH = 100, READ_LENGTH = NA, 
          MINIMAL_PEAK_LENGTH = FRAGMENT_LENGTH/2, 
          PEAK_CUTOFF_PVALUE = NA, 
          PEAK_CUTOFF_FDR = 0.05, FOLD_ENRICHMENT = 1, 
          CONSISTENT_PEAK_CUTOFF_PVALUE = 0.05, 
          CONSISTENT_PEAK_FOLD_ENRICHMENT = 1, 
          DIFF_PEAK_METHOD = "rhtest", 
          DIFF_PEAK_CUTOFF_PVALUE = NA, 
          DIFF_PEAK_CUTOFF_FDR = 0.05, 
          DIFF_PEAK_ABS_FOLD_CHANGE = 1, 
          DIFF_PEAK_CONSISTENT_CUTOFF_PVALUE = 0.05, 
          DIFF_PEAK_CONSISTENT_ABS_FOLD_CHANGE = 1, 
          MINIMAL_MAPQ = 30, REMOVE_LOCAL_TAG_ANOMALITIES = TRUE, 
          POISSON_MEAN_RATIO = 1, TESTING_MODE = NA, 
          SAVE_RESULT_ON_DISK = TRUE)
}
%- maybe also 'usage' for other objects documented here.
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{IP_BAM}{ a vector of file names, which specifies a number of IP samples from the untreated condition in bam format
%%     ~~Describe \code{IP_BAM} here~~
}
  \item{INPUT_BAM}{a vector of file names, which specifies a number of Input control samples from the untreated condition in bam format
%%     ~~Describe \code{INPUT_BAM} here~~
}
  \item{GENOME}{ a string,such as "hg19" or "mm9", which specifies the genome assembly used. If a gene annotation file is provided, the exomepeak will call peaks with it; otherwise, exomepeak will 
 			download the gene annotation from UCSC using the genome assembly specified here and the gene annotation table specified in "UCSC_TABLE_NAME".
%%     ~~Describe \code{GENE_ANNO_GTF} here~~
}
  \item{UCSC_TABLE_NAME}{ a string, which specifies the gene annotation used from UCSC, default: "knownGene". Please use function: supportedUCSCtables() to check available tables.
	Some tables may not be available for all genomes, and the "refGene" table doesn't work correctly due to multiple occuences of the same transcript on the same chromosome.
%%     ~~Describe \code{GENE_ANNO_GTF} here~~
}
  \item{GENE_ANNO_GTF}{ a string, which specifies a gene annotation GTF file if available, default: NA
%%     ~~Describe \code{GENE_ANNO_GTF} here~~
}
  \item{TXDB}{ an optional TxDb object for gene annotation information used in the analysis, default: NA. The exomepeak function will 
	first look at TXDB, then GENE_ANNO_GTF, and then GENOME for gene annnotation information. Please refere to "GenomicFeatures" package for more details about the "TxDb" object.
%%     ~~Describe \code{GENE_ANNO_GTF} here~~
}
  \item{TREATED_IP_BAM}{ a vector of file names, which specifies a number of IP samples from the treated condition in bam format, default: character(0)
%%     ~~Describe \code{TREATED_IP_BAM} here~~
}
  \item{TREATED_INPUT_BAM}{a vector of file names, which specifies a number of Input control samples from the treated condition in bam format,  default: character(0)
%%     ~~Describe \code{TREATED_INPUT_BAM} here~~
}
  \item{OUTPUT_DIR}{ a string, which specifies the output directory, default: getwd(). By default, exomePeak will output results both 1. as BED/XLS files on disk and 2. returned GRangesList object under the R environment.
%%     ~~Describe \code{OUTPUT_DIR} here~~
}
  \item{EXPERIMENT_NAME}{ a string, which specifies folder name generated in the output directory that contains all the results, default: "exomePeak_output"
%%     ~~Describe \code{EXPERIMENT_NAME} here~~
}
  \item{WINDOW_WIDTH}{ an integer, which specifies the window width of the sliding window, default: 200
%%     ~~Describe \code{WINDOW_WIDTH} here~~
}
  \item{SLIDING_STEP}{ an integer, which specifies the step of the sliding window, use a smaller number for better resolution, default: 30
%%     ~~Describe \code{SLIDING_STEP} here~~
}
  \item{FRAGMENT_LENGTH}{ an integer, which specifies the fragment length in the library preparation, default: 100
%%     ~~Describe \code{FRAGMENT_LENGTH} here~~
}
  \item{READ_LENGTH}{ an integer, which specifies the read length in bam file, default: automatically check the first IP sample 
%%     ~~Describe \code{READ_LENGTH} here~~
}
  \item{MINIMAL_PEAK_LENGTH}{ an integer, which specifies the minimal peak length to be reported, default: FRAGMENT_LENGTH/2
%%     ~~Describe \code{MINIMAL_PEAK_LENGTH} here~~
}
  \item{PEAK_CUTOFF_PVALUE}{ a decimal number, which specifies the p-value cut-off in the peak detection algorithm, default: 1e-5
%%     ~~Describe \code{PEAK_CUTOFF_PVALUE} here~~
}
  \item{PEAK_CUTOFF_FDR}{ a decimal number, which specifies the fdr cut-off in the peak detection algorithm. If it is specified, then use "fdr" instead of "p" in peak calling
%%     ~~Describe \code{PEAK_CUTOFF_FDR} here~~
}
  \item{FOLD_ENRICHMENT}{ a decimal number, which specifies the minimal fold enrichment in the peak calling process. default: 1 
%%     ~~Describe \code{FOLD_ENRICHMENT} here~~
}
  \item{CONSISTENT_PEAK_CUTOFF_PVALUE}{ used when calling consistent peak. a decimal number, which specifies the p-value cut-off in the peak detection algorithm for each individual sample. All samples must satisfy this cut-off, default: 0.05
%%     ~~Describe \code{CONSISTENT_PEAK_CUTOFF_PVALUE} here~~
}
  \item{CONSISTENT_PEAK_FOLD_ENRICHMENT}{ used when calling consistent peak. a decimal number, which specifies the fdr cut-off in the peak detection algorithm for each individual sample. All samples must satisfy this cut-off. If it specified, use "fdr" instead of "p"
%%     ~~Describe \code{CONSISTENT_PEAK_FOLD_ENRICHMENT} here~~
}
  \item{DIFF_PEAK_METHOD}{ "bltest" (binomial likelihood ratio test) or "rhtest" (rescaled hypergeometric test), default: "rhtest"
%%     ~~Describe \code{CONSISTENT_PEAK_FOLD_ENRICHMENT} here~~
}
  \item{DIFF_PEAK_CUTOFF_PVALUE}{ a decimal number, which specifies the p-value cut-off in the comparison of two conditions. If it specified, use "p" instead of "fdr" 
%%     ~~Describe \code{DIFF_PEAK_CUTOFF_PVALUE} here~~
}
  \item{DIFF_PEAK_CUTOFF_FDR}{  a decimal number, which specifies the fdr cut-off in the comparison of two conditions. default: 0.05
%%     ~~Describe \code{DIFF_PEAK_CUTOFF_FDR} here~~
}
  \item{DIFF_PEAK_ABS_FOLD_CHANGE}{ a decimal number, which specifies the minimal fold change in the differential analysis. default: 1 
%%     ~~Describe \code{DIFF_PEAK_ABS_FOLD_CHANGE} here~~
}
  \item{DIFF_PEAK_CONSISTENT_CUTOFF_PVALUE}{ used when calling consistent differential peak. a decimal number, which specifies the p-value cut-off in the differential peak detection algorithm for each individual sample. All samples must satisfy this cut-off. If it specified, use "p" instead of "fdr".
%%     ~~Describe \code{DIFF_PEAK_CONSISTENT_CUTOFF_PVALUE} here~~
}
  \item{DIFF_PEAK_CONSISTENT_ABS_FOLD_CHANGE}{ used when calling consistent differential peak. a decimal number, which specifies the fdr cut-off in the differential peak detection algorithm for each individual sample. All samples must satisfy this cut-off. default: 0.05
%%     ~~Describe \code{DIFF_PEAK_CONSISTENT_ABS_FOLD_CHANGE} here~~
}
  \item{MINIMAL_MAPQ}{ the reads used in the analysis, MAPQ "NA" is consider as 255, default: 30
%%     ~~Describe \code{MINIMAL_MAPQ} here~~
}
  \item{REMOVE_LOCAL_TAG_ANOMALITIES}{a logic variable, which specifies whether remove local tag annomalities, default: TRUE
%%     ~~Describe \code{REMOVE_LOCAL_TAG_ANOMALITIES} here~~
}
  \item{POISSON_MEAN_RATIO}{ a decimal number, which specifies the Poisson mean ratio in ctest, default: 1
%%     ~~Describe \code{POISSON_MEAN_RATIO} here~~
}
  \item{TESTING_MODE}{ for testing only, an integer used when test whether the package is running correctly, use 100 to get peaks on only the first 100 annotations for a fast test run, default: NA
%%     ~~Describe \code{TESTING_MODE} here~~
}
  \item{SAVE_RESULT_ON_DISK}{ a logic variable, which indicates whether or not save the result on disk in BED/XLS format as well, default: TRUE.
  By default, exomePeak will output results both 1. as BED/XLS files on disk and 2. returned GRangesList object under the R environment.
%%     ~~Describe \code{SAVE_INTERMEDIATE_RESULT} here~~
}
}

\details{
The exomePeak function is an all-in-one command that performs all the core functions of the exomePeak R-package. 

For peak calling purpose, it requires the IP and input control samples:
An IP sample is the aligned BAM file from the immunoprecipitated sample using RNA modification antibodies such as anti-m6A; 
The input control sample is the aligned BAM file from the total RNAseq shotgun sequencing.

For differential analysis or comparing two conditions, besides the IP & input samples (from the untreated condition), it also require the IP & input samples from a different condition or the "treated" condition, such as with disease or after subjected to heat shock treatment.
}

\value{
By default, exomePeak will output results both 

1. as BED/XLS files on disk (default: "exomePeak_output") under the specified directory (default: current working directory). 

2. returned GRangesList object under the R environment.


For the files saved on the disk:

1. If there are only samples from one condition, then detected peaks (RNA methylation sites) and consistent peaks will be reported; 

2. If there are samples from two experimental conditions, then detected peaks, significantly differential peaks and consistent differential peaks will be reported in bed and xls formats.

For the returned GRangesList objects:

1. for peak calling when data from one condition is available, the function returns peaks and consistent peaks, and the other information generated in the peak calling process can be accessed with the "mcols" command.

2. for peak calling and differential peaks when data from two condition is available, the function returns peaks, differential peaks on the merged samples (not necessarily consistent on all replicates), and a list of differential peaks consistent for every replicates (recommended list); and the other information generated in differential analysis can be accessed with the "mcols" command.

}
\references{
Meng, Jia, Xiaodong Cui, Manjeet K. Rao, Yidong Chen, and Yufei Huang. "Exome-based analysis for RNA epigenome sequencing data." Bioinformatics 29, no. 12 (2013): 1565-1567.
}

\examples{
# the exomePeak R-package has two main functions:
# 1. peak detection
# 2. comparison of two conditions
# please feel free to contact jia.meng@hotmail.com for any questions

# specify the parameters
GENE_ANNO_GTF=system.file("extdata", "example.gtf", package="exomePeak")
f1=system.file("extdata", "IP1.bam", package="exomePeak")
f2=system.file("extdata", "IP2.bam", package="exomePeak")
f3=system.file("extdata", "IP3.bam", package="exomePeak")
f4=system.file("extdata", "IP4.bam", package="exomePeak")
IP_BAM=c(f1,f2,f3,f4)
f1=system.file("extdata", "Input1.bam", package="exomePeak")
f2=system.file("extdata", "Input2.bam", package="exomePeak")
f3=system.file("extdata", "Input3.bam", package="exomePeak")
INPUT_BAM=c(f1,f2,f3)
f1=system.file("extdata", "treated_IP1.bam", package="exomePeak")
TREATED_IP_BAM=c(f1)
f1=system.file("extdata", "treated_Input1.bam", package="exomePeak")
TREATED_INPUT_BAM=c(f1)

# peak calling and comparison of two conditions
result = exomepeak(GENE_ANNO_GTF=GENE_ANNO_GTF, IP_BAM=IP_BAM, INPUT_BAM=INPUT_BAM, 
          TREATED_IP_BAM=TREATED_IP_BAM, TREATED_INPUT_BAM=TREATED_INPUT_BAM)

# or peak calling only, using data from only one condition with the following script
# result = exomepeak(GENE_ANNO_GTF=GENE_ANNO_GTF, IP_BAM=IP_BAM, INPUT_BAM=INPUT_BAM)

# alternatively, the gene annotation can be downloaded directly from internet with GENOME (and UCSC_TABLE_NAME).
# this will take a long time with the entire transcriptome of hg19
# result = exomepeak(GENOME="hg19", IP_BAM=IP_BAM, INPUT_BAM=INPUT_BAM)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Statistical Inference }
