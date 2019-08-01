import os
from flask import Flask, escape, request, render_template
# from flask_mysqldb import MySQL
from flask import redirect, url_for

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass
    
    # app.config['MYSQL_HOST'] = '127.0.0.1'
    # app.config['MYSQL_USER'] = 'root'
    # app.config['MYSQL_PASSWORD'] = ''
    # app.config['MYSQL_DB'] = 'todo'
    # mysql = MySQL(app)
    
    # MODEL
    
    # CONTROLLER
    @app.route('/')
    @app.route('/home')
    def home():
        return render_template('home.html')

    # CURD
    return app

