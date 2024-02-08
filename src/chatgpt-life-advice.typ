// setup page
// set u
// a javascript implementation ...
// or maybe a python implementation ...
// symbolic maths to expand the current state? i dunno

#let text-function(it) = {
    
}

#let bullet-function(it) = {
    
}
#let enum-function(it) = {
    
}

#let footer-function(it) = {
    // to number the pages
    // to effect some resizing calculations
}

// this isnt a function callback ... this is a user
#let header-function-2 = locate(loc => {
  let elems = query(
    selector(heading).before(loc),
    loc,
  )
  let academy = smallcaps[
    Typst Academy
  ]
  if elems == () {
    align(right, academy)
  } else {
    let body = elems.last().body
    academy + h(1fr) + emph(body)
  }
}))

#let heading-function(it) = locate((loc) => {
    if it.level == 1 {
        if page == 1 {
            
        } else {
            pagebreak()
        }
        it
    }
    else if it.level == 2 {
        v(12pt)
    }

    else if it.level == 3 {
        v(10pt)
    }
})

show heading: heading-function


== List for Structure

Creating a structured and straightforward to-do list can help someone who is lazy and forgetful stay on track throughout the day. Here's a simple and manageable plan divided into morning, afternoon, and evening sections, with each part containing tasks that aren't too overwhelming:

=== Morning

1. *Wake Up Routine (Set a loud, annoying alarm)*
   - Stretch for a minute in bed.
   - Drink a glass of water kept by your bedside.

2. *Morning Hygiene (Keep your toiletries in sight)*
   - Brush your teeth.
   - Wash your face.

3. *Breakfast (Prepare something simple or grab a fruit)*
   - Eat a healthy breakfast.
   - Take any morning medication/vitamins.

4. *Set a Reminder (Use your phone or sticky notes)*
   - Review your to-do list for the day.
   - Set reminders for important tasks.

=== Afternoon

1. *Lunch (Keep it light and simple)*
   - Have a pre-planned or easy-to-make lunch.
   - Hydrate - drink water or a healthy beverage.

2. *Short Walk (Set a timer or alarm)*
   - Take a brief walk, even if it's just around the room or building.

3. *Afternoon Task (Choose the least demanding one)*
   - Tackle an important task or errand.
   - Break the task into small steps if it feels overwhelming.

4. *Quick Check-in (Use phone reminders)*
   - Check your to-do list.
   - Adjust or set reminders for evening tasks.

=== Evening

1. *Dinner (Opt for easy or pre-made meals)*
   - Have dinner, preferably something light.
   - Clean up immediately after to avoid laziness later.

2. *Relaxation Time*
   - Engage in a relaxing activity you enjoy (reading, watching a show, etc.).
   - Limit screen time before bed to ensure better sleep quality.

3. *Prepare for Tomorrow (Make it a habit)*
   - Lay out clothes for the next day.
   - Prepare anything you need for the morning (e.g., pack a bag, set out breakfast items).

4. *Night Routine (Keep it short and sweet)*
   - Brush your teeth.
   - Reflect on the day briefly and acknowledge what you've accomplished.

5. *Sleep (Set a consistent bedtime)*
   - Go to bed at a reasonable hour.
   - Ensure your bedroom is conducive to sleep (cool, dark, and quiet).

Remember, the key for someone who is lazy and forgetful is to keep tasks simple, minimize decision-making, and use reminders effectively. Tailor the list to your personal preferences and daily requirements, and try to stick to a routine to build good habits over time.


== List for Neatness

=== Morning

1. *Make the Bed (Right After Waking Up)*
   - Take a minute to straighten the sheets and arrange the pillows.
   
2. *Declutter the Bedroom (5-Minute Task)*
   - Quickly pick up any clothes on the floor and put them in the laundry bin or back in the closet.
   - Clear the nightstand of any unnecessary items.

3. *Morning Refresh (Post-Breakfast)*
   - Wash the breakfast dishes immediately or place them in the dishwasher.
   - Wipe down the kitchen counter.

4. *Prepare for the Day (Before Leaving the Bedroom)*
   - Ensure that all personal items (phone, keys, wallet) are in their designated spots.

=== Afternoon

1. *Lunch Cleanup (Right After Eating)*
   - Clear the table.
   - Wash dishes or load the dishwasher.
   
2. *15-Minute Tidy-Up (Choose a Different Room Each Day)*
   - Set a timer for focused decluttering.
   - Pick up items from the floor, organize surfaces, and throw away any trash.

3. *Paper Control (Daily Habit)*
   - Sort through mail and discard junk immediately.
   - File important documents in a designated spot.

4. *Digital Cleanup (Once a Week)*
   - Organize files on your computer.
   - Clear out unnecessary emails.

=== Evening

1. *Dinner Discipline (After Eating)*
   - Clean up immediately: dishes go in the dishwasher, leftovers in the fridge.
   - Wipe down the table and kitchen surfaces.

2. *Prep for Tomorrow (Before Relaxation Time)*
   - Lay out clothes for the next day.
   - Prepare work or school bags.

3. *Nightly 10-Minute Tidy-Up (Before Bed)*
   - Straighten up the living room.
   - Put away any items left out during the evening.

4. *Reflect and Plan (End of the Day)*
   - Take a moment to appreciate the tidying done today.
   - Write a short list of priority areas to tackle tomorrow.

=== Weekly

1. *Deep Clean Session (Choose a Day)*
   - Vacuum or sweep the floors.
   - Clean the bathroom and kitchen thoroughly.

2. *Declutter Session (Another Day)*
   - Go through a particular area or category of items and decide what to keep, donate, or discard.

3. *Laundry Day (Consistent Day of the Week)*
   - Wash, dry, fold, and put away clothes.

4. *Review and Adjust (End of the Week)*
   - Reflect on what's working and what's not.
   - Adjust the to-do list and routine as needed for the coming week.

For someone who is messy and disorganized, the key is consistency and not trying to tackle everything at once. By integrating these small tasks into daily life, the process of organizing and decluttering will become more natural and less daunting over time.


== Neat and Organized


For someone struggling with papers strewn all over, becoming more neat and organized involves creating a system that's easy to maintain. Here are some tips to help manage paper clutter effectively:

=== 1. *Start with a Clean Slate*

- *Clear a Workspace:* Choose a large surface like a dining table or desk, and clear it entirely to sort your papers.
- *Sort Ruthlessly:* Create piles to categorize your papers — 'Keep', 'Recycle', 'Shred'. Be decisive and avoid keeping unnecessary papers.

=== 2. *Create an Organizing System*

- *Use Filing Cabinets or Boxes:* Label folders or dividers for different categories like 'Bills', 'Receipts', 'Important Documents' (e.g., insurance, certificates), 'Personal' (e.g., letters, notes), and 'Work' or 'School'.
- *Go Digital When Possible:* Scan important documents and store them in organized folders on your computer or a cloud service. Make sure to back up these digital files.

=== 3. *Implement a One-Touch Rule*

- *Handle Paper Once:* When you receive a piece of paper, decide immediately what to do with it. Either file it, take action on it, or dispose of it. Avoid moving the paper from one pile to another.

=== 4. *Regularly Maintain Your System*

- *Scheduled Decluttering:* Set aside a regular time weekly or monthly to go through your papers, file new documents, and discard or shred old or irrelevant ones.
- *Keep It Visible:* Place your filing system or in-tray in a visible, easily accessible spot to remind you to use it.

=== 5. *Limit Incoming Paper*

- *Go Paperless:* Opt for digital statements and bills whenever possible.
- *Unsubscribe from Unnecessary Mailings:* Remove yourself from mailing lists that send you unwanted catalogs or promotions.

=== 6. *Create a Mail Station*

- *Designate a Spot for Incoming Mail:* This can be a basket, tray, or wall-mounted holder. Sort mail into categories like 'Action Needed', 'To File', and 'To Read'.
- *Process Regularly:* Make it a habit to process your mail station items during your scheduled maintenance times.

=== 7. *Invest in a Shredder*

- *Protect Your Privacy:* Regularly shred documents that contain sensitive information before disposing of them to prevent identity theft.

=== 8. *Label Everything*

- *Clear Labeling:* Use a label maker or neat handwriting to clearly mark folders and boxes. This not only helps you find things more easily but also encourages you to put things back in their place.

=== 9. *Reflect and Adjust*

- *Regular Reviews:* Periodically review your system to ensure it still meets your needs. Be open to adjusting your categories or methods as your life and priorities change.

Remember, the goal is to create a system that feels intuitive and easy to maintain. It might take some trial and error to find the perfect setup, but once you have a system in place, staying on top of paper clutter becomes much more manageable.
