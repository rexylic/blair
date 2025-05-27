#let show-content(it, standalone: true) = if array == type(it) {
  set list(indent: 1em) if standalone
  let items = ()
  for i in range(it.len()) {
    if array == type(it.at(i)) {
      if i == 0 { panic("First item is a nested list!") }
      items.push({
        items.remove(-1)
        show-content(it.at(i))
      })
    } else { items.push(it.at(i)) }
  }
  list(..items)
} else { it }

#let show-section-heading(it) = {
  show heading.where(depth: 2): it => context {
    set text(14pt)
    set block(above: par.spacing, below: 6pt)
    smallcaps(it)
    show line: set block(above: 0pt, below: par.spacing)
    line(length: 100%)
  }
  heading(depth: 2, it)
}

#let show-date-range(it) = if dictionary != type(it) [#it] else if (
  "to" in it.keys()
) [#it.from -- #it.to] else [#it.from -- Present]

#let show-contact(it) = {
  [#it.label: ]
  if "link" in it.keys() {
    link(
      it.link,
      {
        set text(fill: luma(45%))
        underline(it.content)
      },
    )
  } else { it.content }
}

#let show-t1(it) = strong(it)
#let show-t2(it) = emph(text(it, fill: luma(25%)))
#let show-t3(it) = smallcaps(text(it, fill: luma(35%)))

#let show-normal-entry(entry, preposition) = {
  let has2 = "t2" in entry.keys()
  let has3 = "t3" in entry.keys()
  if has2 and has3 [
    #show-t1(entry.t1)
    #preposition
    #show-t2(entry.t2), #show-t3(entry.t3)
  ] else if has2 [
    #show-t1(entry.t1)
    #preposition
    #show-t2(entry.t2)
  ] else if has3 [
    #show-t1(entry.t1), #show-t3(entry.t3)
  ] else [ #show-t1(entry.t1) ]
  h(1fr)
  if "date" in entry.keys() {
    show-date-range(entry.date)
  }
  linebreak()
  if "content" in entry.keys() {
    show-content(entry.content)
  }
  parbreak()
}

#let show-grid-entry(entry) = (
  {
    show-t1(entry.t1)
    linebreak()
    if "t2" in entry.keys() {
      show-t2(entry.t2)
      linebreak()
    }
    if "t3" in entry.keys() {
      show-t3(entry.t3)
      linebreak()
    }
    if "date" in entry.keys() {
      show-date-range(entry.date)
    }
  },
  show-content(entry.content, standalone: false),
)
