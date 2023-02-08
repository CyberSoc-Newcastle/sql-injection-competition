# SQL Injection Competition
## General Hints
General hints for this competition include:
- You do not need to modify any data in the database
- Most of the questions can be solved using [SQLMap](https://github.com/sqlmapproject/sqlmap)
- Make use of the developer tools in your browser

## Questions
The following questions were asked during the competition:

1. The events page is only supposed to show public events. How many events are there in total (including privates ones)?

2. How many users are there in the database?

3. What is Alex's password?

4. Login into the member's area. What is the member motto?

5. There is a different database, used somewhere in the member's area, which contains financial information. What is the name of that database? (Hint: You will need to use a cookie)

6. In the same database, what is the total sum of all the money in payments table?

7. Try to gain access to the admin area. What is the admin motto? (Hint: SQLMap might not be useful for this but error messages might be)

8. Bonus: Where is the treasure buried according to the secure access page in the admin area? (Hint: This isn't SQL injection but the dev tools in the browser may help)
