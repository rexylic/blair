#set page(margin: 0.5in, paper: "us-letter")
#set par(spacing: 1em)

#let data = yaml("info.yml")
#import "@local/blair:1.0.1": fmt-data
#fmt-data(data, photo: image("photo.jpg", width: 1in, fit: "contain"))

