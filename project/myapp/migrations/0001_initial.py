# Generated by Django 3.2.4 on 2021-06-10 09:20

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('a_id', models.AutoField(primary_key=True, serialize=False)),
                ('a_title', models.CharField(max_length=50)),
                ('a_abs', models.CharField(blank=True, max_length=50, null=True)),
                ('a_path', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'article',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Coach',
            fields=[
                ('c_id', models.AutoField(primary_key=True, serialize=False)),
                ('c_name', models.CharField(max_length=20)),
                ('c_img', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'coach',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='CoachTeam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('in_time', models.DateField(blank=True, null=True)),
            ],
            options={
                'db_table': 'coach_team',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Matching',
            fields=[
                ('m_id', models.AutoField(primary_key=True, serialize=False)),
                ('m_time', models.DateTimeField()),
                ('m_state', models.CharField(max_length=10)),
                ('home_score', models.IntegerField()),
                ('away_score', models.IntegerField()),
                ('m_path', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'matching',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='NstMatch',
            fields=[
                ('m_id', models.AutoField(primary_key=True, serialize=False)),
                ('m_time', models.DateTimeField()),
                ('m_path', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'nst_match',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='OverMatch',
            fields=[
                ('m_id', models.AutoField(primary_key=True, serialize=False)),
                ('m_time', models.DateTimeField()),
                ('home_score', models.IntegerField()),
                ('away_score', models.IntegerField()),
                ('m_path', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'over_match',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Player',
            fields=[
                ('p_id', models.AutoField(primary_key=True, serialize=False)),
                ('p_name', models.CharField(max_length=30)),
                ('p_height', models.DecimalField(blank=True, decimal_places=2, max_digits=3, null=True)),
                ('p_weight', models.DecimalField(blank=True, decimal_places=1, max_digits=4, null=True)),
                ('p_number', models.IntegerField()),
                ('p_img', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'player',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='PlayerTeam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('in_time', models.DateField(blank=True, null=True)),
            ],
            options={
                'db_table': 'player_team',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Playoff',
            fields=[
                ('area', models.IntegerField(primary_key=True, serialize=False)),
                ('score1', models.IntegerField(blank=True, null=True)),
                ('score2', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'playoff',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Team',
            fields=[
                ('t_name', models.CharField(max_length=30, primary_key=True, serialize=False)),
                ('t_city', models.CharField(blank=True, max_length=30, null=True)),
                ('t_home', models.CharField(blank=True, max_length=30, null=True)),
                ('t_icon', models.CharField(blank=True, max_length=50, null=True)),
                ('total', models.IntegerField(blank=True, null=True)),
                ('win', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'team',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Users',
            fields=[
                ('u_name', models.CharField(max_length=15, primary_key=True, serialize=False)),
                ('u_password', models.CharField(max_length=50)),
                ('u_mail', models.CharField(blank=True, max_length=30, null=True)),
                ('u_img', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'users',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Written',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('release', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'written',
                'managed': False,
            },
        ),
    ]
