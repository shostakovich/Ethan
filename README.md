Ethan XMPP-Bot
==============

Ethan is a bot that serves scrum-teams via Jabber / Google Talk.

Start Ethan with
----------------

    lib/app.coffee username@server.com passwort

What ethan could do
-------------------

* Order pizza
* Check the weather
* Check when the next train is going
* Check with Jenkins who broke the build

How to add functionality
------------------------

* Create a new controller
* Add the desired command to CommandParser
* Add a view into /views
* Hook up controller in app.coffee

How to set up
-------------

* Install nodejs
* Install npm
* Install coffeescript
* Install watch-gem

How to test
-----------

* Add your tests to the /spec folder
* Run watchr ethan.watch to autotest