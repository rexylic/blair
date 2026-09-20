#set page(margin: 0.5in, paper: "us-letter")
#set par(spacing: 1em)

#let data = yaml("info.yml")
#import "@local/blair:1.0.2"
#let my-photo = image("photo.jpg", width: 1in, fit: "contain")
#blair.fmt(data, photo: my-photo)

