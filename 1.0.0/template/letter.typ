#set page(margin: 0.5in, paper: "us-letter")
#set par(spacing: 1em)

#let data = yaml("info.yml")
#import "@local/blair:1.0.0": fmt-data
#fmt-data(data)

