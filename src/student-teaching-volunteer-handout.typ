// the json file
{
  "traits": [
    {
        "characteristics": ["responsible", "patient", "caring"],
        "action": "try your best for this"
    },
    {
        "characteristics": ["annoyed", "sarcastic"],
        "action": "try to minimize"
    }
],
"guidelines": [
    {
        "title": "Role Model",
        "desc": "The children will address you as Mr. Sam."
    },
    {
        "title": "Dress Neatly",
        "desc": "Wear a tucked-in shirt."
    },
    {
        "title": "Balance",
        "desc": "Free and fun. Professional and responsible. You can be both."
    }
]

}



#import "@preview/fletcher:0.4.2" as fletcher: node, edge

#import fletcher.shapes: diamond


#let fletch(items, b) = {
  
  fletcher.diagram( 
    node-stroke: 0.5pt,
    edge-stroke: 1pt,
    node((0,0), items, corner-radius: 3pt, stroke: black, inset:  10pt, outset: 10pt),
    edge("-|>"),
    node((0,1.5), align(center, b), outset: 5pt, stroke: none)
  )
}


#let abc(o) = {
  let (characteristics, action) = o
  let items = list(..characteristics)  
  let actionContent = text(weight: "bold", action)
  fletch(items, actionContent)
}










Volunteer Opportunity

Recording a math


Student Teaching

2 hours of volunteer service
    30 minutes of 
reading a dialogue

Sunday 5/55/2024 from 


#{
  let data = json("data.json")
  let t = data.traits.at(0)
  let items = data.traits.map(abc)
  align(center, block(width: 50%, stack(..items, dir: ltr, spacing: 1fr)))

  let guidelines = data.guidelines
  let create(o) = {
    [=== #o.title]
    [#o.desc]
    v(10pt)
  }
  let guidelineContent = enum(..guidelines.map(create))
  v(30pt)
  block(width: 60%, guidelineContent)
}




