import os
from flask import Flask, escape, request, render_template, Response
from flask_mysqldb import MySQL
from flask import redirect, url_for, jsonify

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass
    
    app.config['MYSQL_HOST'] = '127.0.0.1'
    app.config['MYSQL_USER'] = 'root'
    app.config['MYSQL_PASSWORD'] = ''
    app.config['MYSQL_DB'] = 'ib'
    mysql = MySQL(app)
    
    # MODEL
    def fetch_query(query):
        try:
            cur = mysql.connection.cursor()
            sql = " SELECT question_name FROM question_table WHERE question_name like %(query)s "
            cur.execute(sql,{ 'query': query })
            console.loh(sql)
            
            # sql = " SELECT question_name FROM question_table WHERE question_name LIKE '%(query)%'"
            # cur.execute(sql,{ 'query': query })
            
            fetch_data = cur.fetchall()#fetchone()
            print("query",fetch_data)  
            cur.close()
            return fetch_data
        except:
            return []

    
    # CONTROLLER
    @app.route('/find',methods=["POST"])
    def find():
        query = request.form.get('query')
        
        fetch_list = fetch_query(query)  
        return render_template('search.html', fetch_list = fetch_list)

    # VIEW
    @app.route('/')
    @app.route('/home')
    def home():
        return render_template('home.html')

    @app.route('/add')
    def add():
        return render_template('add.html') 

    @app.route('/notfound')
    def notfound():
        return render_template('404.html')  

    return app

