#let master = (
    inline-canvas: (
         length: 1in,
    )
)


#let get(key, sink) = {
    let ref = master.at(key)
    let kwargs = sink.named()
    return merge-fresh(ref, kwargs)
}

// #panic(arguments(1, foo: "a").named())
// #get("aa", arguments())
// this is the sink object 
// on the one hand, need to stay on your course
// on the other hand, do need to look around

Talent Show

Something has to happen in a story ... in order for it to be a story.
There has to be rising action.
There has to be falling action.
There has to be something that the characters want.
There has to be a resolution of the want.

Is it obtained?
Is it pushed further?

Every story is 

The typography is fixed to a certain degree.
Colons are still a bit of a problem.
Periods also break as orphans onto new lines.

the ruler() function is pretty cool.
if the height changes from a single iteration, 

in typst, you cannot mutate objects. you can only recreate objects.
i guess this is because tracking mutations is very buggy.











