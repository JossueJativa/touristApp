from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from rest_framework_simplejwt.tokens import RefreshToken

from .serializer import UserSerializer

from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password
from django.contrib.auth import authenticate

from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

class UserView(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def create(self, request):
        data = request.data
        username = data['username']
        email = data['email']
        password = data['password']

        if User.objects.filter(username=username).exists():
            return Response({'message': 'Username already exists'}, status=400)
        
        if User.objects.filter(email=email).exists():
            return Response({'message': 'Email already exist'}, status=400)

        password = make_password(password)

        user = User.objects.create(username=username, email=email, password=password)
        user.save()

        return Response({'message': 'User created successfully'}, status=201)
    
    @swagger_auto_schema(
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'username': openapi.Schema(type=openapi.TYPE_STRING, example='usuario123'),
                'password': openapi.Schema(type=openapi.TYPE_STRING, example='password123'),
            },
            required=['username', 'password']
        ),
        responses={
            200: openapi.Response(description='Login successful'),
            400: openapi.Response(description='Invalid credentials')
        }
    )
    @action(detail=False, methods=['post'])
    def login(self, request):
        data = request.data
        username = data['username']
        password = data['password']

        user = authenticate(username=username, password=password)

        if user is not None:
            refresh = RefreshToken.for_user(user)
            return Response({
                'message': 'Login successful',
                'refresh': str(refresh),
                'access': str(refresh.access_token)
            }, status=200)
        else:
            return Response({'message': 'Invalid credentials'}, status=400)
        
    @swagger_auto_schema(
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'refresh': openapi.Schema(
                    type=openapi.TYPE_STRING,
                    example='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsIm'
                ),
            },
            required=['refresh']
        ),
        responses={
            200: openapi.Response(description='Logout successful'),
            400: openapi.Response(description='Invalid token')
        }
    )
    @action(detail=False, methods=['post'])
    def logout(self, request):
        data = request.data
        refresh = data['refresh']

        try:
            token = RefreshToken(refresh)
            token.blacklist()
            return Response({'message': 'Logout successful'}, status=200)
        except:
            return Response({'message': 'Invalid token'}, status=400)
