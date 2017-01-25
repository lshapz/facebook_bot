made it through part one of this tutorial
https://hackernoon.com/smooth-coordinator-1427dce17f00#.p1vu4onbd

got distracted by trying to replace the location functionality with youtube videos

google api gem was giving me trouble, as was "yourub"

then I tried just sending a video URL as an attachment and got 

    Facebook::Messenger::Bot::RecipientNotFound: (#100) Failed to fetch the file from the url

I at least implemented an error code thingy with an angry cat

but clearly before I finish the tutorial I have to set up some other kind of API call, if not youtube maybe spotify? 

part two - refactoring https://hackernoon.com/build-your-first-facebook-messenger-bot-in-ruby-with-sinatra-part-2-3-b3d929a4606d#.j3demp36t

part three - deployment, secrets https://hackernoon.com/build-your-first-facebook-messenger-bot-in-ruby-with-sinatra-part-3-3-c1b9f55ae121#.yh9233gcz

before it'll work again for further debugging, I need to:

  *set environment variables

    *export ACCESS_TOKEN= and export VERIFY_TOKEN=
  
  *set up forwarding to ngrok 

    *./ngrok http 5000

  *set webhook preferences in facebook developer dashboard to new ./ngrok URL 

    *https://developers.facebook.com/apps/720524191455407/messenger/ 