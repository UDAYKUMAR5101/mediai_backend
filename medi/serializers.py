from rest_framework import serializers
from django.contrib.auth.models import User
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password']

    def validate(self, data):
        errors = {}

        if User.objects.filter(username=data['username']).exists():
            errors['username'] = "Username already exists."

        if User.objects.filter(email=data['email']).exists():
            errors['email'] = "Email already exists."

        if errors:
            raise serializers.ValidationError(errors)  # Raise both errors 

        return data

    def create(self, validated_data):
        return User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )

from rest_framework import serializers
from .models import Profile

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['age', 'image', 'gender', 'date_of_birth', 'notes']

from rest_framework import serializers
from .models import Symptoms

class SymptomsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Symptoms
        exclude = ['user', 'created_at']  # user is set automatically

    def validate(self, data):
        # Normalize inputs (like "yes", "Yes", "YES" → "Yes")
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = value.strip().lower().capitalize()

        return data

# serializers.py
from rest_framework import serializers
from .models import MedicalImage

class MedicalImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = MedicalImage
        fields = ['id', 'image', 'uploaded_at']
        read_only_fields = ['uploaded_at']

from rest_framework import serializers
from django.contrib.auth.models import User

class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True, min_length=8)

    def validate_new_password(self, value):
        if len(value) < 8:
            raise serializers.ValidationError("Password must be at least 8 characters long.")
        return value


