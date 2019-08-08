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
    sql="SELECT q_id,question_name,question_tag FROM question_table WHERE question_name like '%{}%' or question_content like '%{}%'".format(query,query)
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
