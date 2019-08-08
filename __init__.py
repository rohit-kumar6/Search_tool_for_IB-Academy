import os
from flask import Flask, escape, request, render_template, Response
from flask_mysqldb import MySQL
from flask import redirect, url_for, jsonify
from .model.model_add import *

app = Flask(__name__)
app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'ib'
mysql = MySQL(app)
global fetch_list 

# Model
# Adding in DB model in file .model.model_add
def getdb():
    return mysql.connection.cursor()  # Always open connection

def fetch_query(query):
    cur = getdb()
    sql= """ SELECT comb2.q_id,comb2.question_name,comb2.question_tag,comb2.company_name,comb1.question_status from
     (SELECT u2.q_id,u2.question_status FROM users_in_batches u1 JOIN user_wise_question u2 ON u1.user_id = u2.user_id 
     WHERE u1.user_id = 1) comb1 JOIN (SELECT q1.q_id,q1.question_name,q1.question_tag,com.company_name FROM 
     ((SELECT * FROM question_table WHERE 1) q1 LEFT JOIN (SELECT c1.q_id,c2.company_name FROM company_wise_question 
     c1 JOIN company_table c2 WHERE c1.company_id = c2.company_id) com ON q1.q_id = com.q_id) WHERE q1.question_name 
     LIKE "%{}%" or q1.question_content Like "%{}%" or com.company_name like "%{}%") comb2 WHERE comb1.q_id = comb2.q_id""".format(query,query,query)
    cur.execute(sql)
    fetch_data = cur.fetchall()
    return fetch_data

# CONTROLLER
@app.route('/find',methods=["POST"])
def find():
    global fetch_list
    query = request.form['query']
    if query :
        fetch_list = fetch_query(query) 
    else:
        fetch_list = [] 
    return render_template('search.html', fetch_list = fetch_list)

@app.route('/filter',methods=["POST"])
def filter():
    clicked = request.form['question']
    print("--------",clicked,fetch_list)
    return Response(status=200)

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
