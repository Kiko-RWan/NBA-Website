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

