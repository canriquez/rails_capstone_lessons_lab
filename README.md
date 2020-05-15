# Lessons Lab

This web application is a mobile application targeting freelance teachers to admin, track and manage lessons with their students.

. The front is based the original design idea by [Gregoire Vella on Behance ](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding?tracking_source=).


![screenshot](assets/img/app_screenshot.png)

## Live App link

[heroku live site](https://pure-coast-26349.herokuapp.com/)

## Customer Story

	- The user logs in to the app, only by typing the username
		. Additional feature implemented: password is an additional feature (demo password: password)
		
	3. The logged-in user is presented with a profile page that includes:
		a. My billable bookings ("all my transactions")
		b. My non-billable bookings ("all my external transactions)
		c. All Courses
		d. Additional feature: All students

	4. When logged-in user opens "My billable bookings" page
		a. Total amount of booked minutes are displayed on top
			i. Additional feature: All equivalent revenue also displayed
		b. A list of all transactions created by logged-in user is displayed (sorted by most recent)
		c. Each transaction displays:
			i.  Student name (name), 
			ii. minutes-amount and date, 
			iii. equivalent price per session 
			iv. icon of the Course(group) it belongs to.
		d. An action button "Add new booking" is displayed
	
	5. When logged-in user opens "My non-billable booking" page
		a. A list of all transactions that are created by a logged-in user but not assigned to any course (group), or student (user) sorted by most recent transaction (diagnostics session - needs analysis - non billable)
		b. The design of the page is similar to the "My billable bookings"

	6. When a logged-in user opens the "All Courses " page:
		a. A list of all courses is displayed in alphabetical order.
			
		b. Each course display its icon, name and record creation date.
			i. Additional feature: Total lessons given so far
		
		c. Each course is clickable and opens "course transactions" page.
	
	7. When logged-in user opens the "Course transactions" page:
		a. A list of all transactions that belong to that course are displayed.
		b. The design of the page is similar to the "All my bookings". Besides the information that appears in All my Bookings page, each booking displays the name of the author of the transaction.

	8. When logged-in user opens "create new course" or "Add new transaction" page
		a. A form with all necessary fields is displayed.
		b. It's not in the given design, but you should make the effort to follow the same style of the other pages.
	
		
	9. At the end  extend your MVP app with one simple feature of your choice
		a. Add feature: For create a new course, the following data should be provided
			i. Course name
			ii. Price per session
			iii. Session length
			
	10. Additional feature: Signing up students to courses:
		a. Only a professor can enroll students in a  courses.
		b. Sign-up student button will be available only on the "course transactions page"
		c. "add a new transaction" will be shown on the "course transaction page"
			i. Transaction can be created only for students signed up into the course.
			
	11. Additional features :Signup of students page
		a. Students will be created only by teachers. Fields will include.
			i. Name
			ii. Email
			iii. Role: student
Optionally: assign course

## Environment set up requirements

To run this project, you need ruby installed in your environment
Run the following command:

```
$ ruby -v
```

You should have a result similar to this:
s
```
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
```

If you don't get that result, follow this [link](https://www.ruby-lang.org/en/documentation/installation/) and install Ruby in your local environment.

### Setup
- Clone this repository in your local environment
- Located on the root of repository execute 

```bundle install``` 
 
This action will install all the required dependencies. 

## Built With

- Ruby
- Ruby on Rails
- bootstrap

## Authors

👤 Carlos Anriquez

- Github: [@canriquez](https://github.com/canriquez)
- Twitter: [@cranriquez](https://twitter.com/cranriquez)
- Linkedin: [linkedin](https://www.linkedin.com/in/carlosanriquez/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!