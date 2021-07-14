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


