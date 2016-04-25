# commentary
author: Jurn Ho <jurn@magicmonster.com>

This was quite an interesting project.
A lot of pair programming was done, and we had regular meetings every few days.
This reduced the amount of formal documentation that was required for the API between the layers.
As a professional programmer I do programming and code reviews as part of my day job, so I also gave
 feedback but only to the level to avoid overwhelming others.

In hindsight utilising the bug tracker on github so we don't forget minor things (like refactoring) may have been
a good option.

Bad or unexpected data was an issue. Things like 'unknown' or degenerate DNA base data, or
proteins with single a residue came up late in the project.

Another issue is that we only ran the code on bbk servers. 'nomachine' and cut and paste code directly
 via the remote desktop. This led to hard to track errors with DOS newlines. By not setting up the
 project up on each individual's laptop we haven't really addressed alternative deployments. I didn't
 want to spend setting up CGI.

Good things include early integration. We setup a script to deploy the project so each individual can
work on their own copy. API stubs with hard coded or mock data were also added in the beginning so noone was
blocked from coding.
Making everyone commit early and often also helped with the stability of the build.

I also tried out perl TK for GUI but didn't get that far. `tkapp.pl` contains some code that utilises
the middle layer.

Igor knows about the biology domain so this helped me from going down the wrong track and wasting time
on certain things (like reverse enzyme cutting).

Also by working closely with other team members I got a sense of how they would perform professionally. I
enjoyed it when they get something working and are pleased with the accomplishments.  I'm very happy
 with my team and would consider future projects with them.

