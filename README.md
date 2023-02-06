# SQL Injection Competition
## About
This is a Flask web application that is vulnerable to SQL injection. The goal of this web application is to allow the practice of security testing, using tools such as [SQLMap](https://github.com/sqlmapproject/sqlmap). __Do not use this application in production.__

The application is based on a fictional boat club. It shows information about the club such as events and allows pre-existing members to login to access member-only permissions.

## How to Run
### Requirements
To run this application you will need:
- Python 3.7+
- Docker
### Installation
To install the required Python libraries, run the command:
```
pip install -r requirements.txt
```

### Creating the environment file
Create a file with the filename `.env` with the following contents:
```.env
# Flask
SECRET_KEY="<VERY_LONG_SECURE_KEY>"

# Database
DB_PORT_1=3506
DB_PORT_2=3606
```

If you wish to run the Flask application in debug mode, add `debug=True` to the `.env` file.

### Running the application
Firstly, start the MySQL databases by running the command:
```
docker-compose up
```

Next, start the Flask application by running the command:
```
python app.py
```

Finally, in your web browser, navigate to `http://127.0.0.1:5000` to view the website.

### Closing the application
To close the Flask application, press Ctrl+C in the command line to terminate the program.

To close the MySQL databases, run the command:
```
docker-compose stop
```

If you wish to delete the database, run the command:
```
docker-compose down -v
```

## Credits
- Bootstrap template used: [Business Frontpage - Start Bootstrap](https://startbootstrap.com/template/business-frontpage)
- All images taken from: [Pixabay](https://pixabay.com/)
