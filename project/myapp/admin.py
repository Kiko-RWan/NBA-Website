from django.contrib import admin
from . import models
# Register your models here.

@admin.register(models.Team)
class TeamAdmin(admin.ModelAdmin):
    list_display = ('t_name', 't_city', 't_home', )
    search_fields = ('t_name',)

@admin.register(models.Coach)
class CoachAdmin(admin.ModelAdmin):
    list_display = ('c_name', )
    search_fields = ('c_name',)


@admin.register(models.Player)
class PlayerAdmin(admin.ModelAdmin):
    list_display = ('p_name', 'p_height', 'p_weight','p_number' )
    search_fields = ('p_name',)
    
@admin.register(models.Users)
class UserAdmin(admin.ModelAdmin):
    list_display = ('u_name', )
    search_fields = ('u_name', )

@admin.register(models.Article)
class ArticleAdmin(admin.ModelAdmin):
    list_display = ('a_title', )


@admin.register(models.Matching)
class MatchingAdmin(admin.ModelAdmin):
    list_display = ('home_name', 'home_score', 'away_name', 'away_score', 'm_time', 'm_state', )


@admin.register(models.NstMatch)
class NstMatchAdmin(admin.ModelAdmin):
    list_display = ('home_name','away_name', 'm_time', )
  
@admin.register(models.OverMatch)
class OverMatchAdmin(admin.ModelAdmin):
    list_display = ('home_name', 'home_score', 'away_name', 'away_score', 'm_time', )

@admin.register(models.Playoff)
class PlayoffAdmin(admin.ModelAdmin):
    list_display = ('area', 't1', 'score1', 't2', 'score2',)
  


# admin.site.register(models.Team)
# admin.site.register(models.Coach)
# admin.site.register(models.Player)
# admin.site.register(models.Users)
# admin.site.register(models.Article)
# admin.site.register(models.CoachTeam)
# admin.site.register(models.Matching)
# admin.site.register(models.NstMatch)
# admin.site.register(models.OverMatch)
# admin.site.register(models.PlayerTeam)
# admin.site.register(models.Playoff)
# admin.site.register(models.Written)


