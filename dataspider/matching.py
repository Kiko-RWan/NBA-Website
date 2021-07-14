# 对比赛进行了爬取

from lxml import etree
import requests
import psycopg2
import schedule
import time

def getscore():
    url = 'https://www.baidu.com/s?wd=nba&rsv_spt=1&rsv_iqid=0x854ba2a20007c1ec&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&rqlang=cn&tn=baiduhome_pg&rsv_dl=tb&rsv_enter=1&oq=nba%25E5%2588%2586%25E6%2595%25B0&rsv_btype=t&inputT=414&rsv_t=3fc6nOsCpupK6%2BCVKOkfv3QG%2F943LqBAK8plRR4hfNiuMwGmKd6VJfRSKZYvm5bxaWOc&rsv_sug3=13&rsv_pq=aa0acb190003f0e3&rsv_sug1=6&rsv_sug7=100&rsv_sug2=0&rsv_sug4=858'
    headers = {
        'Accept' : 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Accept-Encoding' : 'gzip, deflate, br',
        'Accrpt-Languege' : 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
        'User-Agent' : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36',
    }
    r = requests.get(url, headers=headers)

    print(f'status: {r.status_code}')
    with open('matching.html', 'w') as f:
        f.write(r.text)

    if r.status_code != 200:
        exit(1)
    html = etree.HTML(r.text)
    score1 = html.xpath('//*[@id="1"]/div/article/section/div[3]/div/div[2]/div[1]/a/div/div[2]/div[1]/div[2]/div/text()')
    score2 = html.xpath('//*[@id="1"]/div/article/section/div[3]/div/div[2]/div[1]/a/div/div[2]/div[2]/div[2]/div/text()')
    score1 = int(score1[0])
    score2 = int(score2[0])
    print(score1)
    print(score2)

    database = "nba2"
    user = "postgres"
    password = "0000"
    con = psycopg2.connect(database=database, user=user, password=password)
    cur = con.cursor()
    cur.execute(f'''
    update matching
    set home_score = {score1}
    where m_id = 2
    ''')
    cur.execute(f'''
    update matching
    set away_score = {score2}
    where m_id = 2
    ''')
    con.commit()
    cur.close()
    con.close()

schedule.every(5).seconds.do(getscore)

while True:
    schedule.run_pending()
    time.sleep(1) 