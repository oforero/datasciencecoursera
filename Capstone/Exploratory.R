library(R.utils)

sampleLines <- function(f, out, samp=0.3, dir=getwd()) {
  fname <- paste(dir, f, sep="/")
  fbin <- file(fname, "rb")
  flen <- countLines(fbin)[1]
  close(fbin)

  samp_size <- round(flen[1] * samp)
  lines <- sort(sample.int(flen, size = samp_size, replace = FALSE))
  
  sed_cmd <- sapply(lines, FUN= function(x) paste(toString(x),"p", sep = ""))
  tmp <- tempfile(pattern = "sed_cmd")                  
  write(sed_cmd, file=tmp, ncolumns=1)  
  res <- paste(out, f, sep="/")
  cmd <- paste("sed -f", tmp, "<", fname, ">", res, "&& rm -f", tmp)
  print(cmd)
  system2(cmd, wait=FALSE)
}

sampleLines("en_US.blogs.txt", "en_US_sample", dir="en_US_fix")
sampleLines("en_US.news.txt", "en_US_sample", dir="en_US_fix")
sampleLines("en_US.twitter.txt", "en_US_sample", dir="en_US_fix")
