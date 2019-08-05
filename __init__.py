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
            sql = " SELECT question_name FROM question_table WHERE question_name like '%{}%' or question_content like '%{}%'".format(query,query)
            cur.execute(sql)
            fetch_data = cur.fetchall()#fetchone()
            cur.close()
            return fetch_data
        except:
            return []
    
    def get_company_id():
        return
    
    def get_question_id():
        return

    
    # CONTROLLER
    @app.route('/find',methods=["POST"])
    def find():
        query = request.form.get('query')
        fetch_list = fetch_query(query)  
        return render_template('search.html', fetch_list = fetch_list)
    
    @app.route('/add_data',methods=["POST"])
    def add_data():
        question_name = request.form.get('question_name')
        question_tag = request.form.get('question_tag')
        question_content = request.form.get('question_content')
        company_name = request.form.get('company_name')
        batch_id = request.form.get('batch_id')
        question_type = request.form.get('question_type')
        week_number = request.form.get('week_number')
        question_topic = request.form.get('question_topic')
        day_number = request.form.get('day_number')
        question_status = 0 # by default
        print("----------------------------------------------------",question_name)
        #insert
        return Response(status=200)

        

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

