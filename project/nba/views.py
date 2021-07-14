from django.shortcuts import HttpResponse,render,redirect
import psycopg2
from . import helpfun
import datetime
import json
import markdown 
import os
from os import path
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

def welcome(request):
    return render(request, 'welcome.html')

def home(request):
    last_over_match = helpfun.last_over_match()
    last_matching = helpfun.last_matching()
    last_nst_match = helpfun.last_nst_match()
    over_matchs = helpfun.over_match_list()
    if len(over_matchs) > 5:
        over_matchs = over_matchs[:5]

    # format = '%d %b %Y / %I:%M %p'
    # lom_info = f"{last_over_match['m_time'].strftime(format)}"
    # nst_info = f"{last_nst_match['m_time'].strftime(format)}"
    # ing_info = f"{last_matching['m_time'].strftime(format)}"

    format = '%Y-%m-%d %H:%M:%S'
    
    nst_time = last_nst_match['m_time'].strftime(format)

    ret = {
        # 'lom_info' : lom_info,
        # 'nst_info' : nst_info,
        # 'ing_info' : ing_info,
        'nst_time' : json.dumps(nst_time),
        'last_over_match' : last_over_match,
        'last_matching' : last_matching,
        'last_nst_match' : last_nst_match,
        'over_matchs' : over_matchs,
    }
    print(str(nst_time))
    return render(request, 'home.html', ret)

def team(request):
    team_name = request.GET.get('tname')
    if (not team_name) or (team_name == 'all'):
        teamlist = helpfun.team_list()
        ret = {
            'teamlist' : teamlist,
        }
        return render(request, 'teams.html', ret)
    else:
        team_info = helpfun.team_info(team_name)
        team_coach = helpfun.team_coach(team_name)
        team_players = helpfun.team_players(team_name)

        ret = {
            'team_name' : team_name,
            'team_coach' : team_coach,
            'team_info' : team_info,
            'team_players' : team_players,
        }

        return render(request, 'team.html', ret)

# def player(request):
#     pname = request.GET.get('pname')
#     if (not pname) or (pname == 'all'):
#         playerlist = helpfun.player_list()
#         ret = {
#             'players' : playerlist,
#         }
#         return render(request, 'players.html', ret)
#     else :
#         pinfo = helpfun.player_info(pname)
#         pteam = helpfun.player_team(pname)

#         ret = {
#             'pname' : pname,
#             'pinfo' : pinfo,
#             'pteam' : pteam,
#         }
#         return render(request, 'player.html', ret)

def player(request):
    if request.method == 'GET':
        pname = request.GET.get('pname')
        if (not pname) or (pname == 'all'):
            playerlist = helpfun.player_list()
            ret = {
                'players' : playerlist,
                'shname' : 'player name',
            }
            return render(request, 'players.html', ret)
        else :
            pinfo = helpfun.player_info(pname)
            pteam = helpfun.player_team(pname)

            ret = {
                'pname' : pname,
                'pinfo' : pinfo,
                'pteam' : pteam,
            }
            return render(request, 'player.html', ret)
    else:
        name = request.POST.get('shname')
        playerlist = helpfun.player_list_pat(name)
        ret = {
            'players' : playerlist,
            'shname' : name,
        }
        return render(request, 'players.html', ret)

def article(request):
    aid = request.GET.get('aid')
    pos = request.GET.get('pos')
    if pos:
        aid = int(aid) + int(pos)
    if (not aid) or (aid == 'all'):
        list = helpfun.article_list(uname='')
        ret = {
            'list' : list,
        }
        return render(request, 'articles.html', ret)
    else:
        art = helpfun.article_info(aid)
        if art:
            ret = {
                'art' : art,
            }    
            return render(request, 'article.html', ret)
        else:
            path = request.path
            ret = {
                'path' : f'{path}?aid={request.GET.get("aid")}',
            }
            return render(request, '404.html', ret)

def login(request):
    if request.method == 'GET':
        return render(request, 'login.html')
    else:
        if request.session.get('user_name'):
            return redirect('/user/')
        else:
            user = request.POST.get('name')
            pwd = request.POST.get('pwd')
            if helpfun.is_user(user, pwd):
                request.session['user_name'] = user
                return redirect('/user/')
            else:
                return render(request, 'login.html', {'msg' : 'error'})

def register(request):
    if request.method == 'GET':
        return render(request, 'register.html')
    else:
        user = request.POST.get('name')
        pwd = request.POST.get('pwd')
        pwd2 = request.POST.get('pwd2')
        mail = request.POST.get('mail')
        if not user:
            return render(request, 'register.html', {'msg' : 'username cannot be empty'})
        elif not pwd:
            return render(request, 'register.html', {'msg' : 'password cannot be empty'})
        elif not pwd2:
            return render(request, 'register.html', {'msg' : 'please enter password twice'})
        elif helpfun.exist_user(user):
            return render(request, 'register.html', {'msg' : 'username exists'})
        elif pwd != pwd2:
            return render(request, 'register.html', {'msg' : 'different password'})
        else:
            helpfun.save_user(user, pwd, mail)
            request.session['user_name'] = user
            return redirect('/user/')
            
def user(request):
    if not request.session.get('user_name'):
        return redirect('/login/')
    else:
        uname = request.session['user_name']
        list = helpfun.article_list(uname)
        ret = {
            'list' : list,
            'uname' : uname,
        }
        return render(request, 'user.html', ret)

def nof(request, exception):
    path = request.path
    ret = {
        'path' : 'home/',
    }
    return render(request, '404.html', ret)

def add_article(request):
    name = request.session.get('user_name')
    if not name:
        return redirect('/login/')
    elif request.method == 'GET':
        return render(request, 'add_art.html')
    else:
        title = str(request.POST.get('title')).replace('\'', '')
        file = request.FILES['file']
        abs = request.POST.get('abs')
        if not abs:
            abs = ''
        if not title:
            return render(request, 'add_art.html', {'msg':'no title!'})
        if not file:
            return render(request, 'add_art.html', {'msg':'no inputfile!'})
        else:
            aid = helpfun.new_art(title)
            filename = f'{aid}_b.md'
            absname = f'{aid}_a.txt'
            with open(os.path.join(BASE_DIR, f'static/article/userpage/{filename}'), 'wb+') as destination:
                for chunk in file.chunks():
                    destination.write(chunk)
            with open(os.path.join(BASE_DIR, f'static/article/userpage/{absname}'), 'w') as destination:
                destination.write(abs)
            helpfun.save_art_db(aid, filename, absname, name)
            return redirect('/user/')
        

def del_art(request):
    aid = request.GET.get('aid')
    uname = request.session.get('user_name')
    if not uname:
        return redirect('/login/')
    elif not aid:
        return redirect('/user/')
    else:
        uname_db = helpfun.aidtouname(aid)
        if (not uname_db) or (uname_db['u_name'] != uname):
            return render(request, '404.html')
        else:
            helpfun.del_art_db(aid, uname)
            return redirect('/user/')

def logout(request):
    uname = request.session.get('user_name')
    if not uname:
        return redirect('/')
    else:
        del request.session['user_name']
        return redirect('/')


def match(request):
    mid = request.GET.get('mid')
    if (not mid) or (mid == 'over'):
        overmatchlist = helpfun.over_match_list()
        ret = {
            'list' : overmatchlist,
            'info' : 'over matches',
        }
        return render(request, 'matches.html', ret)
    elif mid == 'coming':
        comingmatchlist = helpfun.coming_match_list()
        ret = {
            'list' : comingmatchlist,
            'info' : 'coming matches',
        }
        return render(request, 'matches.html', ret)

def playoff(request):

    playeroffinfo = helpfun.playoffinfo()
    for item in playeroffinfo:
        if item['icon1']:
            item['icon1'] = f'<img class="logo" src="/static/images/teamicon/{item["icon1"]}">'

        if item['icon2']:
            item['icon2'] = f'<img class="logo" src="/static/images/teamicon/{item["icon2"]}">'
    ret = {
        'poinfo' : playeroffinfo,
    }
    return render(request, 'playoff.html', ret)

