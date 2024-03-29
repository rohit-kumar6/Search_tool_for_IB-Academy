from ..__init__ import *

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
    cur = getdb()
    cur.execute("INSERT INTO question_table (question_name,question_tag,question_content) VALUES ('{}','{}','{}')".format(question_name,question_tag,question_content))
    return

def get_question_id(question_name,question_content):
    cur = getdb()
    cur.execute("SELECT q_id from question_table WHERE question_name='{}' and question_content = '{}'".format(question_name,question_content))
    q_id = cur.fetchone()
    return q_id[0]

def insert_company_tabel(company_name):
    cur = getdb()
    cur.execute("INSERT INTO company_table (company_name) VALUES ('{}')".format(company_name))
    return

def insert_company_wise_question(q_id,company_id):
    cur = getdb()
    cur.execute("INSERT INTO company_wise_question (company_id,q_id) VALUES ('{}','{}')".format(company_id,q_id))
    return

def get_company_id(company_name):
    cur = getdb()
    cur.execute("SELECT company_id from company_table WHERE company_name='{}'".format(company_name))
    company_id = cur.fetchone()
    if company_id == None :
        return -1
    return company_id[0]

def insert_batch_wise_question(batch_id,q_id,question_type,week_number,question_topic,day_number):
    cur = getdb()
    cur.execute("INSERT INTO batch_wise_question (batch_id, q_id, question_type, Week_number, question_topic, day_number) VALUES ('{}','{}','{}','{}','{}','{}')".format(batch_id,q_id,question_type,week_number,question_topic,day_number))
    return

def list_of_user_in_batch(batch_id):
    cur = getdb()
    cur.execute("SELECT user_id from users_in_batches WHERE batch_id='{}'".format(batch_id))
    user_list = cur.fetchall()
    return user_list

def insert_user_wise_question(user_list,q_id,question_status=0):
    cur = getdb()
    for user_id in user_list :
        cur.execute("INSERT INTO user_wise_question (user_id, q_id, question_status) VALUES ('{}','{}','{}')".format(user_id[0],q_id,question_status))
    return
