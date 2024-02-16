#import "base-utils.typ": *


#let classroom-data = readjson("typst-classroom-data.json")

#let get-student-group(key) = {
    let filter(x) = {
        return x.group_id == key
    }
    return classroom-data.students.filter(filter)
}
