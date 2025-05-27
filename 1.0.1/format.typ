#import "show.typ": *

#let fmt-normal-section(it) = for entry in it.entries {
  show-normal-entry(entry, it.at("preposition", default: "at"))
}

#let fmt-grid-section(it) = {
  let cells = for entry in it.entries { show-grid-entry(entry) }
  return context {
    grid(
      columns: (20%, 1fr),
      column-gutter: 1em,
      row-gutter: par.spacing,
      ..cells
    )
  }
}

#let fmt-head(it) = grid(
  columns: (auto, 1fr),
  gutter: 3em,
  {
    show heading.where(depth: 1): set text(20pt)
    set align(left + top)
    heading(level: 1, it.name)
  },
  {
    set align(right + bottom)
    set text(1em - 2pt)
    if "address" in it.keys() [
      #it.address
      #linebreak()
    ]
    for i in range(it.contacts.len() - 1) {
      show-contact(it.contacts.at(i))
      h(0.6em)
    }
    show-contact(it.contacts.at(-1))
  },
)

#let fmt-section(section) = {
  show-section-heading(section.title)
  if "entries" not in section.keys() {
    show-content(section.content)
  } else if section.at("compact", default: false) {
    fmt-normal-section(section)
  } else {
    fmt-grid-section(section)
  }
}

#let fmt-data(data) = {
  fmt-head(data)
  if "summary" in data.keys() { show-content(data.summary) }
  for section in data.sections { fmt-section(section) }
}

