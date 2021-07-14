#对教练进行了爬取处理

import csv
from io import IncrementalNewlineDecoder
from os import name
import random

def team_init():
    out = []

    f = open('teamlist.csv', 'r')   
    with f:
        reader = csv.DictReader(f)
        for i in reader:
            out.append(f"INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('{i['tname']}', '{i['tcity']}', '{i['home']}', '{i['tname']}.svg');")

    return out

def coach_init():
    out = []

    f = open('teamlist.csv', 'r')   
    with f:
        reader = csv.DictReader(f)
        for i in reader:
            coachimg = i['coachimg']
            if len(coachimg) > 0:
                out.append(f"INSERT INTO coach(c_name, c_img) VALUES ('{i['coachname']}', '{coachimg}');")
            else:
                out.append(f"INSERT INTO coach(c_name) VALUES ('{i['coachname']}');")
                
    return out

def coach_team():
    out = []
    index = 1

    f = open('teamlist.csv', 'r')   
    with f:
        reader = csv.DictReader(f)
        for i in reader:
            
            out.append(f"INSERT INTO coach_team(c_id, t_name, in_time) VALUES ({index}, '{i['tname']}', '{random.randint(2010, 2020)}-{random.randint(1, 12)}-{random.randint(1, 28)}');")
            index = index + 1

    return out

def player_init():
    out = []

    f = open('playerlist.csv', 'r')   
    with f:
        reader = csv.DictReader(f)
        for i in reader:
            w = i['pw'].replace('lb', '')
            w = int(w)
            h = i['ph'].replace('-', '.')
            h = float(h)
            name = i['pname'].replace("'", '')
            out.append(f"INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('{name}', {h}, {w}, {random.randint(0, 99)}, '{i['pimgpath']}');")

    return out

def player_team():
    out = []
    index = 1

    f = open('playerlist.csv', 'r')  
    with f:
        reader = csv.DictReader(f)
        for i in reader:
            out.append(f"INSERT INTO player_team(p_id, t_name, in_time) VALUES ({index}, '{i['team']}', '{random.randint(2010, 2020)}-{random.randint(1, 12)}-{random.randint(1, 28)}');")
            index = index + 1
        
    return out

with open('insert.sql', 'w') as f:
    out = team_init()
    for i in out:
        f.write(i)
        f.write('\n')
    out = coach_init()
    for i in out:
        f.write(i)
        f.write('\n')
    out = coach_team()
    for i in out:
        f.write(i)
        f.write('\n')
    out = player_init()
    for i in out:
        f.write(i)
        f.write('\n')
    out = player_team()
    for i in out:
        f.write(i)
        f.write('\n')
