from django.db import models


class Jobs(models.Model):
    servername = models.TextField(default="")
    pid = models.IntegerField()
    port = models.IntegerField()
