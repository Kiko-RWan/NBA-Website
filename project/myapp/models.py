# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Team(models.Model):
    t_name = models.CharField(primary_key=True, max_length=30)
    t_city = models.CharField(max_length=30, blank=True, null=True)
    t_home = models.CharField(max_length=30, blank=True, null=True)
    t_icon = models.CharField(max_length=50, blank=True, null=True)
    total = models.IntegerField(blank=True, null=True)
    win = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'team'

    def __str__(self):
        return self.t_name

class Coach(models.Model):
    c_id = models.AutoField(primary_key=True)
    c_name = models.CharField(max_length=20)
    c_img = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'coach'
    
    def __str__(self):
        return self.c_name

class Player(models.Model):
    p_id = models.AutoField(primary_key=True)
    p_name = models.CharField(max_length=30)
    p_height = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    p_weight = models.DecimalField(max_digits=4, decimal_places=1, blank=True, null=True)
    p_number = models.IntegerField()
    p_img = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'player'

    def __str__(self):
        return self.p_name

class Users(models.Model):
    u_name = models.CharField(primary_key=True, max_length=15)
    u_password = models.CharField(max_length=50)
    u_mail = models.CharField(max_length=30, blank=True, null=True)
    u_img = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users'

    def __str__(self):
        return self.u_name


class Article(models.Model):
    a_id = models.AutoField(primary_key=True)
    a_title = models.CharField(max_length=50)
    a_abs = models.CharField(max_length=50, blank=True, null=True)
    a_path = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'article'

    def __str__(self):
        return self.a_title


class CoachTeam(models.Model):
    c = models.ForeignKey(Coach, models.DO_NOTHING, primary_key=True)
    t_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='t_name')
    in_time = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'coach_team'

    def __str__(self):
        return self.t_name


class Matching(models.Model):
    m_id = models.AutoField(primary_key=True)
    home_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='home_name', related_name='+')
    away_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='away_name', related_name='+')
    m_time = models.DateTimeField()
    m_state = models.CharField(max_length=10)
    home_score = models.IntegerField()
    away_score = models.IntegerField()
    m_path = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'matching'

    def t1(self):
        return self.home_name

    def t2(self):
        return self.away_name

    def mtime(self):
        return str(self.m_time)

    def __str__(self):
        return f'{self.t1()} vs {self.t2()} {self.mtime()}'



class NstMatch(models.Model):
    m_id = models.AutoField(primary_key=True)
    home_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='home_name', related_name='+')
    away_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='away_name', related_name='+')
    m_time = models.DateTimeField()
    m_path = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'nst_match'

    def t1(self):
        return self.home_name

    def t2(self):
        return self.away_name

    def mtime(self):
        return str(self.m_time)

    def __str__(self):
        return f'{self.t1()} vs {self.t2()} {self.mtime()}'


class OverMatch(models.Model):
    m_id = models.AutoField(primary_key=True)
    home_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='home_name', related_name='+')
    away_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='away_name', related_name='+')
    m_time = models.DateTimeField()
    home_score = models.IntegerField()
    away_score = models.IntegerField()
    m_path = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'over_match'

    def t1(self):
        return self.home_name

    def t2(self):
        return self.away_name

    def mtime(self):
        return str(self.m_time)

    def __str__(self):
        return f'{self.t1()} vs {self.t2()} {self.mtime()}'




class PlayerTeam(models.Model):
    p = models.ForeignKey(Player, models.DO_NOTHING, primary_key=True)
    t_name = models.ForeignKey('Team', models.DO_NOTHING, db_column='t_name')
    in_time = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'player_team'

    


class Playoff(models.Model):
    area = models.IntegerField(primary_key=True)
    t1 = models.ForeignKey('Team', models.DO_NOTHING, db_column='t1', blank=True, null=True, related_name='+')
    t2 = models.ForeignKey('Team', models.DO_NOTHING, db_column='t2', blank=True, null=True, related_name='+')
    score1 = models.IntegerField(blank=True, null=True)
    score2 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'playoff'

    def team1(self):
        return self.t1

    def team2(self):
        return self.t2

    def c1(self):
        return self.score1

    def c2(self):
        return self.score2

    def __str__(self):
        return f'{self.team1()} {self.c1()}vs{self.c2()} {self.team2()}'


class Written(models.Model):
    u_name = models.ForeignKey(Users, models.DO_NOTHING, db_column='u_name')
    a = models.ForeignKey(Article, models.DO_NOTHING, primary_key=True)
    release = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'written'
