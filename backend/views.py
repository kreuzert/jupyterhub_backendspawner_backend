import json
import os
import socket
from subprocess import Popen

from django.http import HttpResponse
from rest_framework.views import APIView

from backend.models import Jobs


def send_signal(pid, signal=0):
    """ Check For the existence of a unix pid. """
    try:
        os.kill(int(pid), signal)
    except OSError:
        return False
    else:
        return True


class Health(APIView):
    def get(self, request):
        return HttpResponse("Healthy", status=200)


class Port(APIView):
    def get(self, request):
        """Get a single random port."""
        sock = socket.socket()
        while True:
            try:
                sock.bind(("", 0))
                port = sock.getsockname()[1]
                break
            except OSError:
                pass
        sock.close()
        return HttpResponse(f"{port}", status=200)


class Script(APIView):
    def get(self, request, id):
        job = Jobs.objects.filter(id=id).first()
        if send_signal(job.pid, 0):
            response = HttpResponse("None", status=200)
        else:
            response = HttpResponse("0", status=200)
        return response

    def post(self, request):
        popen_kwargs = json.loads(request.body.decode("utf8"))
        port = popen_kwargs.pop("port")
        args = popen_kwargs.pop("args")
        user_options = {}
        if "user_options" in popen_kwargs:
            user_options = popen_kwargs.pop("user_options")
        if user_options:
            # Do user specific things
            pass
        cmd = [os.environ.get("SCRIPT")]
        cmd.extend(args)
        p = Popen(cmd, **popen_kwargs)
        new_job = Jobs()
        new_job.servername = "test servername"
        new_job.pid = p.pid
        new_job.port = port
        new_job.save()
        response = HttpResponse(f"{new_job.id}", status=202)
        return response

    def delete(self, request, id):
        job = Jobs.objects.filter(id=id).first()
        send_signal(job.pid, 15)
        job.delete()
        response = HttpResponse(status=204)
        return response
