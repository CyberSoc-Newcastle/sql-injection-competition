# SQL Injection Competition
## About
This is a Flask web application that is vulnerable to SQL injection. The goal of this web application is to allow the practice of security testing, using tools such as [SQLMap](https://github.com/sqlmapproject/sqlmap). __Do not use this application in production.__

The application is based on a fictional boat club. It shows information about the club such as events and allows pre-existing members to login to access member-only permissions.

## How to Run
### Requirements
To run this application you will need:
- Python 3.7+

If you are using Docker to run the MySQL database, you will need:
- Docker
- Docker-compose

If you are running the database bare metal, you will need to install:
- mysql-server

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
DB_PORT_=3306
```

If you wish to run the Flask application in debug mode, add `debug=True` to the `.env` file.

### Running the database
#### Using Docker
To start the MySQL database, using Docker, run the command:
```
docker-compose up -d
```

To close the MySQL database, run the command:
```
docker-compose stop
```

If you wish to delete the database, run the command:
```
docker-compose down -v
```
#### Using a bare metal MySQL server
Login to the MySQL as the root user, then run the command:
```
source </path/to>/db_bare_metal/setup.sql
```
This will create the required users, databases, tables and insert the default data.

### Running the Flask application
To run the Flask application, run the command:
```
python app.py
```

In your web browser, navigate to `http://127.0.0.1:5000` to view the website.

To close the Flask application, press Ctrl+C in the command line to terminate the program.

## Credits
- Bootstrap template used: [Business Frontpage - Start Bootstrap](https://startbootstrap.com/template/business-frontpage)
- All images taken from: [Pixabay](https://pixabay.com/)
