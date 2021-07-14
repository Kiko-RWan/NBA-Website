from os import path
import os
import psycopg2
import psycopg2.extras
import markdown
from pathlib import Path
import hashlib

SALT = b'nba20202021'
BASE_DIR = Path(__file__).resolve().parent.parent

database = "nba6"
user = "postgres"
password = "0000"

def MD5(str):
    hl = hashlib.md5(SALT)

    hl.update(str.encode(encoding='utf-8'))

    return(hl.hexdigest())

def last_over_match():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select home_name, home_score, t1.t_icon as t1_icon, away_name, away_score, t2.t_icon as t2_icon, m_time, m_path, t1.t_city, t1.t_home
    from over_match as m, team as t1, team as t2
    where m.home_name = t1.t_name and m.away_name = t2.t_name and m_time <= all (
        select m_time from over_match
    )
    ''')
    match = cur.fetchone()
    if match == None:
        match = {}
    cur.close()
    con.close()
    return match

def last_nst_match():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select home_name, t1.t_icon as t1_icon, away_name, t2.t_icon as t2_icon, m_time, m_path, t1.t_city, t1.t_home
    from nst_match as m, team as t1, team as t2
    where m.home_name = t1.t_name and m.away_name = t2.t_name and m_time <= all (
        select m_time from nst_match
    )
    ''')
    match = cur.fetchone()
    if match == None:
        match = {}
    cur.close()
    con.close()
    return match

def last_matching():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select home_name, home_score, t1.t_icon as t1_icon, away_name, away_score, t2.t_icon as t2_icon, m_time, m_path, t1.t_city, t1.t_home, m_state
    from matching as m, team as t1, team as t2
    where m.home_name = t1.t_name and m.away_name = t2.t_name and m_time <= all (
        select m_time from matching
    )
    ''')
    match = cur.fetchone()
    if match == None:
        match = {}
    cur.close()
    con.close()
    return match

def over_match_list():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from overmatches
    ''')
    match = cur.fetchall()
    if match == None:
        match = []
    cur.close()
    con.close()
    return match

def coming_match_list():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from comingmatches
    ''')
    match = cur.fetchall()
    if match == None:
        match = []
    cur.close()
    con.close()
    return match

def team_list():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from team
    ''')
    ret = cur.fetchall()
    if ret == None:
        ret = []
    cur.close()
    con.close()
    return ret

def team_coach(tname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from team natural join coach_team natural join coach where t_name = '{tname}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = {}
    cur.close()
    con.close()
    return ret

def team_players(tname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from team natural join player_team natural join player where t_name = '{tname}'
    ''')
    ret = cur.fetchall()
    if ret == None:
        ret = []
    cur.close()
    con.close()
    return ret

def team_info(tname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from team where t_name = '{tname}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = {}
    cur.close()
    con.close()
    return ret

def player_info(pname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from player where p_name = '{pname}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = {}
    cur.close()
    con.close()
    return ret

def player_team(pname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select t_name, in_time, t_icon from player natural join player_team natural join team where p_name = '{pname}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = {}
    cur.close()
    con.close()
    return ret

def player_list():
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from player
    ''')
    
    ret = cur.fetchall()
    print(len(ret))
    if ret == None:
        ret = []
    cur.close()
    con.close()
    return ret

def player_list_pat(name):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from player where p_name like '%{name}%'
    ''')
    
    ret = cur.fetchall()
    print(len(ret))
    if ret == None:
        ret = []
    cur.close()
    con.close()
    return ret

def is_user(name, pwd):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from users where u_name = '{name}' and u_password = '{MD5(pwd)}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = 0
    else:
        ret = 1
    cur.close()
    con.close()
    return ret

def exist_user(name):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from users where u_name = '{name}'
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = 0
    else:
        ret = 1
    cur.close()
    con.close()
    return ret

def article_list(uname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if not uname:
        cur.execute(f'''
        select * from article natural join written natural join users order by release desc
        ''')
    else:
        cur.execute(f'''
        select * from article natural join written natural join users where u_name = '{uname}' order by release desc
        ''')
    ret = cur.fetchall()
    if ret == None:
        ret = []
    for row in ret:
        abs = row['a_abs']
        if abs != 'NULL':
            with open(os.path.join(BASE_DIR, f'static/article/userpage/{abs}'), 'r') as f:
                content = f.read()
                f.close()
            row['a_abs'] = content
        else:
            content = ''
            row['a_abs'] = content
    cur.close()
    con.close()
    
    return ret

def article_info(aid):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select * from article natural join written natural join users where a_id = {aid}
    ''')
    ret = cur.fetchone()
    if ret == None:
        ret = {} 
    else:
        body = ret['a_path']
        if abs != 'NULL':
            with open(os.path.join(BASE_DIR, f'static/article/userpage/{body}'), 'r') as f:
                content = markdown.markdown(f.read())
            ret['a_path'] = content
        else:
            content = ''
            ret['a_path'] = content
    cur.close()
    con.close()
    return ret

def save_user(name, pwd, mail):
    if not mail:
        mail = 'NULL'
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    insert into users (u_name, u_password, u_mail) values ('{name}', '{MD5(pwd)}', '{mail}')
    ''')
    con.commit()
    cur.close()
    con.close()
    return 

def aidtouname(aid):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select u_name from written where a_id = {aid}
    ''')
    ret = cur.fetchone()
    cur.close()
    con.close()
    return ret

def del_art_db(aid, uname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    delete from written where a_id = {aid} and u_name = '{uname}'
    ''')
    cur.execute(f'''
    delete from article where a_id = {aid}
    ''')
    con.commit()
    cur.close()
    con.close()
    return

def new_art(title):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    insert into article (a_title) values ('{title}')
    ''')
    cur.execute(f'''
    select a_id from article where a_title = ('{title}')
    ''')
    ret = cur.fetchone()['a_id']
    con.commit()
    cur.close()
    con.close()
    return ret

def save_art_db(aid, filename, absname, uname):
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    update article set a_path = '{filename}' where a_id = {aid}
    ''')
    cur.execute(f'''
    update article set a_abs = '{absname}' where a_id = {aid}
    ''')
    cur.execute(f'''
    insert into written (u_name, a_id) values ('{uname}', {aid}) 
    ''')
    con.commit()
    cur.close()
    con.close()
    return 

def playoffinfo():

    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(f'''
    select t1, t2, score1, score2, team1.t_icon as icon1, team2.t_icon as icon2
    from playoff, team as team1, team as team2
    where t1 = team1.t_name and t2 = team2.t_name
    order by area ASC
    ''')
    ret = cur.fetchall()
    cur.close()
    con.close()
    return ret