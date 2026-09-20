#import "show.typ": *

#let fmt-section(section, flexible-left-margin) = {
  show-section-heading(section.title)
  if "entries" not in section.keys() {
    show-content(section.content)
  } else if section.at("compact", default: false) {
    for entry in section.entries {
      show-normal-entry(entry, section.at("preposition", default: "at"))
    }
  } else {
    let cells = for entry in section.entries {
      show-grid-entry(entry)
    }
    let column-widths = if flexible-left-margin {(auto, 1fr)} else {(20%, 1fr)}
    context {
      grid(
        columns: column-widths,
        column-gutter: 1em,
        row-gutter: par.spacing,
        ..cells
      )
    }
  }
}

#let fmt-head(it) = [
  #grid(
    columns: (auto, 1fr),
    gutter: 3em,
    show-heading(it.name), show-contacts(it),
  )
  #if "summary" in it.keys() {
    let summary = (
      title: "Summary",
      content: it.summary,
    )
    fmt-section(summary, true)
  }
]

#let fmt(data, photo: none, flexible-left-margin: false) = {
  if photo == none {
    fmt-head(data)
  } else {
    grid(
      columns: (1fr, auto),
      gutter: 2em,
      fmt-head(data), photo,
    )
  }
  for section in data.sections {
    fmt-section(section, flexible-left-margin)
  }
}

