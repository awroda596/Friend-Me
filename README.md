# Friend Me
Your Way to Connect with Friends!

* General Description
* Requirements

- General Description:
Hanging out with friends is fun. It's really that simple.

Work, classes, schedules, so many things to coordinate. That's where Friend Me comes in. You open the app, set times you're available, and you're all set. Then the magic happens. Friend Me will check your friend's times and set you up. Both of you will get a notification. You can swipe Right to hangout, left to raincheck for another day! Once you've matched, you can send send your Instagram, phone number, Discord, or any method that you would like to communicate with.

- Requirements

## API:
signup -> server:port/api/users/signup <br>
methods: POST <br>
accepts: JSON <br>
adds user to DB(parameters: username, email, first_name, last_name, password) <br>
returns: JSON Auth Token <br>
login -> server:port/api/users/signup <br>
accepts: JSON <br>
methods: POST <br>
returns: JSON AuthToken
