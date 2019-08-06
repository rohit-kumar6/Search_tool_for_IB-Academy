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
    
    # """
    # TO D0:
    # CREATE INDEXING BEFORE FETCH
    # """

    # MODEL
    def fetch_query(query):
        try:
            cur = mysql.connection.cursor()
            sql="""
                SELECT question_name,question_tag FROM question_table WHERE question_name like '%{}%' or question_content like '%{}%'
                """.format(query,query)
            cur.execute(sql)
            fetch_data = cur.fetchall()#fetchone()
            cur.close()
            return fetch_data
        except:
            return []

    def insert_data(question_name,question_tag,question_content,company_name,batch_id,question_type,week_number,question_topic,day_number,question_status):
        insert_question_tabel(question_name,question_tag,question_content)
        q_id = get_question_id(question_name,question_content)
        
        for company in company_name.split(",") :
            if(company != "") :
                company_id =  get_company_id(company)
                if(company_id == -1) : # if company is not registered
                    insert_company_tabel(company)
                    company_id = get_company_id(company)
                insert_company_wise_question(q_id,company_id)

        insert_batch_wise_question(batch_id,q_id,question_type,week_number,question_topic,day_number)
        user_list = list_of_user_in_batch(batch_id)
        insert_user_wise_question(user_list,q_id)
        return 
            
    def insert_question_tabel(question_name,question_tag,question_content):
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO question_table (question_name,question_tag,question_content) VALUES ('{}','{}','{}')".format(question_name,question_tag,question_content))
        cur.close()
        return

    def get_question_id(question_name,question_content):
        cur = mysql.connection.cursor()
        cur.execute("SELECT q_id from question_table WHERE question_name='{}' and question_content = '{}'".format(question_name,question_content))
        q_id = cur.fetchone()
        cur.close()
        return q_id[0]
    
    def insert_company_tabel(company_name):
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO company_table (company_name) VALUES ('{}')".format(company_name))
        cur.close()
        return
    
    def insert_company_wise_question(q_id,company_id):
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO company_wise_question (company_id,q_id) VALUES ('{}','{}')".format(company_id,q_id))
        cur.close()
        return

    def get_company_id(company_name):
        cur = mysql.connection.cursor()
        cur.execute("SELECT company_id from company_table WHERE company_name='{}'".format(company_name))
        company_id = cur.fetchone()
        cur.close()
        if company_id == None :
            return -1
        return company_id[0]

    def insert_batch_wise_question(batch_id,q_id,question_type,week_number,question_topic,day_number):
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO batch_wise_question (batch_id, q_id, question_type, Week_number, question_topic, day_number) VALUES ('{}','{}','{}','{}','{}','{}')".format(batch_id,q_id,question_type,week_number,question_topic,day_number))
        cur.close()
        return
    
    def list_of_user_in_batch(batch_id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT user_id from users_in_batches WHERE batch_id='{}'".format(batch_id))
        user_list = cur.fetchall()
        cur.close()
        return user_list

    def insert_user_wise_question(user_list,q_id,question_status=0):
        cur = mysql.connection.cursor()
        for user_id in user_list :
            cur.execute("INSERT INTO user_wise_question (user_id, q_id, question_status) VALUES ('{}','{}','{}')".format(user_id[0],q_id,question_status))
        cur.close()
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
        # Inserting data
        insert_data(question_name,question_tag,question_content,company_name,batch_id,question_type,week_number,question_topic,day_number,question_status)
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

