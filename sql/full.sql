-- 队员
DROP TABLE IF EXISTS player;
CREATE TABLE player (
    p_id serial NOT NULL,
    p_name varchar(30) NOT NULL,
    p_height numeric(3, 2),
    p_weight numeric(4, 1),
    p_number int NOT NULL, -- 号码布
    p_img varchar(50) DEFAULT 'NULL', -- 头像路径
    primary key (p_id)
);

-- check
DROP TABLE IF EXISTS team;
CREATE TABLE team (
    t_name varchar(30) NOT NULL,
    t_city varchar(30), -- 所在城市
    t_home varchar(30), -- 所在场馆
    t_icon varchar(50) DEFAULT 'NULL', -- 头像路径
    total int DEFAULT 0, -- 总比赛场次
    win int DEFAULT 0, -- 胜利场次
    primary key (t_name)
);

-- check
DROP TABLE IF EXISTS coach;
CREATE TABLE coach (
    c_id serial NOT NULL,
    c_name varchar(20) NOT NULL,
    c_img varchar(50) DEFAULT 'NULL', -- 头像路径
    primary key (c_id)
);

-- check
DROP TABLE IF EXISTS player_team;
CREATE TABLE player_team (
    p_id int NOT NULL,
    t_name varchar(20) NOT NULL,
    in_time date, -- 进入时间
    foreign key(p_id) references player,
    foreign key(t_name) references team
);

-- check
DROP TABLE IF EXISTS coach_team;
CREATE TABLE coach_team (
    c_id int NOT NULL,
    t_name varchar(20) NOT NULL,
    in_time date, -- 进入时间
    foreign key(c_id) references coach,
    foreign key(t_name) references team
);

DROP TABLE IF EXISTS nst_match;
CREATE TABLE nst_match (
    m_id serial NOT NULL,
    home_name varchar(20) NOT NULL,
    away_name varchar(20) NOT NULL,
    m_time timestamp NOT NULL,
    m_path varchar(50) DEFAULT 'NULL', -- 比赛信息
    foreign key(home_name) references team,
    foreign key(away_name) references team,
    primary key(m_id)
);

DROP TABLE IF EXISTS matching;
CREATE TABLE matching (
    m_id serial NOT NULL,
    home_name varchar(20) NOT NULL,
    away_name varchar(20) NOT NULL,
    m_time timestamp NOT NULL,
    m_state varchar(10) NOT NULL, -- 比赛状况（第几节、暂停等）
    home_score int NOT NULL,
    away_score int NOT NULL,
    m_path varchar(50) DEFAULT 'NULL', -- 比赛信息
    foreign key(home_name) references team,
    foreign key(away_name) references team,
    primary key(m_id)
);

DROP TABLE IF EXISTS over_match;
CREATE TABLE over_match (
    m_id serial NOT NULL,
    home_name varchar(20) NOT NULL,
    away_name varchar(20) NOT NULL,
    m_time timestamp NOT NULL,
    home_score int NOT NULL,
    away_score int NOT NULL,
    m_path varchar(50) DEFAULT 'NULL',  -- 比赛信息
    foreign key(home_name) references team,
    foreign key(away_name) references team,
    primary key(m_id)
);

-- playoff area图
--    __________                                                                                                                                                                                                                   __________
--   |          |                                                                                                                                                                                                                 |          |                                                                                                                                              
--   |    1     |——————————|                                                                                                                                                                                           |——————————|     5    |               
--   |__________|          |           __________                                                                                                                                                 __________           |          |__________|
--                         |          |          |                                                                                                                                               |          |          |
--                         |——————————|     9    |——————————|                                                                                                                         |——————————|    11    |——————————|            
--    __________           |          |__________|          |                                                                                                                         |          |__________|          |           __________
--   |          |          |                                |                                                                                                                         |                                |          |          |
--   |    1     |——————————|                                |                                                                                                                         |                                |——————————|     5    |
--   |__________|                                           |           __________                                                                               __________           |                                           |__________|
--                                                          |          |          |                                                                             |          |          |  
--                                                          |——————————|    13    |——————————|                                                       |——————————|    14    |——————————|
--    __________                                            |          |__________|          |                                                       |          |__________|          |                                            __________
--   |          |                                           |                                |                                                       |                                |                                           |          |
--   |    2     |——————————|                                |                                |                                                       |                                |                                |——————————|     6    |
--   |__________|          |           __________           |                                |                                                       |                                |           __________           |          |__________|
--                         |          |          |          |                                |                                                       |                                |          |          |          |
--                         |——————————|     9    |——————————|                                |                                                       |                                |——————————|    11    |——————————|
--    __________           |          |__________|                                           |                                                       |                                           |__________|          |           __________
--   |          |          |                                                                 |                                                       |                                                                 |          |          |
--   |    2     |——————————|                                                                 |                                                       |                                                                 |——————————|     6    |
--   |__________|                                                                            |           __________             __________           |                                                                            |__________|
--                                                                                           |          |          |           |          |          |                                
--                                                                                           |——————————|    15    |———————————|    15    |——————————|                                
--    __________                                                                             |          |__________|           |__________|          |                                                                             __________
--   |          |                                                                            |                                                       |                                                                            |          |
--   |    3     |——————————|                                                                 |                                                       |                                                                 |——————————|     7    |
--   |__________|          |           __________                                            |                                                       |                                            __________           |          |__________|
--                         |          |          |                                           |                                                       |                                           |          |          | 
--                         |——————————|    10    |——————————|                                |                                                       |                                |——————————|    12    |——————————|
--    __________           |          |__________|          |                                |                                                       |                                |          |__________|          |           __________
--   |          |          |                                |                                |                                                       |                                |                                |          |          |
--   |    3     |——————————|                                |                                |                                                       |                                |                                |——————————|     7    | 
--   |__________|                                           |           __________           |                                                       |           __________           |                                           |__________|
--                                                          |          |          |          |                                                       |          |          |          |
--                                                          |——————————|    13    |——————————|                                                       |——————————|    14    |——————————|
--    __________                                            |          |__________|                                                                             |__________|          |                                            __________
--   |          |                                           |                                                                                                                         |                                           |          |                                                                   
--   |    4     |——————————|                                |                                                                                                                         |                                |——————————|     8    | 
--   |__________|          |           __________           |                                                                                                                         |           __________           |          |__________|
--                         |          |          |          |                                                                                                                         |          |          |          | 
--                         |——————————|    10    |——————————|                                                                                                                         |——————————|    12    |——————————|
--    __________           |          |__________|                                                                                                                                               |__________|          |           __________
--   |          |          |                                                                                                                                                                                           |          |          |
--   |    4     |——————————|                                                                                                                                                                                           |——————————|     8    |
--   |__________|                                                                                                                                                                                                                 |__________|
--

-- DROP TABLE IF EXISTS playoff;
-- CREATE TABLE playoff (
--     area int NOT NULL,
--     tname varchar(20) references team,
--     score int DEFAULT 0,
--     primary key(area, tname)
-- );

DROP TABLE IF EXISTS playoff;
CREATE TABLE playoff (
    area int NOT NULL primary key,
    t1 varchar(20) references team,
    t2 varchar(20) references team,
    score1 int DEFAULT 0,
    score2 int DEFAULT 0
);


DROP TABLE IF EXISTS article;
CREATE TABLE article (
    a_id serial NOT NULL,
    a_title varchar(50) NOT NULL,
    a_abs varchar(50) DEFAULT 'NULL', -- 简介
    a_path varchar(50) DEFAULT 'NULL', -- 文章地址
    primary key(a_id)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    u_name varchar(15) NOT NULL,
    u_password varchar(50) NOT NULL,
    u_mail varchar(30) DEFAULT 'NULL',
    u_img varchar(50) DEFAULT 'NULL',
    primary key(u_name)
);

DROP TABLE IF EXISTS written;
CREATE TABLE written (
    u_name varchar(15) NOT NULL,
    a_id int NOT NULL,
    release timestamp DEFAULT current_timestamp, -- 发布时间
    foreign key(u_name) references users,
    foreign key(a_id) references article
);


-- 输入两队名称、两队分数，返回赢方
create function winteam(
    t1 varchar(30),
    t2 varchar(30),
    score1 int,
    score2 int
)
returns varchar(30)
as
$body$
declare re varchar(30);
begin 
    if (score1 > score2) then
        select t1 into re;
    else
        select t2 into re;
    end if;
    return re;
end;
$body$
language plpgsql;
-- 



-- 如果在over_match中添加了比赛，则删去nst_match和matching中的比赛, 并更新统计
-- drop function if exists matchfinish_fun;
-- drop trigger if exists matchfinish_trg on over_match;
create function matchfinish_fun() returns trigger
as
$body$
declare wintname varchar(30);
begin 
    if exists(select m_id from matching where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time) then 
        delete from matching where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time;
    end if;

    if exists(select m_id from nst_match where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time) then 
        delete from nst_match where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time;
    end if;

    select winteam(new.home_name, new.away_name, new.home_score, new.away_score) into wintname;

    update team set win = win + 1 where t_name = wintname;

    update team set total = total + 1 where t_name = new.home_name or t_name = new.away_name;

    return NULL;
end;
$body$
language plpgsql;

create trigger matchfinish_trg after insert on over_match
for each row 
execute function matchfinish_fun();
-- 

-- 如果在matching中添加了比赛，则删去nst_match中的比赛
-- drop function if exists matchbegin_fun;
-- drop trigger if exists matchbegin_trg on matching;
create function matchbegin_fun() returns trigger
as
$body$
begin 
    if exists(select m_id from nst_match where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time) then 
        delete from nst_match where home_name=new.home_name and away_name=new.away_name and m_time=new.m_time;
    end if;
    return NULL;
end;
$body$
language plpgsql;

create trigger matchbegin_trg after insert on matching
for each row 
execute function matchbegin_fun();
-- 

-- 返回即将到来的比赛列表
create view comingmatches as
    select home_name, t1.t_icon as t1_icon, away_name, t2.t_icon as t2_icon, m_time, m_path, t1.t_city, t1.t_home
    from nst_match as m, team as t1, team as t2
    where m.home_name = t1.t_name and m.away_name = t2.t_name
	order by m_time ASC;
--

-- 返回完赛列表
create view overmatches as
select home_name, home_score, t1.t_icon as t1_icon, away_name, away_score, t2.t_icon as t2_icon, m_time, m_path, t1.t_city, t1.t_home
    from over_match as m, team as t1, team as t2
    where m.home_name = t1.t_name and m.away_name = t2.t_name
	order by m_time DESC;
--

-- 返回晋级区域
create function next_area(i int) returns int
as
$body$
declare re int;
begin
	select case
		when i = 1 or i = 2 then 9
		when i = 3 or i = 4 then 10 
		when i = 5 or i = 6 then 11
		when i = 7 or i = 8 then 12
		when i = 9 or i = 10 then 13
		when i = 11 or i = 12 then 14
		when i = 13 or i = 14 then 15
		when i = 15 then 0
        end
	into re;
	return re;
end;
$body$
language plpgsql;
--

-- -- 根据赢队更新playoff
-- -- create procedure updtplayoff(
-- -- in team varchar(30)
-- -- )
-- -- language plpgsql
-- -- as
-- -- $body1$
-- -- declare area_now int;
-- -- begin
-- --     select area into area_now
-- --         from playoff 
-- --         where tname = team and area >= all(
-- --             select area from playoff where tname = team
-- --         );
-- -- 	if 4 in (
-- --         select score
-- --         from playoff 
-- --         where tname = team and area = area_now and area >= all(
-- --             select area from playoff where tname = team
-- --         ) 
-- --     )
-- -- 	then
-- -- 	insert into playoff(area, tname, score)
-- -- 		values(next_area(area_now), team, 0);
-- --     commit;
-- --     else
-- --     update playoff set score = score + 1 where tname = team and area = area_now;
-- -- 	end if;
    
-- -- end;
-- -- $body1$

-- create procedure updtplayoff(
-- in team varchar(30)
-- )
-- language plpgsql
-- as
-- $body1$
-- declare area_now int;
-- declare area_next int;
-- begin
--     select max area into area_now
--         from playoff 
--         where t1 = team;
-- 	select next_area(area_now) into area_next;
	
-- 	if 4 in (
--         select score1
--         from playoff 
--         where t1 = team and area = area_now 
--     )
-- 	then
-- 		if exits (select * from playoff where area = area_next) then
-- 			if not null(select t1 from playoff where area = area_next) then
-- 				update playoff set t2 = team where area = area_next;
-- 			else
-- 				update playoff set t1 = team where area = area_next;
-- 			end if;
-- 		else 
-- 			insert into playoff(area, t1) values(area_next, team);
-- 		end if;
-- 	else
-- 		update playoff set score1 = score1 + 1 where area = area_now and t1 = team;
-- 		update playoff set score2 = score2 + 1 where area = area_now and t2 = team;
-- end;
-- $body1$
-- --

-- 新文章
create procedure newart(
    in title varchar(30),
    in absname varchar(30),
    in filename varchar(30),
    in uname varchar(30)
)
language plpgsql
as
$body$
declare aid int;
begin 
    insert into article (a_title, a_abs, a_th) values (title, absname, filename);
	select into aid from article where a_title = title;
	insert into written (a_id, u_name) values (aid, uname);
end;
$body$
-- 

INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Bucks', 'Milwaukee', 'Fiserv Forum ', 'Bucks.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Nets', 'Brooklyn', 'Barclays Center ', 'Nets.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Wizards', 'Washington', 'Capital One Arena', 'Wizards.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Jazz', 'Utah', 'Vivint Smart Home Arena', 'Jazz.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Blazers', 'Portland Trail', 'Moda Center', 'Blazers.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Suns', 'Phoenix', 'Phoenix Suns Arena', 'Suns.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Pacers', 'Indiana', 'Bankers Life Fieldhouse', 'Pacers.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Nuggets', 'Denver', 'Ball Arena', 'Nuggets.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Pelicans', 'New Orleans', 'Smoothie King Center', 'Pelicans.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Clippers', 'Los Angeles', 'STAPLES Center', 'Clippers.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Hawks', 'Atlanta', 'State Farm Arena', 'Hawks.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Kings', 'Sacramento', 'Golden 1 Center', 'Kings.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Warriors', 'Golden State', 'Chase Center', 'Warriors.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('76ers', 'Philadelphia', 'Wells Fargo Center', '76ers.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Grizzlies', 'Memphis', 'FedEx Forum', 'Grizzlies.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Celtics', 'Boston', 'TD Garden', 'Celtics.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Mavericks', 'Dallas', 'American Airlines Center ', 'Mavericks.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Timberwolves', 'Minnesota', 'Target Center', 'Timberwolves.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Raptors', 'Toronto', 'Amalie Arena', 'Raptors.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Spurs', 'San Antonio', 'AT&T Center', 'Spurs.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Bulls', 'Chicago', 'United Center', 'Bulls.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Lakers', 'Los Angeles', 'STAPLES Center', 'Lakers.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Hornets', 'Charlotte', 'Spectrum Center', 'Hornets.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Rockets', 'Houston', 'Toyota Center', 'Rockets.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Heat', 'Miami', 'AmericanAirlines Arena', 'Heat.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Knicks', 'New York', 'Madison Square Garden', 'Knicks.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Pistons', 'Detroit', 'Little Caesars Arena', 'Pistons.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Thunder', 'Oklahoma City', 'Chesapeake Energy Arena', 'Thunder.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Magic', 'Orlando', 'Amway Center', 'Magic.svg');
INSERT INTO team(t_name, t_city, t_home, t_icon) VALUES ('Cavaliers', 'Cleveland', 'Quicken Loans Arena ', 'Cavaliers.svg');
INSERT INTO coach(c_name, c_img) VALUES ('Mike Budenholzer', 'MikeBudenholzer.png');
INSERT INTO coach(c_name) VALUES ('Steve Nash');
INSERT INTO coach(c_name, c_img) VALUES ('Scott Brooks', 'ScottBrooks.png');
INSERT INTO coach(c_name, c_img) VALUES ('Quin Snyder', 'QuinSnyder.png');
INSERT INTO coach(c_name, c_img) VALUES ('Terry Stotts', 'TerryStotts.png');
INSERT INTO coach(c_name, c_img) VALUES ('Monty Williams', 'MontyWilliams.png');
INSERT INTO coach(c_name) VALUES ('Nate Bjorkgren');
INSERT INTO coach(c_name, c_img) VALUES ('Michael Malone', 'MichaelMalone.png');
INSERT INTO coach(c_name, c_img) VALUES ('Stan Van Gundy', 'StanVanGundy.png');
INSERT INTO coach(c_name, c_img) VALUES ('Tyronn Lue', 'TyronnLue.png');
INSERT INTO coach(c_name) VALUES ('Lloyd Pierce');
INSERT INTO coach(c_name, c_img) VALUES ('Luke Walton', 'waltolu01c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Steve Kerr', 'kerrst01c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Doc Rivers', 'Doc Rivers');
INSERT INTO coach(c_name) VALUES ('Taylor Jenkins');
INSERT INTO coach(c_name, c_img) VALUES ('Brad Stevens', 'stevebr99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Rick Carlisle', 'carliri01c.png');
INSERT INTO coach(c_name) VALUES ('Ryan Saunders');
INSERT INTO coach(c_name, c_img) VALUES ('Nick Nurse', 'nurseni01c.png');
INSERT INTO coach(c_name) VALUES ('Gregg Popovich');
INSERT INTO coach(c_name, c_img) VALUES ('Billy Donovan', 'donovbi99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Frank Vogel', 'vogelfr99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('James Borrego', 'borreja99c.png');
INSERT INTO coach(c_name) VALUES ('Stephen Silas');
INSERT INTO coach(c_name, c_img) VALUES ('Erik Spoelstra', 'spoeler99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Tom Thibodeau', 'thiboto99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('Dwane Casey', 'caseydw99c.png');
INSERT INTO coach(c_name) VALUES ('Mark Daigneault');
INSERT INTO coach(c_name, c_img) VALUES ('Steve Clifford', 'cliffst99c.png');
INSERT INTO coach(c_name, c_img) VALUES ('J.B. Bickerstaff', 'bickejb01c.png');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (1, 'Bucks', '2011-2-10');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (2, 'Nets', '2019-2-22');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (3, 'Wizards', '2018-6-17');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (4, 'Jazz', '2014-8-14');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (5, 'Blazers', '2019-9-10');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (6, 'Suns', '2018-4-12');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (7, 'Pacers', '2018-1-25');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (8, 'Nuggets', '2012-4-20');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (9, 'Pelicans', '2018-8-15');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (10, 'Clippers', '2017-6-14');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (11, 'Hawks', '2019-9-24');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (12, 'Kings', '2017-8-25');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (13, 'Warriors', '2013-11-9');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (14, '76ers', '2011-1-2');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (15, 'Grizzlies', '2013-6-5');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (16, 'Celtics', '2016-12-15');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (17, 'Mavericks', '2019-9-11');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (18, 'Timberwolves', '2016-4-17');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (19, 'Raptors', '2016-2-18');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (20, 'Spurs', '2010-11-1');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (21, 'Bulls', '2018-8-3');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (22, 'Lakers', '2014-3-2');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (23, 'Hornets', '2015-3-3');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (24, 'Rockets', '2016-7-18');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (25, 'Heat', '2012-5-9');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (26, 'Knicks', '2013-2-3');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (27, 'Pistons', '2012-11-23');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (28, 'Thunder', '2014-5-1');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (29, 'Magic', '2020-4-3');
INSERT INTO coach_team(c_id, t_name, in_time) VALUES (30, 'Cavaliers', '2019-3-23');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brook Lopez', 7.0, 282, 46, 'BrookLopez.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bryn Forbes', 6.2, 205, 51, 'BrynForbes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Pat Connaughton', 6.5, 209, 58, 'PatConnaughton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Khris Middleton', 6.7, 222, 25, 'KhrisMiddleton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bobby Portis', 6.1, 250, 53, 'BobbyPortis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Donte DiVincenzo', 6.4, 203, 12, 'DonteDiVincenzo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Giannis Antetokounmpo', 6.11, 242, 16, 'GiannisAntetokounmpo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jrue Holiday', 6.3, 205, 16, 'JrueHoliday.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Thanasis Antetokounmpo', 6.6, 219, 33, 'ThanasisAntetokounmpo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jordan Nwora', 6.8, 225, 70, 'JordanNwora.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sam Merrill', 6.4, 205, 17, 'SamMerrill.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jeff Teague', 6.3, 195, 1, 'JeffTeague.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('P.J. Tucker', 6.5, 245, 64, 'PJTucker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mamadi Diakite', 6.9, 228, 66, 'MamadiDiakite.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Axel Toupane', 6.7, 197, 76, 'AxelToupane.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Elijah Bryant', 6.5, 210, 17, 'ElijahBryant.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Justin Jackson', 6.8, 220, 15, 'JustinJackson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Joe Harris', 6.6, 220, 93, 'JoeHarris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jeff Green', 6.8, 235, 55, 'JeffGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bruce Brown', 6.4, 202, 33, 'BruceBrown.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Landry Shamet', 6.4, 190, 9, 'LandryShamet.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Timothé Luwawu-Cabarrot', 6.7, 220, 87, 'TimothLuwawuCabarrot.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeAndre Jordan', 6.11, 265, 26, 'DeAndreJordan.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kyrie Irving', 6.2, 195, 19, 'KyrieIrving.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyler Johnson', 6.3, 186, 33, 'TylerJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('James Harden', 6.5, 220, 58, 'JamesHarden.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevin Durant', 6.1, 240, 69, 'KevinDurant.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nicolas Claxton', 6.11, 215, 62, 'NicolasClaxton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Blake Griffin', 6.1, 250, 88, 'BlakeGriffin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Reggie Perry', 6.8, 250, 40, 'ReggiePerry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chris Chiozza', 5.11, 175, 39, 'ChrisChiozza.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alize Johnson', 6.7, 212, 21, 'AlizeJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mike James', 6.1, 189, 42, 'MikeJames.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Spencer Dinwiddie', 6.5, 215, 42, 'SpencerDinwiddie.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Robin Lopez', 7.0, 281, 48, 'RobinLopez.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Russell Westbrook', 6.3, 200, 60, 'RussellWestbrook.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Raul Neto', 6.1, 180, 54, 'RaulNeto.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Garrison Mathews', 6.5, 215, 87, 'GarrisonMathews.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bradley Beal', 6.3, 207, 4, 'BradleyBeal.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rui Hachimura', 6.8, 230, 35, 'RuiHachimura.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dāvis Bertāns', 6.1, 225, 57, 'DvisBertns.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alex Len', 7.0, 250, 34, 'AlexLen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Deni Avdija', 6.9, 210, 58, 'DeniAvdija.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ish Smith', 6.0, 175, 14, 'IshSmith.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaac Bonga', 6.8, 180, 21, 'IsaacBonga.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anthony Gill', 6.7, 230, 89, 'AnthonyGill.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Daniel Gafford', 6.1, 234, 97, 'DanielGafford.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cassius Winston', 6.1, 185, 54, 'CassiusWinston.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chandler Hutchison', 6.6, 210, 96, 'ChandlerHutchison.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Thomas Bryant', 6.1, 248, 38, 'ThomasBryant.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Caleb Homesley', 6.6, 205, 64, 'CalebHomesley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bojan Bogdanović', 6.7, 226, 66, 'BojanBogdanovi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Georges Niang', 6.7, 230, 21, 'GeorgesNiang.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rudy Gobert', 7.1, 258, 50, 'RudyGobert.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Royce ONeale', 6.4, 226, 51, 'RoyceONeale.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jordan Clarkson', 6.4, 194, 17, 'JordanClarkson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Derrick Favors', 6.9, 265, 98, 'DerrickFavors.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Joe Ingles', 6.8, 220, 15, 'JoeIngles.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Miye Oni', 6.5, 206, 21, 'MiyeOni.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Donovan Mitchell', 6.1, 215, 53, 'DonovanMitchell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mike Conley', 6.1, 175, 43, 'MikeConley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Trent Forrest', 6.4, 210, 25, 'TrentForrest.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Juwan Morgan', 6.7, 232, 53, 'JuwanMorgan.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jarrell Brantley', 6.5, 250, 67, 'JarrellBrantley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Matt Thomas', 6.4, 190, 81, 'MattThomas.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Elijah Hughes', 6.5, 215, 13, 'ElijahHughes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ersan İlyasova', 6.9, 235, 33, 'Ersanlyasova.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Udoka Azubuike', 6.1, 280, 68, 'UdokaAzubuike.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Enes Kanter', 6.1, 250, 82, 'EnesKanter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Robert Covington', 6.7, 209, 10, 'RobertCovington.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Carmelo Anthony', 6.7, 238, 46, 'CarmeloAnthony.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Damian Lillard', 6.2, 195, 62, 'DamianLillard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anfernee Simons', 6.3, 181, 31, 'AnferneeSimons.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Derrick Jones Jr.', 6.5, 210, 2, 'DerrickJonesJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nassir Little', 6.5, 220, 52, 'NassirLittle.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('CJ McCollum', 6.3, 190, 43, 'CJMcCollum.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Harry Giles', 6.11, 240, 49, 'HarryGiles.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jusuf Nurkić', 6.11, 290, 9, 'JusufNurki.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('CJ Elleby', 6.6, 200, 5, 'CJElleby.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Norman Powell', 6.3, 215, 73, 'NormanPowell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Keljin Blevins', 6.4, 200, 67, 'KeljinBlevins.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rondae Hollis-Jefferson', 6.6, 217, 98, 'RondaeHollisJefferson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('T.J. Leaf', 6.1, 222, 67, 'TJLeaf.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Zach Collins', 6.11, 250, 23, 'ZachCollins.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mikal Bridges', 6.6, 209, 87, 'MikalBridges.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chris Paul', 6.0, 175, 89, 'ChrisPaul.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Deandre Ayton', 6.11, 250, 34, 'DeandreAyton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Devin Booker', 6.5, 206, 52, 'DevinBooker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jae Crowder', 6.6, 235, 5, 'JaeCrowder.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cameron Johnson', 6.8, 210, 44, 'CameronJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cameron Payne', 6.1, 183, 76, 'CameronPayne.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jevon Carter', 6.1, 200, 32, 'JevonCarter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dario Šarić', 6.1, 225, 99, 'Darioari.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Frank Kaminsky', 7.0, 240, 31, 'FrankKaminsky.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Langston Galloway', 6.1, 200, 44, 'LangstonGalloway.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Torrey Craig', 6.7, 221, 92, 'TorreyCraig.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('ETwaun Moore', 6.3, 191, 31, 'ETwaunMoore.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jalen Smith', 6.1, 215, 42, 'JalenSmith.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Abdel Nader', 6.5, 225, 97, 'AbdelNader.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ty-Shon Alexander', 6.3, 195, 57, 'TyShonAlexander.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Justin Holiday', 6.6, 180, 83, 'JustinHoliday.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('T.J. McConnell', 6.1, 190, 19, 'TJMcConnell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Doug McDermott', 6.7, 225, 51, 'DougMcDermott.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Aaron Holiday', 6.0, 185, 7, 'AaronHoliday.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Domantas Sabonis', 6.11, 240, 44, 'DomantasSabonis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Malcolm Brogdon', 6.5, 229, 98, 'MalcolmBrogdon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Edmond Sumner', 6.4, 196, 54, 'EdmondSumner.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Myles Turner', 6.11, 250, 63, 'MylesTurner.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Goga Bitadze', 6.11, 250, 57, 'GogaBitadze.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jeremy Lamb', 6.5, 180, 24, 'JeremyLamb.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Caris LeVert', 6.6, 205, 49, 'CarisLeVert.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kelan Martin', 6.5, 230, 67, 'KelanMartin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('JaKarr Sampson', 6.7, 214, 14, 'JaKarrSampson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cassius Stanley', 6.5, 190, 84, 'CassiusStanley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Oshae Brissett', 6.7, 210, 5, 'OshaeBrissett.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Amida Brimah', 6.1, 230, 19, 'AmidaBrimah.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('T.J. Warren', 6.8, 220, 66, 'TJWarren.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nikola Jokić', 6.11, 284, 44, 'NikolaJoki.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Facundo Campazzo', 5.1, 195, 16, 'FacundoCampazzo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Michael Porter Jr.', 6.1, 218, 4, 'MichaelPorterJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('JaMychal Green', 6.8, 227, 62, 'JaMychalGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Will Barton', 6.6, 181, 8, 'WillBarton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Paul Millsap', 6.7, 257, 24, 'PaulMillsap.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('PJ Dozier', 6.6, 205, 58, 'PJDozier.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jamal Murray', 6.3, 215, 81, 'JamalMurray.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Monte Morris', 6.2, 183, 69, 'MonteMorris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Zeke Nnaji', 6.9, 240, 11, 'ZekeNnaji.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Vlatko Čančar', 6.8, 236, 4, 'Vlatkoanar.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Markus Howard', 5.1, 175, 93, 'MarkusHoward.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bol Bol', 7.2, 220, 86, 'BolBol.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Aaron Gordon', 6.8, 235, 34, 'AaronGordon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Shaquille Harrison', 6.7, 190, 90, 'ShaquilleHarrison.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Austin Rivers', 6.4, 200, 85, 'AustinRivers.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('JaVale McGee', 7.0, 270, 53, 'JaValeMcGee.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Eric Bledsoe', 6.1, 214, 15, 'EricBledsoe.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Zion Williamson', 6.7, 284, 35, 'ZionWilliamson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brandon Ingram', 6.8, 190, 17, 'BrandonIngram.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaxson Hayes', 6.11, 220, 83, 'JaxsonHayes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Steven Adams', 6.11, 265, 51, 'StevenAdams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Lonzo Ball', 6.6, 190, 23, 'LonzoBall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kira Lewis Jr.', 6.1, 170, 32, 'KiraLewisJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Hart', 6.5, 215, 6, 'JoshHart.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Willy Hernangómez', 6.11, 250, 48, 'WillyHernangmez.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nickeil Alexander-Walker', 6.6, 205, 98, 'NickeilAlexanderWalker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Naji Marshall', 6.7, 220, 51, 'NajiMarshall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('James Johnson', 6.7, 240, 44, 'JamesJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Wenyen Gabriel', 6.9, 205, 57, 'WenyenGabriel.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Wesley Iwundu', 6.6, 195, 78, 'WesleyIwundu.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('James Nunnally', 6.7, 208, 97, 'JamesNunnally.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Didi Louzada', 6.5, 188, 84, 'DidiLouzada.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ivica Zubac', 7.0, 240, 53, 'IvicaZubac.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Reggie Jackson', 6.2, 208, 34, 'ReggieJackson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nicolas Batum', 6.8, 230, 22, 'NicolasBatum.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Terance Mann', 6.5, 215, 67, 'TeranceMann.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luke Kennard', 6.5, 206, 5, 'LukeKennard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Marcus Morris', 6.8, 218, 28, 'MarcusMorris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Paul George', 6.8, 220, 65, 'PaulGeorge.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kawhi Leonard', 6.7, 225, 85, 'KawhiLeonard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Amir Coffey', 6.7, 210, 15, 'AmirCoffey.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Serge Ibaka', 6.1, 235, 90, 'SergeIbaka.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Patrick Patterson', 6.8, 235, 42, 'PatrickPatterson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Patrick Beverley', 6.1, 180, 61, 'PatrickBeverley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Daniel Oturu', 6.8, 240, 91, 'DanielOturu.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rajon Rondo', 6.1, 180, 83, 'RajonRondo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeMarcus Cousins', 6.1, 270, 36, 'DeMarcusCousins.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Yogi Ferrell', 6.0, 178, 65, 'YogiFerrell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jay Scrubb', 6.5, 220, 58, 'JayScrubb.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Solomon Hill', 6.6, 226, 67, 'SolomonHill.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevin Huerter', 6.7, 190, 16, 'KevinHuerter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Trae Young', 6.1, 180, 70, 'TraeYoung.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('John Collins', 6.9, 235, 73, 'JohnCollins.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Clint Capela', 6.1, 240, 48, 'ClintCapela.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Danilo Gallinari', 6.1, 233, 2, 'DaniloGallinari.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Onyeka Okongwu', 6.8, 235, 71, 'OnyekaOkongwu.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tony Snell', 6.6, 213, 26, 'TonySnell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brandon Goodwin', 6.0, 180, 60, 'BrandonGoodwin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bogdan Bogdanović', 6.6, 220, 24, 'BogdanBogdanovi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nathan Knight', 6.1, 253, 2, 'NathanKnight.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Skylar Mays', 6.4, 205, 3, 'SkylarMays.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bruno Fernando', 6.9, 240, 63, 'BrunoFernando.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cam Reddish', 6.8, 218, 52, 'CamReddish.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Lou Williams', 6.1, 175, 35, 'LouWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeAndre Hunter', 6.8, 225, 93, 'DeAndreHunter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kris Dunn', 6.3, 205, 36, 'KrisDunn.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Buddy Hield', 6.4, 220, 80, 'BuddyHield.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Richaun Holmes', 6.1, 235, 98, 'RichaunHolmes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeAaron Fox', 6.3, 185, 77, 'DeAaronFox.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Harrison Barnes', 6.8, 225, 59, 'HarrisonBarnes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyrese Haliburton', 6.5, 185, 35, 'TyreseHaliburton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Marvin Bagley III', 6.11, 235, 44, 'MarvinBagleyIII.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Hassan Whiteside', 7.0, 265, 48, 'HassanWhiteside.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chimezie Metu', 6.9, 225, 92, 'ChimezieMetu.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Justin James', 6.7, 190, 21, 'JustinJames.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kyle Guy', 6.1, 167, 74, 'KyleGuy.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Terence Davis', 6.4, 201, 37, 'TerenceDavis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Delon Wright', 6.5, 185, 7, 'DelonWright.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Maurice Harkless', 6.7, 220, 71, 'MauriceHarkless.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Damian Jones', 6.11, 245, 25, 'DamianJones.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jahmius Ramsey', 6.3, 190, 27, 'JahmiusRamsey.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Robert Woodard', 6.6, 235, 39, 'RobertWoodard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Andrew Wiggins', 6.7, 197, 65, 'AndrewWiggins.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kent Bazemore', 6.4, 195, 31, 'KentBazemore.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Stephen Curry', 6.3, 185, 89, 'StephenCurry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Draymond Green', 6.6, 230, 10, 'DraymondGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevon Looney', 6.9, 222, 20, 'KevonLooney.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mychal Mulder', 6.3, 184, 86, 'MychalMulder.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Damion Lee', 6.5, 210, 46, 'DamionLee.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kelly Oubre Jr.', 6.7, 203, 66, 'KellyOubreJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Juan Toscano-Anderson', 6.6, 209, 17, 'JuanToscanoAnderson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jordan Poole', 6.4, 194, 9, 'JordanPoole.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Eric Paschall', 6.6, 255, 2, 'EricPaschall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('James Wiseman', 7.0, 240, 26, 'JamesWiseman.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nico Mannion', 6.2, 190, 19, 'NicoMannion.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alen Smailagić', 6.1, 215, 49, 'AlenSmailagi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gary Payton II', 6.3, 190, 49, 'GaryPaytonII.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jordan Bell', 6.8, 216, 98, 'JordanBell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Klay Thompson', 6.6, 215, 37, 'KlayThompson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Danny Green', 6.6, 215, 19, 'DannyGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dwight Howard', 6.1, 265, 53, 'DwightHoward.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Matisse Thybulle', 6.5, 201, 13, 'MatisseThybulle.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Shake Milton', 6.5, 205, 71, 'ShakeMilton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tobias Harris', 6.8, 226, 62, 'TobiasHarris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyrese Maxey', 6.2, 200, 1, 'TyreseMaxey.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ben Simmons', 6.11, 240, 86, 'BenSimmons.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Seth Curry', 6.2, 185, 15, 'SethCurry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Furkan Korkmaz', 6.7, 202, 33, 'FurkanKorkmaz.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Joel Embiid', 7.0, 280, 41, 'JoelEmbiid.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mike Scott', 6.7, 237, 82, 'MikeScott.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaiah Joe', 6.4, 165, 56, 'IsaiahJoe.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Paul Reed', 6.9, 210, 91, 'PaulReed.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('George Hill', 6.4, 188, 89, 'GeorgeHill.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rayjon Tucker', 6.3, 209, 11, 'RayjonTucker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anthony Tolliver', 6.8, 240, 38, 'AnthonyTolliver.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gary Clark', 6.6, 225, 62, 'GaryClark.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyus Jones', 6.0, 196, 25, 'TyusJones.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kyle Anderson', 6.9, 230, 22, 'KyleAnderson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Desmond Bane', 6.5, 215, 63, 'DesmondBane.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dillon Brooks', 6.7, 225, 6, 'DillonBrooks.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ja Morant', 6.3, 174, 89, 'JaMorant.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jonas Valančiūnas', 6.11, 265, 16, 'JonasValaninas.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brandon Clarke', 6.8, 215, 46, 'BrandonClarke.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Xavier Tillman Sr.', 6.8, 245, 50, 'XavierTillmanSr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeAnthony Melton', 6.2, 200, 10, 'DeAnthonyMelton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Grayson Allen', 6.4, 198, 43, 'GraysonAllen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('John Konchar', 6.5, 210, 2, 'JohnKonchar.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Justise Winslow', 6.6, 222, 37, 'JustiseWinslow.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Killian Tillie', 6.9, 220, 65, 'KillianTillie.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sean McDermott', 6.6, 195, 70, 'SeanMcDermott.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaren Jackson Jr.', 6.11, 242, 65, 'JarenJacksonJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jontay Porter', 6.11, 240, 41, 'JontayPorter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Payton Pritchard', 6.1, 195, 92, 'PaytonPritchard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jayson Tatum', 6.8, 210, 34, 'JaysonTatum.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Grant Williams', 6.6, 236, 80, 'GrantWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaylen Brown', 6.6, 223, 84, 'JaylenBrown.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Semi Ojeleye', 6.6, 240, 15, 'SemiOjeleye.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tristan Thompson', 6.9, 254, 10, 'TristanThompson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Robert Williams', 6.8, 237, 81, 'RobertWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Marcus Smart', 6.3, 220, 21, 'MarcusSmart.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Aaron Nesmith', 6.5, 215, 74, 'AaronNesmith.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kemba Walker', 6.0, 184, 87, 'KembaWalker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Carsen Edwards', 5.11, 200, 49, 'CarsenEdwards.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tremont Waters', 5.1, 175, 71, 'TremontWaters.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tacko Fall', 7.5, 311, 51, 'TackoFall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luke Kornet', 7.2, 250, 28, 'LukeKornet.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Romeo Langford', 6.4, 216, 25, 'RomeoLangford.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Evan Fournier', 6.7, 205, 69, 'EvanFournier.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jabari Parker', 6.8, 245, 98, 'JabariParker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tim Hardaway Jr.', 6.5, 205, 21, 'TimHardawayJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jalen Brunson', 6.1, 190, 1, 'JalenBrunson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luka Dončić', 6.7, 230, 78, 'LukaDoni.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Trey Burke', 6.0, 185, 97, 'TreyBurke.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dorian Finney-Smith', 6.7, 220, 29, 'DorianFinneySmith.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Richardson', 6.5, 200, 57, 'JoshRichardson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dwight Powell', 6.1, 240, 72, 'DwightPowell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Willie Cauley-Stein', 7.0, 240, 86, 'WillieCauleyStein.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Maxi Kleber', 6.1, 240, 73, 'MaxiKleber.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kristaps Porziņģis', 7.3, 240, 74, 'KristapsPorziis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Green', 6.5, 200, 63, 'JoshGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Boban Marjanović', 7.4, 290, 25, 'BobanMarjanovi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nicolò Melli', 6.9, 236, 81, 'NicolMelli.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nate Hinton', 6.5, 210, 95, 'NateHinton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyler Bey', 6.7, 215, 48, 'TylerBey.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('J.J. Redick', 6.3, 200, 25, 'JJRedick.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyrell Terry', 6.2, 160, 2, 'TyrellTerry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anthony Edwards', 6.4, 225, 68, 'AnthonyEdwards.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Naz Reid', 6.9, 264, 67, 'NazReid.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ricky Rubio', 6.3, 190, 76, 'RickyRubio.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jarred Vanderbilt', 6.9, 214, 46, 'JarredVanderbilt.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaden McDaniels', 6.9, 185, 91, 'JadenMcDaniels.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Okogie', 6.4, 213, 93, 'JoshOkogie.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Juan Hernangómez', 6.9, 214, 46, 'JuanHernangmez.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jordan McLaughlin', 5.11, 185, 23, 'JordanMcLaughlin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Karl-Anthony Towns', 6.11, 248, 12, 'KarlAnthonyTowns.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jake Layman', 6.8, 209, 43, 'JakeLayman.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DAngelo Russell', 6.4, 193, 63, 'DAngeloRussell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaylen Nowell', 6.4, 201, 86, 'JaylenNowell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Malik Beasley', 6.4, 187, 1, 'MalikBeasley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jarrett Culver', 6.6, 195, 33, 'JarrettCulver.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ed Davis', 6.9, 218, 90, 'EdDavis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Stanley Johnson', 6.6, 242, 15, 'StanleyJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chris Boucher', 6.9, 200, 61, 'ChrisBoucher.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Pascal Siakam', 6.9, 230, 48, 'PascalSiakam.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Aron Baynes', 6.1, 260, 74, 'AronBaynes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Fred VanVleet', 6.1, 197, 32, 'FredVanVleet.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeAndre Bembry', 6.5, 210, 94, 'DeAndreBembry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Yuta Watanabe', 6.9, 215, 72, 'YutaWatanabe.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Malachi Flynn', 6.1, 175, 68, 'MalachiFlynn.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kyle Lowry', 6.0, 196, 74, 'KyleLowry.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('OG Anunoby', 6.7, 232, 50, 'OGAnunoby.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Paul Watson', 6.6, 210, 50, 'PaulWatson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Freddie Gillespie', 6.9, 245, 19, 'FreddieGillespie.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Khem Birch', 6.9, 233, 77, 'KhemBirch.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gary Trent Jr.', 6.5, 209, 42, 'GaryTrentJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rodney Hood', 6.8, 208, 26, 'RodneyHood.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jalen Harris', 6.5, 195, 29, 'JalenHarris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Keldon Johnson', 6.5, 220, 39, 'KeldonJohnson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jakob Poeltl', 7.1, 245, 67, 'JakobPoeltl.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Patty Mills', 6.1, 180, 45, 'PattyMills.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dejounte Murray', 6.4, 180, 87, 'DejounteMurray.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rudy Gay', 6.8, 250, 72, 'RudyGay.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Devin Vassell', 6.5, 200, 66, 'DevinVassell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DeMar DeRozan', 6.6, 220, 32, 'DeMarDeRozan.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Lonnie Walker', 6.4, 204, 28, 'LonnieWalker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Drew Eubanks', 6.9, 245, 37, 'DrewEubanks.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tre Jones', 6.1, 185, 84, 'TreJones.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Derrick White', 6.4, 190, 25, 'DerrickWhite.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luka Šamanić', 6.1, 227, 86, 'Lukaamani.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Keita Bates-Diop', 6.8, 229, 89, 'KeitaBatesDiop.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Trey Lyles', 6.9, 234, 68, 'TreyLyles.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Quinndary Weatherspoon', 6.3, 205, 19, 'QuinndaryWeatherspoon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gorgui Dieng', 6.1, 252, 2, 'GorguiDieng.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('DaQuan Jeffries', 6.5, 230, 4, 'DaQuanJeffries.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Patrick Williams', 6.7, 215, 96, 'PatrickWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Coby White', 6.5, 195, 20, 'CobyWhite.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Thaddeus Young', 6.8, 235, 80, 'ThaddeusYoung.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Denzel Valentine', 6.4, 220, 9, 'DenzelValentine.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Zach LaVine', 6.5, 200, 81, 'ZachLaVine.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tomáš Satoranský', 6.7, 210, 6, 'TomSatoransk.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Garrett Temple', 6.5, 195, 72, 'GarrettTemple.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Lauri Markkanen', 7.0, 240, 90, 'LauriMarkkanen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ryan Arcidiacono', 6.3, 195, 82, 'RyanArcidiacono.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nikola Vučević', 6.11, 260, 15, 'NikolaVuevi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Daniel Theis', 6.8, 245, 40, 'DanielTheis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cristiano Felício', 6.11, 270, 23, 'CristianoFelcio.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Javonte Green', 6.4, 205, 16, 'JavonteGreen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Adam Mokoka', 6.4, 190, 46, 'AdamMokoka.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Troy Brown Jr.', 6.6, 215, 52, 'TroyBrownJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Devon Dotson', 6.2, 185, 99, 'DevonDotson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Al-Farouq Aminu', 6.8, 220, 79, 'AlFarouqAminu.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Montrezl Harrell', 6.7, 240, 83, 'MontrezlHarrell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kyle Kuzma', 6.1, 221, 81, 'KyleKuzma.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kentavious Caldwell-Pope', 6.5, 204, 95, 'KentaviousCaldwellPope.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Talen Horton-Tucker', 6.4, 234, 31, 'TalenHortonTucker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dennis Schröder', 6.3, 172, 45, 'DennisSchrder.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Markieff Morris', 6.9, 245, 38, 'MarkieffMorris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alex Caruso', 6.4, 186, 46, 'AlexCaruso.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Wesley Matthews', 6.4, 220, 71, 'WesleyMatthews.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Marc Gasol', 6.11, 255, 94, 'MarcGasol.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('LeBron James', 6.9, 250, 15, 'LeBronJames.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alfonzo McKinnie', 6.7, 215, 14, 'AlfonzoMcKinnie.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anthony Davis', 6.1, 253, 91, 'AnthonyDavis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Andre Drummond', 6.1, 279, 14, 'AndreDrummond.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ben McLemore', 6.3, 195, 72, 'BenMcLemore.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Devontae Cacok', 6.7, 240, 87, 'DevontaeCacok.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kostas Antetokounmpo', 6.1, 200, 55, 'KostasAntetokounmpo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jared Dudley', 6.6, 237, 65, 'JaredDudley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Terry Rozier', 6.1, 190, 22, 'TerryRozier.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Miles Bridges', 6.6, 225, 18, 'MilesBridges.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bismack Biyombo', 6.8, 255, 94, 'BismackBiyombo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('P.J. Washington', 6.7, 230, 15, 'PJWashington.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Devonte Graham', 6.1, 195, 8, 'DevonteGraham.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Caleb Martin', 6.5, 205, 89, 'CalebMartin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cody Martin', 6.5, 205, 62, 'CodyMartin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('LaMelo Ball', 6.6, 180, 29, 'LaMeloBall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cody Zeller', 6.11, 240, 64, 'CodyZeller.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jalen McDaniels', 6.9, 205, 97, 'JalenMcDaniels.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gordon Hayward', 6.7, 225, 99, 'GordonHayward.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Malik Monk', 6.3, 200, 78, 'MalikMonk.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brad Wanamaker', 6.3, 210, 93, 'BradWanamaker.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Vernon Carey Jr.', 6.9, 270, 42, 'VernonCareyJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nick Richards', 7.0, 245, 62, 'NickRichards.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Grant Riller', 6.2, 190, 38, 'GrantRiller.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nate Darling', 6.6, 200, 32, 'NateDarling.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('JaeSean Tate', 6.4, 230, 67, 'JaeSeanTate.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sterling Brown', 6.5, 219, 81, 'SterlingBrown.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kenyon Martin Jr.', 6.6, 215, 37, 'KenyonMartinJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Christian Wood', 6.1, 214, 56, 'ChristianWood.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('John Wall', 6.3, 210, 22, 'JohnWall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Danuel House', 6.6, 220, 78, 'DanuelHouse.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('David Nwaba', 6.5, 219, 80, 'DavidNwaba.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kelly Olynyk', 6.11, 240, 36, 'KellyOlynyk.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Eric Gordon', 6.3, 215, 32, 'EricGordon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevin Porter Jr.', 6.4, 203, 95, 'KevinPorterJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Anthony Lamb', 6.6, 227, 73, 'AnthonyLamb.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('D.J. Wilson', 6.1, 231, 13, 'DJWilson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Armoni Brooks', 6.3, 195, 60, 'ArmoniBrooks.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('D.J. Augustin', 5.11, 183, 94, 'DJAugustin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Avery Bradley', 6.3, 180, 56, 'AveryBradley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Khyri Thomas', 6.3, 210, 51, 'KhyriThomas.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dante Exum', 6.5, 214, 80, 'DanteExum.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Duncan Robinson', 6.7, 215, 35, 'DuncanRobinson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Bam Adebayo', 6.9, 255, 90, 'BamAdebayo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Andre Iguodala', 6.6, 215, 35, 'AndreIguodala.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Precious Achiuwa', 6.8, 225, 69, 'PreciousAchiuwa.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kendrick Nunn', 6.2, 190, 3, 'KendrickNunn.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tyler Herro', 6.5, 195, 4, 'TylerHerro.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jimmy Butler', 6.7, 230, 1, 'JimmyButler.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Goran Dragić', 6.3, 190, 2, 'GoranDragi.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gabe Vincent', 6.3, 200, 44, 'GabeVincent.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Max Strus', 6.5, 215, 21, 'MaxStrus.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('KZ Okpala', 6.8, 215, 20, 'KZOkpala.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Trevor Ariza', 6.8, 215, 17, 'TrevorAriza.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dewayne Dedmon', 7.0, 245, 77, 'DewayneDedmon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nemanja Bjelica', 6.1, 234, 67, 'NemanjaBjelica.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Victor Oladipo', 6.4, 213, 92, 'VictorOladipo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Udonis Haslem', 6.8, 235, 43, 'UdonisHaslem.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Omer Yurtseven', 7.0, 264, 2, 'OmerYurtseven.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('RJ Barrett', 6.6, 214, 89, 'RJBarrett.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Julius Randle', 6.8, 250, 55, 'JuliusRandle.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Reggie Bullock', 6.6, 205, 4, 'ReggieBullock.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Immanuel Quickley', 6.3, 190, 35, 'ImmanuelQuickley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Nerlens Noel', 6.11, 220, 42, 'NerlensNoel.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Elfrid Payton', 6.3, 195, 83, 'ElfridPayton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Obi Toppin', 6.9, 220, 74, 'ObiToppin.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Alec Burks', 6.6, 214, 46, 'AlecBurks.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Taj Gibson', 6.9, 232, 97, 'TajGibson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevin Knox', 6.7, 215, 17, 'KevinKnox.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Derrick Rose', 6.2, 200, 69, 'DerrickRose.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Frank Ntilikina', 6.4, 200, 89, 'FrankNtilikina.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mitchell Robinson', 7.0, 240, 56, 'MitchellRobinson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Theo Pinson', 6.5, 212, 40, 'TheoPinson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Norvel Pelle', 6.1, 231, 41, 'NorvelPelle.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luca Vildoza', 6.3, 190, 92, 'LucaVildoza.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Saddiq Bey', 6.7, 215, 96, 'SaddiqBey.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaiah Stewart', 6.8, 250, 59, 'IsaiahStewart.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Jackson', 6.8, 207, 67, 'JoshJackson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mason Plumlee', 6.11, 254, 2, 'MasonPlumlee.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sekou Doumbouya', 6.8, 230, 44, 'SekouDoumbouya.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jerami Grant', 6.8, 210, 25, 'JeramiGrant.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Saben Lee', 6.2, 183, 85, 'SabenLee.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Wayne Ellington', 6.4, 207, 53, 'WayneEllington.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Frank Jackson', 6.3, 205, 42, 'FrankJackson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jahlil Okafor', 6.1, 270, 0, 'JahlilOkafor.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Killian Hayes', 6.5, 195, 65, 'KillianHayes.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Hamidou Diallo', 6.5, 202, 88, 'HamidouDiallo.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dennis Smith Jr.', 6.2, 205, 26, 'DennisSmithJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Deividas Sirvydis', 6.8, 190, 52, 'DeividasSirvydis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cory Joseph', 6.3, 200, 47, 'CoryJoseph.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Rodney McGruder', 6.4, 205, 49, 'RodneyMcGruder.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kenrich Williams', 6.6, 210, 3, 'KenrichWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Théo Maledon', 6.4, 175, 37, 'ThoMaledon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaiah Roby', 6.8, 230, 29, 'IsaiahRoby.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Darius Bazley', 6.8, 208, 46, 'DariusBazley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Luguentz Dort', 6.3, 215, 71, 'LuguentzDort.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Aleksej Pokusevski', 7.0, 190, 56, 'AleksejPokusevski.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Moses Brown', 7.2, 245, 27, 'MosesBrown.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Shai Gilgeous-Alexander', 6.6, 180, 6, 'ShaiGilgeousAlexander.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mike Muscala', 6.1, 240, 62, 'MikeMuscala.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ty Jerome', 6.5, 195, 10, 'TyJerome.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sviatoslav Mykhailiuk', 6.7, 205, 90, 'SviatoslavMykhailiuk.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Al Horford', 6.9, 240, 15, 'AlHorford.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Tony Bradley', 6.1, 248, 59, 'TonyBradley.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Josh Hall', 6.9, 190, 24, 'JoshHall.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jaylen Hoard', 6.8, 216, 74, 'JaylenHoard.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gabriel Deck', 6.8, 232, 49, 'GabrielDeck.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dwayne Bacon', 6.6, 221, 89, 'DwayneBacon.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cole Anthony', 6.2, 185, 30, 'ColeAnthony.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Terrence Ross', 6.6, 206, 80, 'TerrenceRoss.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Mo Bamba', 7.0, 231, 43, 'MoBamba.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chuma Okeke', 6.6, 229, 11, 'ChumaOkeke.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('James Ennis', 6.6, 215, 35, 'JamesEnnis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Chasson Randle', 6.2, 185, 42, 'ChassonRandle.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Michael Carter-Williams', 6.5, 190, 50, 'MichaelCarterWilliams.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('R.J. Hampton', 6.4, 175, 22, 'RJHampton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Wendell Carter Jr.', 6.1, 270, 78, 'WendellCarterJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Gary Harris', 6.4, 210, 1, 'GaryHarris.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Moritz Wagner', 6.11, 245, 35, 'MoritzWagner.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Markelle Fultz', 6.3, 209, 36, 'MarkelleFultz.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Ignas Brazdeikis', 6.6, 221, 71, 'IgnasBrazdeikis.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Sindarius Thornwell', 6.4, 215, 77, 'SindariusThornwell.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Otto Porter', 6.8, 198, 10, 'OttoPorter.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jonathan Isaac', 6.11, 230, 96, 'JonathanIsaac.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaac Okoro', 6.5, 225, 93, 'IsaacOkoro.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dean Wade', 6.9, 228, 82, 'DeanWade.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Collin Sexton', 6.1, 190, 43, 'CollinSexton.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Cedi Osman', 6.7, 230, 61, 'CediOsman.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Darius Garland', 6.1, 192, 40, 'DariusGarland.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jarrett Allen', 6.11, 243, 86, 'JarrettAllen.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Damyean Dotson', 6.5, 210, 27, 'DamyeanDotson.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Lamar Stevens', 6.6, 230, 59, 'LamarStevens.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Larry Nance Jr.', 6.7, 245, 20, 'LarryNanceJr.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Dylan Windler', 6.6, 196, 6, 'DylanWindler.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Taurean Prince', 6.7, 218, 3, 'TaureanPrince.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Brodric Thomas', 6.5, 185, 99, 'BrodricThomas.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Kevin Love', 6.8, 251, 21, 'KevinLove.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Isaiah Hartenstein', 7.0, 250, 7, 'IsaiahHartenstein.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Matthew Dellavedova', 6.3, 200, 7, 'MatthewDellavedova.jpg');
INSERT INTO player(p_name, p_height, p_weight, p_number, p_img) VALUES ('Jeremiah Martin', 6.3, 185, 11, 'JeremiahMartin.jpg');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (1, 'Bucks', '2019-2-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (2, 'Bucks', '2018-6-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (3, 'Bucks', '2015-3-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (4, 'Bucks', '2013-3-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (5, 'Bucks', '2015-12-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (6, 'Bucks', '2010-8-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (7, 'Bucks', '2013-4-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (8, 'Bucks', '2015-8-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (9, 'Bucks', '2019-7-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (10, 'Bucks', '2018-10-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (11, 'Bucks', '2011-2-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (12, 'Bucks', '2017-3-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (13, 'Bucks', '2010-11-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (14, 'Bucks', '2018-1-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (15, 'Bucks', '2020-2-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (16, 'Bucks', '2018-2-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (17, 'Bucks', '2018-5-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (18, 'Nets', '2016-6-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (19, 'Nets', '2013-2-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (20, 'Nets', '2020-8-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (21, 'Nets', '2018-2-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (22, 'Nets', '2010-4-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (23, 'Nets', '2011-1-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (24, 'Nets', '2011-8-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (25, 'Nets', '2020-5-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (26, 'Nets', '2020-8-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (27, 'Nets', '2013-5-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (28, 'Nets', '2011-10-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (29, 'Nets', '2018-4-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (30, 'Nets', '2010-6-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (31, 'Nets', '2020-8-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (32, 'Nets', '2014-8-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (33, 'Nets', '2011-10-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (34, 'Nets', '2020-4-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (35, 'Wizards', '2012-12-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (36, 'Wizards', '2017-1-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (37, 'Wizards', '2016-8-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (38, 'Wizards', '2011-5-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (39, 'Wizards', '2013-8-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (40, 'Wizards', '2012-4-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (41, 'Wizards', '2012-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (42, 'Wizards', '2015-10-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (43, 'Wizards', '2020-9-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (44, 'Wizards', '2018-2-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (45, 'Wizards', '2020-4-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (46, 'Wizards', '2010-4-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (47, 'Wizards', '2015-3-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (48, 'Wizards', '2016-2-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (49, 'Wizards', '2015-5-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (50, 'Wizards', '2013-2-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (51, 'Wizards', '2017-9-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (52, 'Jazz', '2013-7-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (53, 'Jazz', '2019-10-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (54, 'Jazz', '2014-8-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (55, 'Jazz', '2015-12-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (56, 'Jazz', '2016-12-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (57, 'Jazz', '2019-8-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (58, 'Jazz', '2010-1-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (59, 'Jazz', '2015-5-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (60, 'Jazz', '2013-5-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (61, 'Jazz', '2017-5-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (62, 'Jazz', '2020-5-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (63, 'Jazz', '2015-4-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (64, 'Jazz', '2016-4-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (65, 'Jazz', '2020-6-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (66, 'Jazz', '2012-6-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (67, 'Jazz', '2020-5-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (68, 'Jazz', '2019-4-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (69, 'Blazers', '2010-11-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (70, 'Blazers', '2013-9-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (71, 'Blazers', '2012-8-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (72, 'Blazers', '2013-7-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (73, 'Blazers', '2010-12-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (74, 'Blazers', '2013-10-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (75, 'Blazers', '2018-3-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (76, 'Blazers', '2015-7-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (77, 'Blazers', '2020-6-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (78, 'Blazers', '2020-5-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (79, 'Blazers', '2014-3-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (80, 'Blazers', '2013-4-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (81, 'Blazers', '2017-11-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (82, 'Blazers', '2014-8-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (83, 'Blazers', '2015-5-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (84, 'Blazers', '2017-7-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (85, 'Suns', '2015-11-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (86, 'Suns', '2017-9-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (87, 'Suns', '2011-5-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (88, 'Suns', '2011-11-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (89, 'Suns', '2017-2-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (90, 'Suns', '2011-6-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (91, 'Suns', '2016-2-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (92, 'Suns', '2020-8-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (93, 'Suns', '2011-5-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (94, 'Suns', '2011-10-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (95, 'Suns', '2011-8-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (96, 'Suns', '2013-1-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (97, 'Suns', '2013-10-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (98, 'Suns', '2010-5-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (99, 'Suns', '2016-3-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (100, 'Suns', '2011-7-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (101, 'Pacers', '2015-7-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (102, 'Pacers', '2016-3-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (103, 'Pacers', '2014-8-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (104, 'Pacers', '2015-5-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (105, 'Pacers', '2017-9-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (106, 'Pacers', '2013-3-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (107, 'Pacers', '2012-8-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (108, 'Pacers', '2016-7-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (109, 'Pacers', '2018-11-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (110, 'Pacers', '2012-5-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (111, 'Pacers', '2012-8-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (112, 'Pacers', '2016-12-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (113, 'Pacers', '2019-1-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (114, 'Pacers', '2019-4-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (115, 'Pacers', '2017-5-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (116, 'Pacers', '2010-7-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (117, 'Pacers', '2016-3-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (118, 'Nuggets', '2017-10-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (119, 'Nuggets', '2014-11-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (120, 'Nuggets', '2012-11-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (121, 'Nuggets', '2010-3-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (122, 'Nuggets', '2017-3-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (123, 'Nuggets', '2013-10-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (124, 'Nuggets', '2016-9-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (125, 'Nuggets', '2018-9-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (126, 'Nuggets', '2013-11-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (127, 'Nuggets', '2018-9-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (128, 'Nuggets', '2017-11-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (129, 'Nuggets', '2012-3-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (130, 'Nuggets', '2018-6-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (131, 'Nuggets', '2018-8-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (132, 'Nuggets', '2020-12-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (133, 'Nuggets', '2018-2-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (134, 'Nuggets', '2014-9-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (135, 'Pelicans', '2017-9-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (136, 'Pelicans', '2011-9-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (137, 'Pelicans', '2015-5-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (138, 'Pelicans', '2019-6-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (139, 'Pelicans', '2011-7-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (140, 'Pelicans', '2020-8-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (141, 'Pelicans', '2010-12-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (142, 'Pelicans', '2019-7-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (143, 'Pelicans', '2011-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (144, 'Pelicans', '2015-12-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (145, 'Pelicans', '2019-2-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (146, 'Pelicans', '2014-3-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (147, 'Pelicans', '2012-11-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (148, 'Pelicans', '2018-11-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (149, 'Pelicans', '2010-7-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (150, 'Pelicans', '2012-5-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (151, 'Clippers', '2020-1-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (152, 'Clippers', '2010-1-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (153, 'Clippers', '2010-7-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (154, 'Clippers', '2019-4-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (155, 'Clippers', '2020-10-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (156, 'Clippers', '2012-3-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (157, 'Clippers', '2010-6-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (158, 'Clippers', '2018-6-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (159, 'Clippers', '2013-12-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (160, 'Clippers', '2011-10-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (161, 'Clippers', '2010-4-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (162, 'Clippers', '2014-5-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (163, 'Clippers', '2015-6-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (164, 'Clippers', '2012-8-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (165, 'Clippers', '2011-6-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (166, 'Clippers', '2016-1-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (167, 'Clippers', '2014-6-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (168, 'Hawks', '2016-2-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (169, 'Hawks', '2020-3-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (170, 'Hawks', '2015-1-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (171, 'Hawks', '2015-1-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (172, 'Hawks', '2019-3-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (173, 'Hawks', '2014-3-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (174, 'Hawks', '2014-1-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (175, 'Hawks', '2020-7-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (176, 'Hawks', '2019-7-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (177, 'Hawks', '2014-4-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (178, 'Hawks', '2019-11-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (179, 'Hawks', '2017-6-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (180, 'Hawks', '2016-2-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (181, 'Hawks', '2016-6-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (182, 'Hawks', '2013-11-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (183, 'Hawks', '2018-8-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (184, 'Hawks', '2011-11-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (185, 'Kings', '2010-4-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (186, 'Kings', '2010-3-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (187, 'Kings', '2010-10-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (188, 'Kings', '2019-11-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (189, 'Kings', '2016-9-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (190, 'Kings', '2014-11-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (191, 'Kings', '2020-3-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (192, 'Kings', '2010-10-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (193, 'Kings', '2010-9-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (194, 'Kings', '2018-7-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (195, 'Kings', '2015-1-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (196, 'Kings', '2010-7-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (197, 'Kings', '2019-4-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (198, 'Kings', '2017-4-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (199, 'Kings', '2013-5-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (200, 'Kings', '2012-1-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (201, 'Warriors', '2018-2-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (202, 'Warriors', '2017-3-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (203, 'Warriors', '2020-6-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (204, 'Warriors', '2014-10-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (205, 'Warriors', '2015-2-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (206, 'Warriors', '2011-11-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (207, 'Warriors', '2018-12-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (208, 'Warriors', '2017-3-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (209, 'Warriors', '2014-9-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (210, 'Warriors', '2017-3-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (211, 'Warriors', '2017-1-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (212, 'Warriors', '2017-10-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (213, 'Warriors', '2019-3-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (214, 'Warriors', '2011-9-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (215, 'Warriors', '2019-9-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (216, 'Warriors', '2017-4-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (217, 'Warriors', '2012-11-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (218, '76ers', '2018-10-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (219, '76ers', '2012-3-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (220, '76ers', '2013-4-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (221, '76ers', '2018-6-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (222, '76ers', '2013-4-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (223, '76ers', '2013-6-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (224, '76ers', '2018-2-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (225, '76ers', '2017-7-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (226, '76ers', '2011-8-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (227, '76ers', '2011-4-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (228, '76ers', '2011-2-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (229, '76ers', '2019-1-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (230, '76ers', '2010-11-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (231, '76ers', '2011-12-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (232, '76ers', '2017-11-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (233, '76ers', '2019-10-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (234, '76ers', '2010-3-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (235, 'Grizzlies', '2013-8-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (236, 'Grizzlies', '2020-6-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (237, 'Grizzlies', '2018-11-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (238, 'Grizzlies', '2019-11-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (239, 'Grizzlies', '2017-2-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (240, 'Grizzlies', '2018-8-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (241, 'Grizzlies', '2012-5-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (242, 'Grizzlies', '2018-7-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (243, 'Grizzlies', '2010-12-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (244, 'Grizzlies', '2013-10-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (245, 'Grizzlies', '2018-7-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (246, 'Grizzlies', '2019-11-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (247, 'Grizzlies', '2011-12-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (248, 'Grizzlies', '2020-12-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (249, 'Grizzlies', '2010-8-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (250, 'Grizzlies', '2013-12-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (251, 'Celtics', '2020-7-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (252, 'Celtics', '2017-6-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (253, 'Celtics', '2020-7-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (254, 'Celtics', '2014-10-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (255, 'Celtics', '2018-5-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (256, 'Celtics', '2015-3-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (257, 'Celtics', '2017-12-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (258, 'Celtics', '2016-9-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (259, 'Celtics', '2017-4-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (260, 'Celtics', '2010-9-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (261, 'Celtics', '2017-6-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (262, 'Celtics', '2013-12-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (263, 'Celtics', '2010-1-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (264, 'Celtics', '2011-7-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (265, 'Celtics', '2011-11-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (266, 'Celtics', '2011-11-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (267, 'Celtics', '2018-10-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (268, 'Mavericks', '2014-5-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (269, 'Mavericks', '2010-5-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (270, 'Mavericks', '2010-12-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (271, 'Mavericks', '2017-6-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (272, 'Mavericks', '2018-1-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (273, 'Mavericks', '2014-6-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (274, 'Mavericks', '2017-3-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (275, 'Mavericks', '2013-10-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (276, 'Mavericks', '2017-3-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (277, 'Mavericks', '2010-4-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (278, 'Mavericks', '2016-4-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (279, 'Mavericks', '2016-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (280, 'Mavericks', '2011-4-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (281, 'Mavericks', '2020-10-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (282, 'Mavericks', '2015-10-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (283, 'Mavericks', '2015-4-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (284, 'Mavericks', '2011-11-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (285, 'Timberwolves', '2019-2-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (286, 'Timberwolves', '2015-11-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (287, 'Timberwolves', '2011-10-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (288, 'Timberwolves', '2018-7-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (289, 'Timberwolves', '2014-12-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (290, 'Timberwolves', '2018-3-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (291, 'Timberwolves', '2017-8-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (292, 'Timberwolves', '2016-8-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (293, 'Timberwolves', '2014-3-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (294, 'Timberwolves', '2017-3-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (295, 'Timberwolves', '2013-4-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (296, 'Timberwolves', '2010-9-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (297, 'Timberwolves', '2013-4-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (298, 'Timberwolves', '2014-2-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (299, 'Timberwolves', '2014-1-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (300, 'Raptors', '2015-1-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (301, 'Raptors', '2018-12-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (302, 'Raptors', '2017-10-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (303, 'Raptors', '2016-6-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (304, 'Raptors', '2018-1-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (305, 'Raptors', '2010-12-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (306, 'Raptors', '2017-12-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (307, 'Raptors', '2020-6-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (308, 'Raptors', '2017-3-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (309, 'Raptors', '2016-4-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (310, 'Raptors', '2011-12-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (311, 'Raptors', '2013-2-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (312, 'Raptors', '2016-4-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (313, 'Raptors', '2010-7-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (314, 'Raptors', '2016-10-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (315, 'Raptors', '2012-4-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (316, 'Spurs', '2017-9-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (317, 'Spurs', '2011-1-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (318, 'Spurs', '2016-7-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (319, 'Spurs', '2020-1-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (320, 'Spurs', '2010-4-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (321, 'Spurs', '2017-2-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (322, 'Spurs', '2013-2-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (323, 'Spurs', '2015-8-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (324, 'Spurs', '2013-5-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (325, 'Spurs', '2018-12-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (326, 'Spurs', '2020-10-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (327, 'Spurs', '2012-5-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (328, 'Spurs', '2020-2-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (329, 'Spurs', '2013-1-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (330, 'Spurs', '2013-6-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (331, 'Spurs', '2013-9-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (332, 'Spurs', '2017-1-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (333, 'Bulls', '2020-1-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (334, 'Bulls', '2011-8-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (335, 'Bulls', '2018-4-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (336, 'Bulls', '2017-1-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (337, 'Bulls', '2010-7-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (338, 'Bulls', '2011-12-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (339, 'Bulls', '2011-1-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (340, 'Bulls', '2020-1-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (341, 'Bulls', '2016-3-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (342, 'Bulls', '2014-7-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (343, 'Bulls', '2017-5-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (344, 'Bulls', '2014-9-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (345, 'Bulls', '2013-10-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (346, 'Bulls', '2010-2-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (347, 'Bulls', '2012-6-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (348, 'Bulls', '2013-7-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (349, 'Bulls', '2014-7-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (350, 'Lakers', '2015-6-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (351, 'Lakers', '2011-2-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (352, 'Lakers', '2015-5-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (353, 'Lakers', '2011-8-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (354, 'Lakers', '2016-3-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (355, 'Lakers', '2011-6-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (356, 'Lakers', '2012-4-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (357, 'Lakers', '2019-3-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (358, 'Lakers', '2016-2-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (359, 'Lakers', '2020-5-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (360, 'Lakers', '2020-12-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (361, 'Lakers', '2010-1-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (362, 'Lakers', '2013-11-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (363, 'Lakers', '2016-7-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (364, 'Lakers', '2017-11-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (365, 'Lakers', '2011-12-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (366, 'Lakers', '2014-3-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (367, 'Hornets', '2011-12-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (368, 'Hornets', '2017-10-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (369, 'Hornets', '2013-2-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (370, 'Hornets', '2015-12-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (371, 'Hornets', '2019-7-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (372, 'Hornets', '2014-7-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (373, 'Hornets', '2020-6-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (374, 'Hornets', '2019-2-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (375, 'Hornets', '2018-5-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (376, 'Hornets', '2018-4-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (377, 'Hornets', '2012-1-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (378, 'Hornets', '2018-2-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (379, 'Hornets', '2012-4-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (380, 'Hornets', '2020-5-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (381, 'Hornets', '2011-2-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (382, 'Hornets', '2015-6-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (383, 'Hornets', '2016-9-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (384, 'Rockets', '2013-10-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (385, 'Rockets', '2012-8-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (386, 'Rockets', '2013-10-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (387, 'Rockets', '2014-6-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (388, 'Rockets', '2011-7-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (389, 'Rockets', '2010-11-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (390, 'Rockets', '2011-9-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (391, 'Rockets', '2010-4-14');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (392, 'Rockets', '2011-9-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (393, 'Rockets', '2015-1-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (394, 'Rockets', '2019-4-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (395, 'Rockets', '2020-7-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (396, 'Rockets', '2017-11-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (397, 'Rockets', '2012-1-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (398, 'Rockets', '2013-4-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (399, 'Rockets', '2010-7-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (400, 'Rockets', '2017-2-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (401, 'Heat', '2018-9-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (402, 'Heat', '2016-9-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (403, 'Heat', '2014-11-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (404, 'Heat', '2014-11-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (405, 'Heat', '2010-3-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (406, 'Heat', '2014-8-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (407, 'Heat', '2017-10-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (408, 'Heat', '2014-12-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (409, 'Heat', '2012-3-23');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (410, 'Heat', '2019-2-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (411, 'Heat', '2014-4-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (412, 'Heat', '2016-1-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (413, 'Heat', '2019-11-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (414, 'Heat', '2014-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (415, 'Heat', '2018-9-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (416, 'Heat', '2015-5-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (417, 'Heat', '2013-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (418, 'Knicks', '2020-1-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (419, 'Knicks', '2013-3-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (420, 'Knicks', '2013-7-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (421, 'Knicks', '2016-7-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (422, 'Knicks', '2017-3-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (423, 'Knicks', '2013-4-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (424, 'Knicks', '2016-6-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (425, 'Knicks', '2012-9-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (426, 'Knicks', '2019-8-27');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (427, 'Knicks', '2012-12-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (428, 'Knicks', '2014-2-22');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (429, 'Knicks', '2019-10-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (430, 'Knicks', '2015-7-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (431, 'Knicks', '2015-9-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (432, 'Knicks', '2012-4-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (433, 'Knicks', '2010-1-4');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (434, 'Pistons', '2015-12-17');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (435, 'Pistons', '2019-5-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (436, 'Pistons', '2018-5-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (437, 'Pistons', '2020-6-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (438, 'Pistons', '2014-8-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (439, 'Pistons', '2015-8-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (440, 'Pistons', '2015-1-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (441, 'Pistons', '2015-9-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (442, 'Pistons', '2015-1-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (443, 'Pistons', '2011-4-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (444, 'Pistons', '2011-12-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (445, 'Pistons', '2017-2-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (446, 'Pistons', '2011-9-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (447, 'Pistons', '2018-6-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (448, 'Pistons', '2016-5-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (449, 'Pistons', '2014-10-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (450, 'Thunder', '2013-6-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (451, 'Thunder', '2019-9-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (452, 'Thunder', '2012-7-10');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (453, 'Thunder', '2013-1-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (454, 'Thunder', '2020-9-15');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (455, 'Thunder', '2012-9-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (456, 'Thunder', '2019-9-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (457, 'Thunder', '2011-1-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (458, 'Thunder', '2016-3-19');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (459, 'Thunder', '2011-8-1');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (460, 'Thunder', '2015-7-21');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (461, 'Thunder', '2010-11-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (462, 'Thunder', '2011-7-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (463, 'Thunder', '2010-3-28');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (464, 'Thunder', '2013-4-13');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (465, 'Thunder', '2020-3-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (466, 'Magic', '2010-12-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (467, 'Magic', '2014-10-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (468, 'Magic', '2012-5-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (469, 'Magic', '2020-5-8');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (470, 'Magic', '2017-8-6');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (471, 'Magic', '2011-10-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (472, 'Magic', '2014-5-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (473, 'Magic', '2015-2-3');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (474, 'Magic', '2012-5-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (475, 'Magic', '2019-9-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (476, 'Magic', '2010-8-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (477, 'Magic', '2010-7-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (478, 'Magic', '2012-3-16');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (479, 'Magic', '2020-7-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (480, 'Magic', '2018-8-18');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (481, 'Magic', '2011-3-12');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (482, 'Magic', '2012-7-11');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (483, 'Cavaliers', '2017-10-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (484, 'Cavaliers', '2011-1-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (485, 'Cavaliers', '2011-2-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (486, 'Cavaliers', '2011-7-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (487, 'Cavaliers', '2018-9-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (488, 'Cavaliers', '2012-6-26');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (489, 'Cavaliers', '2017-1-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (490, 'Cavaliers', '2011-9-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (491, 'Cavaliers', '2016-7-9');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (492, 'Cavaliers', '2014-11-25');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (493, 'Cavaliers', '2020-3-24');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (494, 'Cavaliers', '2015-10-5');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (495, 'Cavaliers', '2020-8-7');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (496, 'Cavaliers', '2014-2-20');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (497, 'Cavaliers', '2010-3-2');
INSERT INTO player_team(p_id, t_name, in_time) VALUES (498, 'Cavaliers', '2015-3-5');

INSERT INTO playoff(area, t1, t2) VALUES(1, 'Jazz', 'Grizzlies');
INSERT INTO playoff(area, t1, t2) VALUES(2, 'Clippers', 'Mavericks');
INSERT INTO playoff(area, t1, t2) VALUES(3, 'Nuggets', 'Blazers');
INSERT INTO playoff(area, t1, t2) VALUES(4, 'Suns', 'Lakers');
INSERT INTO playoff(area, t1, t2) VALUES(5, '76ers', 'Wizards');
INSERT INTO playoff(area, t1, t2) VALUES(6, 'Knicks', 'Hawks');
INSERT INTO playoff(area, t1, t2) VALUES(7, 'Bucks', 'Heat');
INSERT INTO playoff(area, t1, t2) VALUES(8, 'Nets', 'Celtics');

-- INSERT INTO playoff(area, tname) VALUES(1, 'Jazz');
-- INSERT INTO playoff(area, tname) VALUES(1, 'Grizzlies');
-- INSERT INTO playoff(area, tname) VALUES(2, 'Clippers');
-- INSERT INTO playoff(area, tname) VALUES(2, 'Mavericks');
-- INSERT INTO playoff(area, tname) VALUES(3, 'Nuggets');
-- INSERT INTO playoff(area, tname) VALUES(3, 'Blazers');
-- INSERT INTO playoff(area, tname) VALUES(4, 'Suns');
-- INSERT INTO playoff(area, tname) VALUES(4, 'Lakers');
-- INSERT INTO playoff(area, tname) VALUES(5, '76ers');
-- INSERT INTO playoff(area, tname) VALUES(5, 'Wizards');
-- INSERT INTO playoff(area, tname) VALUES(6, 'Knicks');
-- INSERT INTO playoff(area, tname) VALUES(6, 'Hawks');
-- INSERT INTO playoff(area, tname) VALUES(7, 'Bucks');
-- INSERT INTO playoff(area, tname) VALUES(7, 'Heat');
-- INSERT INTO playoff(area, tname) VALUES(8, 'Nets');
-- INSERT INTO playoff(area, tname) VALUES(8, 'Celtics');


insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Heat', 'Bucks', '2021-5-23', 107, 109);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Mavericks', 'Clippers', '2021-5-23', 113, 103);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Celtics', 'Nets', '2021-5-23', 93, 104);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Blazers', 'Nuggets', '2021-5-23', 123, 109);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Wizards', '76ers', '2021-5-24', 118, 125);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Lakers', 'Suns', '2021-5-24', 90, 99);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Hawks', 'Knicks', '2021-5-25', 98, 132);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Grizzlies', 'Jazz', '2021-5-24', 112, 109);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Heat', 'Bucks', '2021-5-25', 98, 132);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Blazers', 'Nuggets', '2021-5-25', 109, 128);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Celtics', 'Nets', '2021-5-26', 108, 130);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Lakers', 'Suns', '2021-5-26', 109, 102);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Mavericks', 'Clippers', '2021-5-26', 127, 121);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Wizards', '76ers', '2021-5-27', 129, 141);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Hawks', 'Knicks', '2021-5-27', 92, 101);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Grizzlies', 'Jazz', '2021-5-27', 129, 141);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Bucks', 'Heat', '2021-5-28', 113, 84);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Suns', 'Lakers', '2021-5-28', 95, 109);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nuggets', 'Blazers', '2021-5-28', 120, 115);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Knicks', 'Hawks', '2021-5-29', 94, 105);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nets', 'Celtics', '2021-5-29', 119, 125);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Clippers', 'Mavericks', '2021-5-29', 118, 108);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Bucks', 'Heat', '2021-5-30', 120, 103);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nuggets', 'Blazers', '2021-5-30', 95, 115);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('76ers', 'Wizards', '2021-5-30', 132, 103);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Jazz', 'Grizzlies', '2021-5-30', 121, 111);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Knicks', 'Hawks', '2021-5-31', 96, 113);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Suns', 'Lakers', '2021-5-31', 100, 92);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nets', 'Celtics', '2021-5-31', 141, 126);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Clippers', 'Mavericks', '2021-5-31', 106, 81);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('76ers', 'Wizards', '2021-6-1', 114, 122);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Jazz', 'Grizzlies', '2021-6-1', 120, 113);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Celtics', 'Nets', '2021-6-2', 109, 123);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Blazers', 'Nuggets', '2021-6-2', 140, 147);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Lakers', 'Suns', '2021-6-2', 85, 115);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Wizards', '76ers', '2021-6-3', 112, 129);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Hawks', 'Knicks', '2021-6-3', 103, 89);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Grizzlies', 'Jazz', '2021-6-3', 110, 126);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Mavericks', 'Clippers', '2021-6-3', 105, 100);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nuggets', 'Blazers', '2021-6-4', 126, 115);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Suns', 'Lakers', '2021-6-4', 113, 100);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Clippers', 'Mavericks', '2021-6-5', 104, 97);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Mavericks', 'Clippers', '2021-6-7', 111, 126);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Bucks', 'Nets', '2021-6-6', 107, 115);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Hawks', '76ers', '2021-6-7', 128, 124);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Bucks', 'Nets', '2021-6-8', 86, 125);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Nuggets', 'Suns', '2021-6-8', 105, 122);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Hawks', '76ers', '2021-6-9', 102, 118);
insert into over_match(home_name, away_name, m_time, home_score, away_score) values ('Clippers', 'Jazz', '2021-6-9', 109, 112);

insert into nst_match(home_name, away_name, m_time) values ('Nuggets', 'Suns', '2021-6-10 9:30');
insert into nst_match(home_name, away_name, m_time) values ('Nets', 'Bucks', '2021-6-11 7:30');
insert into nst_match(home_name, away_name, m_time) values ('Clippers', 'Nuggets', '2021-6-12 10:00');
insert into nst_match(home_name, away_name, m_time) values ('76ers', 'Hawks', '2021-6-12 7:30');
insert into nst_match(home_name, away_name, m_time) values ('Suns', 'Nuggets', '2021-6-12 10:00');

