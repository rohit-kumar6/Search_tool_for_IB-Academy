import os
from flask import Flask, escape, request, render_template, Response
from flask_mysqldb import MySQL
from flask import redirect, url_for, jsonify
from .model.model_add import *

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'search-tool-db.csvs6nukrxvo.us-east-1.rds.amazonaws.com'
app.config['MYSQL_USER'] = 'admin'
app.config['MYSQL_PASSWORD'] = 'test1234'
app.config['MYSQL_DB'] = 'ib'
mysql = MySQL(app)
global fetch_list 

# Model
# Adding in DB model in file .model.model_add
def getdb():
    return mysql.connection.cursor()  # Always open connection

def get_user_id():  # Always user 1 is login by default
    return 1

def fetch_query(query,Questions,Tags,Topic,Week,Day,Status):
    cur = getdb()
    u_id = get_user_id()
    sql= """ SELECT a.q_id,a.question_name,a.question_tag,a.company,a.question_status,b.question_topic,b.question_type,b.Week_number,b.day_number FROM 
    (SELECT comb2.q_id,comb2.question_name,comb2.question_tag,GROUP_CONCAT(comb2.company_name ORDER BY comb2.company_name) as "company",comb1.question_status from 
    (SELECT u2.q_id,u2.question_status FROM users_in_batches u1 JOIN user_wise_question u2 ON u1.user_id = u2.user_id WHERE u1.user_id = "{}") 
    comb1 JOIN
    (SELECT q1.q_id,q1.question_name,q1.question_tag,com.company_name FROM ((SELECT * FROM question_table WHERE 1) q1 LEFT JOIN (SELECT c1.q_id,c2.company_name FROM company_wise_question c1 JOIN company_table c2 WHERE c1.company_id = c2.company_id) 
    com ON q1.q_id = com.q_id) WHERE q1.question_name LIKE "%{}%" or q1.question_content Like "%{}%" or com.company_name like "%{}%") comb2 
    WHERE comb1.q_id = comb2.q_id and comb1.question_status LIKE "{}%" and comb2.question_tag LIKE "{}%"
    GROUP BY comb2.q_id) a
    JOIN
    (SELECT ba.q_id,ba.question_topic,ba.question_type,ba.Week_number,ba.day_number FROM batch_wise_question ba
    JOIN
    (SELECT batch_id FROM users_in_batches WHERE user_id = "{}") ba1
    ON ba.batch_id = ba1.batch_id) b
    WHERE a.q_id = b.q_id and b.question_topic LIKE "{}%" and b.question_type LIKE "{}%" and b.Week_number LIKE "{}%" and b.day_number LIKE "{}%"
    """.format(u_id,query,query,query,Status,Tags,u_id,Topic,Questions,Week,Day)
    cur.execute(sql)
    fetch_data = cur.fetchall()
    return fetch_data

# CONTROLLER
@app.route('/find',methods=["POST"])
def find():
    global fetch_list
    query = request.form['query'].strip()
    Questions = request.form['Questions']
    Tags = request.form['Tags']
    Topic = request.form['Topic']
    Week = request.form['Week']
    Day = request.form['Day']
    Status = request.form['Status']
    fetch_list = fetch_query(query,Questions,Tags,Topic,Week,Day,Status) 
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
